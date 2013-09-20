---
layout: post
title:  "Rails Rake Tasks reference"
---

<b>Quick reference and explanation of rake tasks</b>

<pre>
#Clears all cached pages
rake cache:clear
#Loads a schema.rb file into the database and then loads the initial database fixtures.
rake db:bootstrap
#Copy default theme to site theme
rake db:bootstrap:copy_default_theme
#Migrate the database through scripts in db/migrate. Target specific version with VERSION=x
rake db:migrate
#Create a db/schema.rb file that can be portably used against any DB supported by AR
rake db:schema:dump
#Load a schema.rb file into the database
rake db:schema:load
#Load initial database fixtures (in db/bootstrap/*.yml) into the current environment's database.
#Load specific fixtures using FIXTURES=x,y
rake db:bootstrap:load
#Load fixtures into the current environment's database.
#Load specific fixtures using FIXTURES=x,y
rake db:fixtures:load
#Clear the sessions table
rake db:sessions:clear
#Creates a sessions table for use with CGI::Session::ActiveRecordStore
rake db:sessions:create
#Dump the database structure to a SQL file
rake db:structure:dump
#Recreate the test database from the current environment's database schema
rake db:test:clone
#Recreate the test databases from the development structure
rake db:test:clone_structure
#Prepare the test database and load the schema
rake db:test:prepare
#Empty the test database
rake db:test:purge
#Push the latest revision into production using the release manager
rake deploy
#Describe the differences between HEAD and the last production release
rake diff_from_last_deploy
#Build the app HTML Files
rake doc:app
#Remove rdoc products
rake doc:clobber_app
#Remove plugin documentation
rake doc:clobber_plugins
#Remove rdoc products
rake doc:clobber_rails
#Generate documation for all installed plugins
rake doc:plugins
#Build the rails HTML Files
rake doc:rails
#Force a rebuild of the RDOC files
rake doc:reapp
#Force a rebuild of the RDOC files
rake doc:rerails
#Freeze rails edge
rake edge
#Truncates all *.log files in log/ to zero bytes
rake log:clear
#Lock to latest Edge Rails or a specific revision with REVISION=X (ex: REVISION=4021) or
# a tag with TAG=Y (ex: TAG=rel_1-1-0)
rake rails:freeze:edge
#Lock this application to the current gems (by unpacking them into vendor/rails)
rake rails:freeze:gems
#Unlock this application from freeze of gems or edge and return to a fluid use of system gems
rake rails:unfreeze
#Update both configs, scripts and public/javascripts from Rails
rake rails:update
#Update config/boot.rb from your current rails install
rake rails:update:configs
#Update your javascripts from your current rails install
rake rails:update:javascripts
#Add new scripts to the application script/ directory
rake rails:update:scripts
#Execute a specific action using the release manager
rake remote_exec
#Rollback to the release before the current release in production
rake rollback
#Enumerate all available deployment tasks
rake show_deploy_tasks
#Report code statistics (KLOCs, etc) from the application
rake stats
#Test all units and functionals
rake test
#Run tests for functionalsdb:test:prepare
rake test:functionals
#Run tests for integrationdb:test:prepare
rake test:integration
#Run tests for pluginsenvironment
rake test:plugins
#Run tests for recentdb:test:prepare
rake test:recent
#Run tests for uncommitteddb:test:prepare
rake test:uncommitted
#Run tests for unitsdb:test:prepare
rake test:units
#Clears all files and directories in tmp/cache
rake tmp:cache:clear
#Clear session, cache, and socket files from tmp/
rake tmp:clear
#Creates tmp directories for sessions, cache, and sockets
rake tmp:create
#Clears all files in tmp/pids
rake tmp:pids:clear
#Clears all files in tmp/sessions
rake tmp:sessions:clear
#Clears all files in tmp/sockets
rake tmp:sockets:clear
#Copies the latest dialog.js to the application's public directory
rake update_dialog_helper
</pre>

-Matt


