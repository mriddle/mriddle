G'day peeps,

Had an issue today running our offline cucumber tests with Selenium and Firefox. The message *"This website (127.0.0.1) is asking to store data on your computer for offline use."* kept coming up with firefox version 7+. To allow it I made the following modification to our firefox profile.

First create a custom profile (selenium_firefox_profile) with an sqllite DB.

```
$ mkdir selenium_firefox_profile
$ cd selenium_firefox_profile
$ sqlite3 permissions.sqlite3 # This filename is important
sqlite> CREATE TABLE moz_hosts ( id INTEGER PRIMARY KEY,host TEXT,type TEXT, 
permission INTEGER, expireType INTEGER, expireTime INTEGER);
sqlite> INSERT INTO "moz_hosts" VALUES(1,'127.0.0.1','offline-app',1,NULL,NULL);
sqlite> .quit
```

Setup Cabybara with your new custom profile

```
Capybara.register_driver :selenium_firefox_profile do |app|
  require 'selenium/webdriver'
  profile_path = "/path/to/selenium_firefox_profile"
  profile = Selenium::WebDriver::Firefox::Profile.new(profile_path)
  driver = Capybara::Driver::Selenium.new(app, :profile => profile)

  driver
end

# And set the default driver to our new one:

Capybara.default_driver = :selenium_firefox_profile
```

Everything should be gravy :)

-Matt