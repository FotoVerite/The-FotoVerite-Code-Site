$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_type, :user
set :rvm_ruby_string, '1.9.2@rails3'        # Or whatever env you want it to run in.
set :stages, %w(staging production)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :application, "Chemical Insights"

default_run_options[:pty] = true

set :scm, "git"
set :repository,  "git@github.com:FotoVerite/The-FotoVerite-Code-Site.git"
set :scm_user, "novafabrica"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :use_sudo, false
# set :scm_verbose, true

namespace :deploy do

  desc "Restart Passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Install Bundle Gems"
  task :bundle, :role => :web do
    run "cd #{latest_release}; bundle install"
  end

  desc "Run Jammit"
  task :jammit, :roles => :web do
    run "cd #{latest_release}; jammit"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is non-functional with mod_rails"
    task t, :roles => :app do ; end
  end

  desc "Install Bundle Gems"
  task :bundle, :role => :web do
    run "cd #{latest_release}; bundle install"
  end

  desc "Create symlinks from the latest release to the shared directory"
  task :create_symlinks do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"

    image_dirs = ['portfolios', 'project-photos']
    image_dirs.each do |image_dir|
      run "mkdir -p #{shared_path}/public/images/#{image_dir}"
      run "rm -rf #{latest_release}/public/images/#{image_dir}"
      run "ln -nfs #{shared_path}/public/images/#{image_dir} #{latest_release}/public/images/#{image_dir}"
    end

  end

end

after "deploy:update_code", "deploy:bundle"
after "deploy:update_code", "deploy:create_symlinks"
after "deploy:update_code", "deploy:jammit"
after "deploy:update_code", "deploy:cleanup"

namespace :delayed_job do
  desc "Start delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start"
  end

  desc "Stop delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop"
  end

  desc "Restart delayed_job process"
  task :restart, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop"
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start"
  end
end


after "deploy:start", "delayed_job:start"
after "deploy:stop", "delayed_job:stop"
after "deploy:restart", "delayed_job:restart"
