require_relative "app/core/game"

require_relative "app/services/game_store"
require_relative "app/services/player_store"
require_relative "app/services/round_store"
require_relative "app/services/turn_store"

require_relative "features/support/clues"

class CelebrityApp < Sinatra::Base
  enable :sessions

  configure do
    set :root, File.dirname(__FILE__)
    set :views, settings.root + "/app/views"
    set :public_dir, settings.root + "/app/public"
    set :session_secret, ENV["SESSION_KEY"]
    set :game_store, GameStore.new
    set :player_store, PlayerStore.new
    set :round_store, RoundStore.new
    set :turn_store, TurnStore.new
    set :min_num_players, 6
  end

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = File.dirname(__FILE__)

    set :seed_data, JSON.parse(File.open(File.expand_path(File.join(File.dirname(__FILE__), "app/lib/scripts/seeds.json"))).read)
  end

  get "/" do
    erb :create_game
  end

  post "/new-game" do
    game = Game.new
    clues = [
      params["clue_1"],
      params["clue_2"],
      params["clue_3"],
      params["clue_4"],
      params["clue_5"]
    ]

    settings.player_store.add(Player.new(game.id, params["player_name"], clues))
    settings.game_store.add(game)
    settings.game_store.add_clues_to_game(game.id, clues)
    redirect to("/games/#{game.id}/pending")
  end

  get "/games/:game_id/pending" do
    @game_id = params["game_id"]
    @players = settings.player_store.find_all_by_game_id(@game_id)

    @min_num_players = settings.min_num_players
    @join_game_url = "/games/#{@game_id}/join"
    @start_game_url = "/games/#{@game_id}/start"

    erb :pending
  end

  get "/games/:game_id/join" do
    erb :join
  end

  post "/games/:game_id/join" do
    game = settings.game_store.find(params[:game_id])
    settings.player_store.add(Player.new(
      game.id,
      params["player_name"],
    ))
    settings.game_store.add_clues_to_game(game.id, [
      params["clue_1"],
      params["clue_2"],
      params["clue_3"],
      params["clue_4"],
      params["clue_5"]
    ])

    redirect to("/games/#{game.id}/pending")
  end

  get "/games/:game_id/start" do
    game_id = params["game_id"]
    players = settings.player_store.find_all_by_game_id(game_id)
    @game = settings.game_store.find(game_id)
    rounds = settings.round_store.find_all_by_game_id(game_id)
    @game.start(players)
    redirect to("/games/#{game_id}/dashboard")
  end

  get "/games/:game_id/dashboard" do
    rounds = settings.round_store.find_all_by_game_id(game_id)
    @start_turn_url = "/games/#{game_id}/turn"
    erb :dashboard
  end

  get "/games/:game_id/turn" do
    @game = settings.game_store.find(params["game_id"])
    @turn = @game.new_turn
    @guessed = @turn.guessed_clue
    @skipped = @turn.skipped_clue
    erb :turn
  end

  get "/clear" do
    session.clear
    redirect to("/")
  end

  get "/how_to_play" do
    erb :how_to_play
  end

  get "/styleguide" do
    erb :styleguide
  end

  get "/sample-game" do
    game = Game.new
    settings.game_store.add(game)
    @game = settings.game_store.find(game.id)
    game_id = @game.id

    creator_clues = Clues.new.creator_clues
    settings.player_store.add(Player.new(game_id, "Star-Lord", creator_clues))
    settings.game_store.add_clues_to_game(game_id, creator_clues)

    player_clues = Clues.new.joined_players_clues

    ["Groot", "Thanos", "Gamora", "Rocket Racoon", "Ronan the Accuser"].each do |player|
      settings.player_store.add(Player.new(
        game_id,
        player,
      ))
      clues = player_clues.shift(5)
      settings.game_store.add_clues_to_game(game_id, clues)
    end

    players = settings.player_store.find_all_by_game_id(game_id)
    @game.start(players)
    @start_turn_url = "/games/#{game_id}/play"

    redirect to("/games/#{game.id}/dashboard")
  end

  get "/play-turn" do
    erb :play_turn
  end

  get "/styles/main.css" do
    scss :"../lib/styles/main.scss"
  end

  get "/example.json" do
    content_type :json
    @game = settings.game_store.list.last
    @game.inspect.to_json
  end
end
