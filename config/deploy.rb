set :application, "mia"
set :ip_address , "mia.bitbashers.org"
 
set :scm, :git
set :repository,  "git@github.com:esumerfd/karotz_mia.git"
set :branch, "master"
set :deploy_via, :remote_cache
 
set :user , "karotz"
set :deploy_to, "/home/karotz/#{application}"
   
set :shared_directory, "#{deploy_to}/shared"
set :use_sudo, false
set :group_writable, false
set :scm_verbose, true
default_run_options[:pty] = true
 
server :app, :web, ip_address, :primary => true

namespace :deploy do
  task :restart, :roles => :app do
    run "mkdir -p #{release_path}/tmp && touch #{release_path}/tmp/restart.txt"
  end
end

