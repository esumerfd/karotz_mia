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

  context "callback" do

    context "post" do
      let(:voosmsg_cancelled) do
        """<VoosMsg><id>6ad2e28c-d972-45b4-9eb8-719dbc2ea1a9</id><correlationId></correlationId><interactiveId>3d46a20e-56ce-47d8-b832-980ef97dbc5f</interactiveId><event><code>CANCELLED</code></event></VoosMsg>"""
      end

      it "posts voosmsg cancelled" do
        post "/callback", voosmsg_cancelled, "CONTENT_TYPE" => "application/xml"

        last_response.body.should include("OK")
      end
    end

    context "get" do

      it "accepts the install id and returns it" do
        get "/callback", {"interactiveid" => "INTERACTIVE_ID", "installid" => "a63e84a3-8e16-44f7-9db6-bcef55dfc61f"}

        last_response.body.should include("OK: INTERACTIVE_ID")
      end

      it "does not overwrite the current interctiveid is one is not supplied" do
        get "/callback", {"interactiveid" => "INTERACTIVE_ID", "installid" => "a63e84a3-8e16-44f7-9db6-bcef55dfc61f"}
        get "/callback", {"interactiveid" => "", "installid" => "a63e84a3-8e16-44f7-9db6-bcef55dfc61f"}

        last_response.body.should include("OK: INTERACTIVE_ID")
      end

      it "handles no interactive id at all" do
        get "/callback"

        last_response.body.should include("OK: ")
      end
    end
  end

  context "status request" do
    it "retrieves session information" do
      get "/status"

      last_response.body.should include("Interactive ID")
    end
  end

  context "custom 404" do

    it "fails with a custom 404" do
      get "/invalid_URL"

      last_response.body.should include("Apparently, I haven't written")
    end
  end
end
