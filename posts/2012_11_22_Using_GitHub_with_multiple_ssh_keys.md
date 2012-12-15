*Great for managing work and personal accounts*

Create two keys

	$ ssh-keygen -t rsa -C "your_email@youremail.com"
	Generating public/private rsa key pair.
	Enter file in which to save the key (/Users/mriddle/.ssh/id_rsa): id_rsa.work

The keys I created were:

	~/.ssh/id_rsa.work
	~/.ssh/id_rsa.home

If you're starting fresh clear any previously cached keys

	$ ssh-add -D

Add your new SSH keys

	$ ssh-add ~/.ssh/id_rsa.work
	$ ssh-add ~/.ssh/id_rsa.home

Make sure they're added

	$ ssh-add -l

Update the config to use the new keys

	# In this configuration the work key will be my default for github and home is my secondary
	# more on this below
	$ vi ~/.ssh/config

	Host github.com-home
	    HostName github.com
	    User git
	    IdentityFile ~/.ssh/id_rsa.home

	Host github.com
	    HostName github.com
	    User git
	    IdentityFile ~/.ssh/id_rsa.work

	IdentityFile ~/.ssh/id_rsa.work
	IdentityFile ~/.ssh/id_rsa.home

Update the home git repo to make use of our key by adding it to the repo git config

	$ .git/config
	[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = git@github.com-home:mriddle/blog.git

**Note:**
You only need to update the git config with key we setup as our secondary, in this case my home key.
I can leave the .git/config alone for work projects.

Hope this helps :)

-Matt


