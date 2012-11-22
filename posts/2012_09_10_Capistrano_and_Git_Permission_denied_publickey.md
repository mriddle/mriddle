Morning all,

Wasted a little bit of time on this one this morning. Trying to ship some code to production using capistrano and git kept getting the following error

`Permission denied (publickey)`

It annoyed me because I was following the git documentation and included the following options in my delpoy.rb

```
#Tell cap your own private keys for git and use agent forwarding with this command.
ssh_options[:forward_agent] = true

# Must be set for the password prompt from git to work
default_run_options[:pty] = true  
                                  
set :repository, "git@github.com:user/repo.git"  # Your clone URL
set :scm, "git"
set :user, "deployer"  # The server's user for deploys
```

I also tested my local key to be sure I wasn't crazy using.

`$ ssh -vT git@github.com`

Turns out I needed to run the following in order to register my public key for forwarding. This really ought to be added to GitHub guides IMO.

`$ ssh-add`

After that I was shipping like a baws (read boss)

-Matt