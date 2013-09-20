---
layout: post
title:  "Running VisualVM through an SSH tunnel"
---

So I had troubles connecting to my Java app on Amazon EC2 due to the firewall. I modified the security group to allow the default port of 1099 but was still unable to connect to due the random port opened and used by RMI (Remote Method Invocation). There was no way I was going l to open up all TCP ports so I could monitor my app remotely so I decided to go down a different path.

To connect to your app via an SSH tunnel on Linux simply do the following. In this example I use 9696 as my port, you can change it if you like. For windows I suggest you use putty or openssh! Or just roll Linux :P

Connect to your remote machine where your Java Application is running

	$ sudo ssh -D 9696 your.ip.goes.here -i .ssh/yourkeyfileifyougotone.pem

As in the previous example make sure you create a file called **jstatd.all.policy** in *$JAVA_HOME/bin* with the following contents:

	grant codebase "file:${java.home}/../lib/tools.jar" { permission java.security.AllPermission;};

Run jstatd using the following command (within the server terminal)

	$ sudo jstatd -p 1099 -J-Djava.security.policy=/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0/
 	 bin/jstatd.all.policy &

Then simply run VisualVM from your desktop running the following command

**Linux**

	$ jvisualvm -J-Dnetbeans.system_socks_proxy=localhost:9696 -J-Djava.net.useSystemProxies=true

**Windows**

	visualvm.exe -J-Dnetbeans.system_socks_proxy=localhost:9696 -J-Djava.net.useSystemProxies=true

That's it!

If it doesn't work or you did something different let me know. So we can share the knowledge.

-Matt