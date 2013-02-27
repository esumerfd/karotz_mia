$:.unshift("#{File.dirname(__FILE__)}")

require 'rubygems'
require "sinatra"
require "mia"

def "/*" do
  Mia.new.hello
end

get "/hello" do
  Mia.new.hello
end

get "/interactive_id" do
  Mia.new.interactive_id
end

