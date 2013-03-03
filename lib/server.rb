$:.unshift("#{File.dirname(__FILE__)}")
require 'rubygems'

require "sinatra"
require "sinatra/reloader"
require 'rest-client'

require "mia"

enable :sessions

get "/" do
  erb :home
end

get "/status" do
  erb :status, :locals => {:session => session}
end 

# Receive the interactive id of a new session
# GET /callback?interactiveid=e5d552c1-3965-4fd3-8022-1d5adb03fab5&installid=a63e84a3-8e16-44f7-9db6-bcef55dfc61f
get "/callback" do
  session[:interactive_id] = params["interactiveid"] if !params["interactiveid"].nil? && params["interactiveid"].length > 0
  logger.info "Current Interactive Id: #{session[:interactive_id]}"

  "OK: #{session[:interactive_id]}"
end

# Received Interactive Id: {
#   "<VoosMsg>
#     <id>6ad2e28c-d972-45b4-9eb8-719dbc2ea1a9</id>
#     <correlationId></correlationId>
#     <interactiveId>3d46a20e-56ce-47d8-b832-980ef97dbc5f</interactiveId>
#     <event>
#       <code>CANCELLED</code>
#     </event>
#    </VoosMsg>" => nil
# }
post "/callback" do
  xml = request.body.read.to_s
  logger.info "Callback with #{xml}"

  "OK"
end

get "/speak" do
  begin
    text = params["text"]

    url = "http://api.karotz.com/api/karotz/tts"
    params = {:action => "speak", :text => text, :interactiveid => session[:interactive_id]}

    result = RestClient::Request.execute(:method => :get, :url => url, :params => params, :timeout => 60, :open_timeout => 10)

    logger.info "Speak Response: #{result}"

    "OK"
  rescue RestClient::ServerBrokeConnection => message
    logger.info "Failed to speak. May still work though: #{message}"
    "FAILED"
  end
end

not_found do
  status 404
  """
  Hi, my name is Ed. Apparently, I haven't written any code that matches your request.
  <br/>Try going <a href='/'>back to the home page</a>
  """
end

