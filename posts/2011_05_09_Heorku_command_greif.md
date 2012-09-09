After installing Heroku on Ubuntu following I kept getting the following error when trying to use it on the command line:
<i>
WARNING: Unable to verify SSL certificate for api.heroku.com
To disable SSL verification, run with HEROKU_SSL_VERIFY=disable
</i>

I tried to Google it but found no results, I didn't understand why it was occurring in the first place. To get around it though simply do as it says and type "HEROKU_SSL_VERIFY=disable" before you execute your command. For example
<code>
$ HEROKU_SSL_VERIFY=disable heroku create
</code>

This works for executing that single line only. Either run 
<code> $ export HEROKU_SSL_VERIFY=disable </code>
to save you adding it before each command for that session or just add it to the bottom your bashrc file to not have to worry about it again.
<code> $ vim ~/.bashrc # Add export HEROKU_SSL_VERIFY=disable to the bottom of the file </code>

-Matt
