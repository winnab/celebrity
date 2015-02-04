begin
  require "sinatra"
rescue LoadError
  require "rubygems"
  require "sinatra"
  require "sinatra/contrib/all"
end

require "pony"

enable :sessions
set :session_secret, ENV["SESSION_KEY"]

Pony.options = {
  from: "winnab@gmail.com",
  via: :smtp,
  via_options: {
    address: "smtp.mandrillapp.com",
    port: "25",
    enable_starttls_auto: true,
    user_name: ENV["MANDRILL_USERNAME"],
    password: ENV["MANDRILL_APIKEY"],
    authentication: "plain"
  }
}

get "/" do
  erb :index
end


def self.get_or_post(url,&block)
  get(url,&block)
  post(url,&block)
end

get_or_post "/game_overview" do
  session["creator_name"] = params["creator_name"] unless params["creator_name"].nil?
  @name = session["creator_name"]
  @players = []
  @players << params["invite-email"] unless params["invite-email"].nil?
post "/invite" do
  @players = []
  if params["invite-email"].size > 0
    @players << params["invite-email"]
    Pony.mail(
      to: params["invite-email"],
      from: Pony.options.from,
      subject: "Join my game!",
      body: "Hey this is a link!"
    )
  end
  erb :game_overview
end

get "/how_to_play" do
  erb :how_to_play
end
