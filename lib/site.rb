class Site
  require 'json'

  attr_reader :title, :about, :slogan, :twitter, :github, :linked_in, :rss_title, :rss_author, :rss_about

  def initialize
    site_config = File.read("config/site_config.json")
    site_config = JSON.parse(site_config)
    @title            = site_config["site_title"]
    @about            = site_config["site_about"]
    @slogan           = site_config["site_slogan"]
    @twitter          = site_config["twitter"]
    @linked_in        = site_config["linked_in"]
    @github           = site_config["github"]
    @rss_title        = site_config["rss_title"]
    @rss_author       = site_config["rss_author"]
    @rss_about        = site_config["rss_about"]
  end

end