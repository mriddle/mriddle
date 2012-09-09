Free logging on Heroku is limited, with <i>basic</i> giving you 500 lines of history and <i>expanded</i> giving you the ability to tail. If you want to keep anymore then you have to upgrade for $10 a month, which aint bad if your running something that generates money. 

For my blog however I wanted to keep the last week or so of logs and not pay anything so I setup logging with "MongoHQ":https://mongohq.com/ and a gem called "central_logger":https://github.com/customink/central_logger. MongoHQ offer a free shared DB of 16MB which is more than enough for me. Central Logger is a centralized logging gem for rails apps with MongoDB which includes support for Rails 3 and 2.

*Setting it up*
* Create an account on MongoHQ "here":https://mongohq.com/signup
* Install the gem. Add the following to your Gemfile and run <code>bundle install</code> or run <code>gem install central_logger</code>
--- 
gem "central_logger"
---
* Open your <i>applicatication_controller.rb</i> and add
--- Ruby
include CentralLogger::Filter
---
* If using Rails 3 SKIP this step, otherwise add the following to <i>config/environment.rb</i>
--- Ruby
require 'central_logger' CentralLogger::Initializer.initialize_deprecated_logger(config)
---
* Add mongo settings to database.yml for each environment in which you want to use the Central Logger. The central logger will also look for a separate central_logger.yml or mongoid.yml (if you are using mongoid) before looking in database.yml. In the central_logger.yml and mongoid.yml case, the settings should be defined without the 'mongo' subkey.
*database.yml*
--- YML
development:
  adapter: mysql
  database: my_app_development
  user: root
  mongo:
    # required (the only required setting)
    database: my_app     
    # default: 250MB for production; 100MB otherwise - MongoHQ free account caps out at 16MB
    capsize: <%= 10.megabytes %>   
    # default: localhost - May not be flame.mongohq, may be one of there other subdomains
    host: flame.mongohq.com       
    # default: 27017
    port: 27099
    # default: false - Adds retries for ConnectionFailure during voting for replica set master
    replica_set: true  
    # default: false - Enable/Disable safe inserts (wait for insert to propagate to all nodes)   
    safe_insert: true    
    # default: Rails.application - Only really needed for non-capistrano Rails 2 deployments
    # Otherwise should set automatically.
    application_name: my_app  
    # MongoHQ DB username                                      
    username: myusername      
     # MongoHQ DB password     
    password: mypass                 
---
*OR*

*central_logger.yml*
--- YML
development:
    database: my_app
    capsize: <%= 10.megabytes %>
    host: flame.mongohq.com       
    port: 27099
    replica_set: true
    username: myusername        
    password: mypass     

#test:
#......

#production:
#......
---

Remember that people may have access to this file, so storing the DB password in here is not the best idea. 

*That's it*, restart the server and you're good to go. Once the page hits start coming in you will see a new collection developer_log (or w/e you set it up for) with documents being created per request. The log format will look like this
--- 
{
   'action'           : action_name,
   'application_name' : application_name (rails root),
   'controller'       : controller_name,
   'ip'               : ip_address,
   'messages'         : {
                          'info'  : [ ],
                          'debug' : [ ],
                          'error' : [ ],
                          'warn'  : [ ],
                          'fatal' : [ ]
                        },
   'params'           : { },
   'path'             : path,
   'request_time'     : date_of_request,
   'runtime'          : elapsed_execution_time_in_milliseconds,
   'url'              : full_url
}
---

If you want to add extra information to the base of the document (let's say something like user_guid on every request that it's available), you can just call the Rails.logger.add_metadata method on your logger like so (for example from a before_filter):
--- Ruby
# make sure we're using the CentralLogger in this environment
if Rails.logger.respond_to?(:add_metadata)
    Rails.logger.add_metadata(:user_guid => @user_guid)
end
---


-Matt