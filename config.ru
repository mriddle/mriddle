require 'rubygems'
require 'bundler'
require 'newrelic_rpm'

Bundler.require

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require './app/blog'

map "/assets" do
  run Blog.sprockets
end

run Blog
