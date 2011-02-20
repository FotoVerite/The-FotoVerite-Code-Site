set :branch, "master"
set :deploy_to, "/var/www/fotoverite_production"
set :user, "deploy"
set :port, 21500
set :rails_env, 'production'

role :app, "www.fotoverite.com"
role :web, "www.fotoverite.com"
role :db,  "www.fotoverite.com", :primary => true
