require 'spec_helper'
require 'rack/test'
require 'sinatra'

require 'server'

set :environment, :test
set :views, "lib/views"

describe "Server" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "home page" do

    it "shows welcome message" do
      get "/"

      last_response.body.should include("Welcome to Mia")
    end
  end

  context "interactive_id request" do
    it "returns" do
      get "/interactive_id"

      last_response.body.should include("test_")
    end

    it "returns a different id each time" do
      get "/interactive_id"
      interactive_id = last_response.body

      get "/interactive_id"
      last_response.body.should_not == interactive_id
    end
  end

  context "custom 404" do

    it "fails with a custom 404" do
      get "/invalid_URL"

      last_response.body.should include("Apparently, I haven't written")
    end
  end
end
