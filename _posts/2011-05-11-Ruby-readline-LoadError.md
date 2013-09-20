---
layout: post
title:  "Ruby readline LoadError"
---

The following error seems to be a common problem with many different fixes on the net. I ran into it today with Rails3/Ruby1.9 installed with RVM.

<pre>
/usr/local/rvm/rubies/ruby-1.9.2-p180/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require': no such file to load -- readline (LoadError)
from /usr/local/rvm/rubies/ruby-1.9.2-p180/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/lib/heroku/command/run.rb:1:in `<top (required)>'
from /usr/local/rvm/rubies/ruby-1.9.2-p180/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
from /usr/local/rvm/rubies/ruby-1.9.2-p180/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/lib/heroku/command.rb:17:in `block in load'
from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/lib/heroku/command.rb:16:in `each'
from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/lib/heroku/command.rb:16:in `load'
from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/bin/heroku:13:in `<top (required)>'
from /usr/local/rvm/gems/ruby-1.9.2-p180/bin/heroku:19:in `load'
</pre>


I found a nifty web site that has a long list of the problems, how they were caused and resolved. Check it out  <a href="http://rbjl.net/20-rubybuntu-2-troubleshooting-common-ruby-ubuntu-problems" alt="lawl its a link">here</a> 

Although none of them really helped resolve my issue. I resolved mine by running the following commands

<pre>
$ sudo apt-get install openssl libssl-dev libreadline5-dev zlib1g-dev
$ rvmsudo rvm remove 1.9.2 
$ rvmsudo rvm cleanup all
$ rvmsudo rvm  install 1.9.2 
</pre>


<b>Note</b> only use <i>rvmsudo</i> if <i>rvm</i> wasn't installed using the root account. If it was just use <i>rvm</i> instead.

-Matt