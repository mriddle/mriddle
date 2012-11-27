class Site
  require 'json'

  attr_reader :title, :about, :slogan, :twitter, :github, :linked_in

  def initialize
    site_config = File.read("config/site_config.json")
    site_config = JSON.parse(site_config)
    @title            = site_config["site_title"]
    @about            = site_config["site_about"]
    @slogan           = site_config["site_slogan"]
    @twitter          = site_config["twitter"]
    @linked_in        = site_config["linked_in"]
    @github           = site_config["github"]
  end

end