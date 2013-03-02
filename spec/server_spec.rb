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
    it "receives" do
      post "/interactive_id"

      last_response.body.should include("OK")
    end
  end

  context "callback" do
    it "accepts the install id and returns it" do
      get "/callback?interactiveid=&installid=a63e84a3-8e16-44f7-9db6-bcef55dfc61f"

      last_response.body.should include("installid=a63e84a3-8e16-44f7-9db6-bcef55dfc61f")
    end
  end

  context "custom 404" do

    it "fails with a custom 404" do
      get "/invalid_URL"

      last_response.body.should include("Apparently, I haven't written")
    end
  end
end
