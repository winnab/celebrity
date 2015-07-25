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
  end

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = File.dirname(__FILE__)

    set :seed_data, JSON.parse(File.open(File.expand_path(File.join(File.dirname(__FILE__), "app/lib/scripts/seeds.json"))).read)
  end


  get "/" do
    erb :create_game
  end

  get "/clear" do
    session.clear
    redirect to("/")
  end

  post "/game_overview" do
    clues = [
      params["clue_1"],
      params["clue_2"],
      params["clue_3"],
      params["clue_4"],
      params["clue_5"]
    ]

    game = Game.new({
      name: params["player_name"],
      clues: clues
    })

    settings.player_store.add(Player.new(game.id, params["player_name"], clues))
    settings.game_store.add(game)

    redirect to("/game_overview/#{ game.id }")
  end

  get "/game_overview/:game_id" do
    game = settings.game_store.find(params["game_id"])
    @game_id = game.id

    @game_join_url = "/join/#{game.id}"

    @players = settings.player_store.find_all_by_game_id(game.id)
    @status = @players.length < 5 ? 'Waiting for players' : 'Ready to play!'

    erb :game_overview
  end

  get "/how_to_play" do
    erb :how_to_play
  end

  get "/join/:game_id" do
    game = settings.game_store.find(params["game_id"])
    @creator_name = settings.player_store.find_all_by_game_id(game.id).first.name
    erb :join
  end

  post "/join/:game_id" do
    game = settings.game_store.find(params[:game_id])
    settings.player_store.add(Player.new(
      game.id,
      params["player_name"],
      [
        params["clue_1"],
        params["clue_2"],
        params["clue_3"],
        params["clue_4"],
        params["clue_5"]
      ]
    ))

    redirect to("/game_overview/#{game.id}")
  end

  get "/styleguide" do
    erb :styleguide
  end

  get "/sample-game" do
    seeds = settings.seed_data.dup
    creator = seeds[0];
    @game = Game.new({
      name: creator["name"],
      clues: creator["clues"]
    })
    settings.game_store.add(@game)
    @game.id = 123;
    @game.start(seeds)
    erb :active_game_overview
  end

  get "/play-turn" do
    erb :play_turn
  end

  get "/styles/main.css" do
    scss :"../lib/styles/main.scss"
  end
end
