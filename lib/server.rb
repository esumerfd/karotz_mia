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

post "/interactive_id" do
  session[:interactive_id] = params["interactive_id"]
  logger.info "Received Interactive Id: #{params}"
  "OK #{params} : #{session}"
end

# Request made from Karotz Central ith interactive id.
# GET /interactive_id?interactiveid=&installid=a63e84a3-8e16-44f7-9db6-bcef55dfc61f
get "/callback" do
  "installid=#{params['installid']}"
end

not_found do
  status 404
  """
  Hi, my name is Ed. Apparently, I haven't written any code that matches your request.
  <br/>Try going <a href='/'>back to the home page</a>
  """
end

