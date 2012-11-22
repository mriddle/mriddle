Hey guys, the blog updates have slowed since I found Minecraft. Fairly addictive. Just a quick one today.

To monitor a remote Java application with VisualVM, simply use [jstatd](http://java.sun.com/javase/6/docs/technotes/tools/share/jstatd.html)

Start jstatd on the remote machine, make a connection from VisualVM to the remote machine and we can then monitor all running Java applications.

If you try starting jstatd without specifying a policy you may get the following error.

	$ ./jstatd
	Could not create remote object
	access denied (java.util.PropertyPermission java.rmi.server.ignoreSubClasses write)
	java.security.AccessControlException: access denied 
	                (java.util.PropertyPermission java.rmi.server.ignoreSubClasses write)
		at java.security.AccessControlContext.checkPermission(AccessControlContext.java:342)
		at java.security.AccessController.checkPermission(AccessController.java:553)
		at java.lang.SecurityManager.checkPermission(SecurityManager.java:549)
		at java.lang.System.setProperty(System.java:744)
		at sun.tools.jstatd.Jstatd.main(Jstatd.java:139)

Create a security policy file if one does not already exist called 'jstatd.all.policy' (same location as jstatd).
Add the following to the file:

	grant codebase "file:${java.home}/../lib/tools.jar" {

	   permission java.security.AllPermission;

	};

Then simply run jstatd with:

	$ ./jstatd -J-Djava.security.policy=jstatd.all.policy &


You can test the connection using the following command

	$ jps -l -m -v rmi://localhost

If you're experiencing problems make sure you run jstatd with the same user as the java processes.
It could be that the ports used my jstatd are blocked by your firewall. jstatd uses two ports, the once specified and a random port. Check the ports by running the following command

	$ netstat -nap | grep jstatd
	tcp        0      0 :::47232    :::*   LISTEN      23185/jstatd        
	tcp        0      0 :::1099      :::*     LISTEN      23185/jstatd  

**EDIT:**
You can find the log files for visualvm here

Linux

[userdir]/.visualvm/[version]/var/log/messages.log 

Windows

C:\Users\[username]\AppData\Roaming\.visualvm\[version]\var\log\messages.log

-Matt