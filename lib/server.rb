$:.unshift("#{File.dirname(__FILE__)}")

require 'rubygems'

require "sinatra"
require "sinatra/reloader"

require "mia"

get "/" do
  erb :home
end

get "/interactive_id" do
  Mia.new.interactive_id
end

not_found do
  status 404
  "Hi, my name is Ed. Apparently, I haven't written any code that matches your request."
end

