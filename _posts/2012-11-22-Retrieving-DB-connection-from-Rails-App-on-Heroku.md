---
layout: post
title:  "Retrieving DB connection from Rails App on Heroku"
---

G'day,

Ran into this one today at LP while attempting to get one of our applications out on Heroku. We are using a fairly old gem called spatial_adapter which is no longer under active development. 

We were failing to 'get it up' (ha!) due to it barfing while setting up the spatial_adapter railtie.

The stack trace we were getting was
	
    /app/vendor/bundle/ruby/1.9.1/bundler/gems/spatial_adapter-d64ac1c03c83/lib/spatial_adapter/railtie.rb:5:in `block (2 levels) in <class:Railtie>': undefined method `[]' for nil:NilClass (NoMethodError)
    
I forked the repo and updated the railtie to grab the configuration in the correct manner

    #Busted
    ActiveRecord::Base.configurations[Rails.env]['adapter']
    #Works
    Rails.configuration.database_configuration[Rails.env]['adapter']
    
    
Fixed! Although I don't know how many others will run into the same problem :)

-Matt