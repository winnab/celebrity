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
  "Celebrity!"
end

