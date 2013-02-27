require 'spec_helper'
require 'rack/test'
require 'sinatra'

describe "Server" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "returns hello" do
    get "/hello"

    last_response.body.should include("hello, this is Mia")
  end
end
