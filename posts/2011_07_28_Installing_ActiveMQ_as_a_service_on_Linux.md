**Description**

Apache ActiveMQ is a complete message broker and full JMS 1.1 provider featuring clustering, distributed destinations and XA support with pluggable persistence (JDBC, BDB, JDBM) and transport layers (TCP, UDP, multicast, NIO, SSL, Zeroconf, JXTA, JGroups).

**Installation**

*This installation was done on Ubuntu x64, may be different for other Linux distributions.
The instructions will vary a little depending on system architecture (32 or 64 bit)*

If you haven't done so already download ActiveMQ from [here](http://activemq.apache.org/download.html)
extract the download to a directory of your choice. I placed mine in /usr/local. 
*The rest of the guide will assume it's in /usr/local, the full path of my installation is /usr/local/apache-activemq-5.5.0*

**Configuration**

Open activemq and set *ACTIVEMQ_HOME* to point to your installation directory

	$ sudo vi /usr/local/apache-activemq-5.5.0/bin/linux-x86-64/activemq

In activemq

	ACTIVEMQ_HOME="/usr/local/apache-activemq-5.5.0"

Save activemq and open wrapper.conf, change *set.default.ACTIVEMQ_HOMEI* **and** *set.default.ACTIVEMQ_BASE* to point to your installation directory

	$ sudo vi /usr/local/apache-activemq-5.5.0/bin/linux-x86-64/wrapper.conf

In wrapper.conf

	set.default.ACTIVEMQ_HOME=/usr/local/apache-activemq-5.5.0
	set.default_ACTIVEMQ_BASE=/usr/local/apache-activemq-5.5.0

Save wrapper.conf and create a soft link in init.d

	$ sudo ln -s /usr/local/apache-activemq-5.5.0/bin/linux-x86-64/activemq /etc/init.d/activemq

**Note:** When creating a soft link make sure it's the full path even if your currently in that directory. I didn't and I had issues making one.


Update [rc.d](http://www.linux.com/news/enterprise/systems-management/8116-an-introduction-to-services-runlevels-and-rcd-scripts)

	$ sudo update-rc.d activemq \ [hit_enter]
 	 start 66 2 3 4 5 . stop 34 0 1 6 .

And you're done. 

Bonus points

Start or stop the service manually

	$ service activemq start
	$ service activemq stop

Check if ActiveMQ is running

	$ service activemq status

Uninstalling the service

	$ sudo update-rc.d -f activemq remove
	$ sudo rm /etc/init.d/activemq

If you had any problems let me know

-Matt
