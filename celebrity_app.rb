require_relative "app/core/game"

require_relative "app/services/game_store"
require_relative "app/services/player_store"

class CelebrityApp < Sinatra::Base
  enable :sessions

  configure do
    set :root, File.dirname(__FILE__)
    set :views, settings.root + "/app/views"
    set :public_dir, settings.root + "/app/public"
    set :session_secret, ENV["SESSION_KEY"]
    set :game_store, GameStore.new
    set :player_store, PlayerStore.new
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

  post "/game_overview" do
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
    redirect to("/game_overview/#{ game.id }")
  end

  get "/game_overview/:game_id" do
    @game_id = params["game_id"]
    @players = settings.player_store.find_all_by_game_id(@game_id)

    @min_num_players = settings.min_num_players
    @join_game_url = "/join/#{@game_id}"
    @start_game_url = "/#{@game_id}/start"

    erb :game_overview
  end

  get "/:game_id/start" do
    game_id = params["game_id"]
    players = settings.player_store.find_all_by_game_id(game_id)
    @game = settings.game_store.find(game_id)
    @game.start(players)
    erb :game_dashboard
  end

  get "/join/:game_id" do
    erb :join
  end

  post "/join/:game_id" do
    game = settings.game_store.find(params[:game_id])
    settings.player_store.add(Player.new(
      params[:game_id],
      params["player_name"],
    ))
    settings.game_store.add_clues_to_game(game.id, [
      params["clue_1"],
      params["clue_2"],
      params["clue_3"],
      params["clue_4"],
      params["clue_5"]
    ])

    redirect to("/game_overview/#{params[:game_id]}")
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

  end

  get "/play-turn" do
    erb :play_turn
  end

  get "/styles/main.css" do
    scss :"../lib/styles/main.scss"
  end
end
