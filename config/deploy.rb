require "bundler/capistrano"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :application, "blog"
set :repository,  "git@github.com:mriddle/blog.git"
set :scm, :git
set :user, "admin"

set :deploy_to, "/var/www"
set :deploy_via, :remote_cache
set :branch, "master"

set :rails_env, 'production'
server "203.143.82.172", :app, :web, :db, :primary => true

%w{ helpers unicorn chef}.each do |f|
  require File.expand_path("../deploy/#{f}", __FILE__)
end

before('deploy:finalize_update', :chef)
