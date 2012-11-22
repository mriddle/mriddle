Hey guys,

Ran into this one today where I wanted to run a cucumber test from one of our remote agents on AWS.

I was ssh'ing into it as ubuntu and then swapping the user `sudo su jenkins-node` and running my feature.

I kept getting the following error

`X11 connection rejected because of wrong authentication.`

This was fixed by running the following

```
#As ubuntu user
xauth list|grep `uname -n`
#Copy the hex key

sudo su jenkins-node
DISPLAY=:0; export DISPLAY
xauth add $DISPLAY . hexkey
```

I was then able to run X as jenkins-node :)

Hope this helps others

-Matt