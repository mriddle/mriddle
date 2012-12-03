require "bundler/capistrano"
require './lib/site'

site_config = Site.new.config

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :application, site_config['app_name']
set :repository,  site_config['app_repo']
set :scm, :git
set :user, "admin"

set :deploy_to, "/var/www"
set :deploy_via, :remote_cache
set :branch, "master"

set :rails_env, 'production'
server site_config['app_server'], :app, :web, :db, :primary => true

%w{ helpers unicorn chef}.each do |f|
  require File.expand_path("../deploy/#{f}", __FILE__)
end

before('deploy:finalize_update', :chef)
