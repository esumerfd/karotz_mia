$:.unshift("#{File.dirname(__FILE__)}")

require 'rubygems'

require "sinatra"
require "sinatra/reloader"

require "mia"

get "/" do
  """
  Welcome to Mia, and world domination.
  <br/>- Karotz talking around the world.
  """
end

get "/hello" do
  Mia.new.hello
end

get "/interactive_id" do
  Mia.new.interactive_id
end

