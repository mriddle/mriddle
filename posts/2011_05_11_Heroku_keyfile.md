When first running Heroku if you happen to stumble upon this problem have no fear, it's an easy fix!

<b>Problem</b>
<pre>
$ heroku keys:add
No ssh public key found in /home/account/.ssh/id_[rd]sa.pub.
You may want to specify the full path to the keyfile.
</pre>

<b>Solution</b>
If it exists find it and run the command pointing to it or create one by running the following command
<pre>
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/account/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/account/.ssh/id_rsa.
Your public key has been saved in /home/account/.ssh/id_rsa.pub.
The key fingerprint is:
</pre>

Also if you're ever having an issue cloning an existing Heroku app make sure you use the <code>-o</code> argument. Without it I was getting the usual and not very helpful <code>Permission denied (publickey)</code> exception.
So yeah, when pulling down an existing app from Heroku run
<pre>
git clone -o heroku git@heroku.com:appname.git
</pre>
instead of
<pre>
git clone heroku git@heroku.com:appname.git
</pre>

The -o flag sets the remote name to heroku instead of origin, to make it consistent with the remote that the heroku CLI automatically creates.

-Matt