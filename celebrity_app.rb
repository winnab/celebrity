begin
  require "sinatra"
rescue LoadError
  require "rubygems"
  require "sinatra"
  require "sinatra/contrib/all"
end

enable :sessions
set :session_secret, '*&(^T314' # from here: https://stackoverflow.com/questions/18044627/sinatra-1-4-3-use-racksessioncookie-warning

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
  erb :game_overview
end

get "/how_to_play" do
  erb :how_to_play
end
