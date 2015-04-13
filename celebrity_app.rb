require_relative "app/core/game"
require_relative "app/core/invite"

require_relative "app/services/game_store"
require_relative "app/services/invite_store"
require_relative "app/services/invite_mailer"

class CelebrityApp < Sinatra::Base
  enable :sessions

  configure do
    set :root, File.dirname(__FILE__)
    set :views, settings.root + "/app/views"
    set :public_dir, settings.root + "/app/public"
    set :session_secret, ENV["SESSION_KEY"]
    set :game_store, GameStore.new
    set :invite_store, InviteStore.new
    set :invite_mailer, InviteMailer.new
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
    game = Game.new({
      name: params["creator_name"],
      clues: [
        params["clue_1"],
        params["clue_2"],
        params["clue_3"],
        params["clue_4"],
        params["clue_5"]
      ]
    })

    settings.game_store.add(game)

    invite_recipients = [{
      name: "friend_1",
      email: params["friend_1"]
    },
    {
      name: "friend_2",
      email: params["friend_2"]
    },
    {
      name: "friend_3",
      email: params["friend_3"]
    },
    {
      name: "friend_4",
      email: params["friend_4"]
    },
    {
      name: "friend_5",
      email: params["friend_5"]
    },
    {
      name: "friend_6",
      email: params["friend_6"]
    }]

    invite_recipients.each do | r |
      invite = Invite.new({
        name: params["creator_name"],
        email: params["creator_email"]
      }, r, game.id)
      settings.invite_store.add(invite)
      settings.invite_mailer.send_mail r[:email], game.id
    end

    redirect to("/game_overview/#{ game.id }")
  end

  get "/game_overview/:game_id" do
    game = settings.game_store.find(params["game_id"])
    invites = settings.invite_store.find_all_by_game_id(params["game_id"])
    @player_names = game.players.map(&:name)
    @invited_names_and_emails = invites.map { | i | { name: i.recipient[:name], email: i.recipient[:email] } }
    @game_id = game.id
    @status = game.players.length < 5 ? 'Waiting for players' : 'Ready to play!'
    erb :game_overview
  end

  get "/how_to_play" do
    erb :how_to_play
  end

  post "/invite/:game_id" do
    game = settings.game_store.find(params["game_id"])

    new_invite = Invite.new({
        name: params[:sender_name],
        email: params[:sender_email]
      }, {
        name: params[:invite_name],
        email: params[:invite_email]
      },
      game.id
    )
    settings.invite_store.add(new_invite)

    settings.invite_mailer.send_mail params["invite_email"], game.id
    redirect to("/game_overview/#{game.id}")
  end

  get "/join/:game_id/:email" do
    game = settings.game_store.find(params["game_id"])
    erb :join
  end

  post "/join/:game_id/:email" do
    game = settings.game_store.find(params[:game_id])
    invite = settings.invite_store.find_by_email_and_game_id(params[:email], params[:game_id]).first
    game.create_players([{
      name: invite.recipient[:name],
      clues: [
        params["clue_1"],
        params["clue_2"],
        params["clue_3"],
        params["clue_4"],
        params["clue_5"]
      ]
    }])
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
