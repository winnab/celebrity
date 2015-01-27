begin
  require "sinatra"
rescue LoadError
  require "rubygems"
  require "sinatra"
  require "sinatra/contrib/all"
end

get "/" do
  "Celebrity!"
end

