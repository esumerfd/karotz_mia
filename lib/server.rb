$:.unshift("#{File.dirname(__FILE__)}")

require 'rubygems'
require "sinatra"
require "mia"

get "/hello" do
  Mia.new.hello
end

