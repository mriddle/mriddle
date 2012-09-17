Mac OSX Lion comes with postgres (9.1) which will you shouldn't use because you will run into permission related issues down the track.

To get around this update your path and install postgres as shown below:

Installing PostgreSQL (9.2) 

<pre>
echo 'export PATH="/usr/bin/local:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
brew install postgres
echo "Life complete"
</pre>

-Matt

