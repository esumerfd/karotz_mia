$:.unshift("#{File.dirname(__FILE__)}")

require 'rubygems'

require "sinatra"
require "sinatra/reloader"

require "mia"

enable :sessions

get "/" do
  erb :home, :locals => {:interactive_id => session[:interactive_id] }
end

get "/status" do
  erb :status, :locals => {:session => session}
end 

# Request made from Karotz Central ith interactive id.
# GET /interactive_id?interactiveid=&installid=a63e84a3-8e16-44f7-9db6-bcef55dfc61f
post "/interactive_id" do
  session[:interactive_id] = params["interactive_id"]
  logger.info "Received Interactive Id: #{params}"
  "OK #{params} : #{session}"
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
get "/callback" do
  logger.info "Callback with : #{params}"
  "installid=#{params['installid']}"
end

not_found do
  status 404
  """
  Hi, my name is Ed. Apparently, I haven't written any code that matches your request.
  <br/>Try going <a href='/'>back to the home page</a>
  """
end

