The following error seems to be a common problem with many different fixes on the net. I ran into it today with Rails3/Ruby1.9 installed with RVM.

<code>/usr/local/rvm/rubies/ruby-1.9.2-p180/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require': no such file to load -- readline (LoadError)</code><br />
<code>from /usr/local/rvm/rubies/ruby-1.9.2-p180/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'</code><br />
<code>from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/lib/heroku/command/run.rb:1:in `<top (required)>'</code><br />
<code>from /usr/local/rvm/rubies/ruby-1.9.2-p180/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'</code><br />
<code>from /usr/local/rvm/rubies/ruby-1.9.2-p180/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'</code><br />
<code>from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/lib/heroku/command.rb:17:in `block in load'</code><br />
<code>from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/lib/heroku/command.rb:16:in `each'</code><br />
<code>from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/lib/heroku/command.rb:16:in `load'</code><br />
<code>from /usr/local/rvm/gems/ruby-1.9.2-p180/gems/heroku-2.1.1/bin/heroku:13:in `<top (required)>'</code><br />
<code>from /usr/local/rvm/gems/ruby-1.9.2-p180/bin/heroku:19:in `load'</code>


I found a nifty web site that has a long list of the problems, how they were caused and resolved. Check it out  <a href="http://rbjl.net/20-rubybuntu-2-troubleshooting-common-ruby-ubuntu-problems" alt="lawl its a link">here</a> 

Although none of them really helped resolve my issue. I resolved mine by running the following commands

<code>$ sudo apt-get install openssl libssl-dev libreadline5-dev zlib1g-dev</code><br />
<code>$ rvmsudo rvm remove 1.9.2 </code><br />
<code>$ rvmsudo rvm cleanup all</code> <br />
<code>$ rvmsudo rvm  install 1.9.2 </code><br />


<b>Note</b> only use <code>rvmsudo</code> if <code>rvm</code> wasn't installed using the root account. If it was just use <code>rvm</code> instead.

-Matt