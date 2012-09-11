*Description*
Apache ActiveMQ is a complete message broker and full JMS 1.1 provider featuring clustering, distributed destinations and XA support with pluggable persistence (JDBC, BDB, JDBM) and transport layers (TCP, UDP, multicast, NIO, SSL, Zeroconf, JXTA, JGroups).

*Installation*
<i>
This installation was done on Ubuntu x64, may be different for other Linux distributions.
The instructions will vary a little depending on system architecture (32 or 64 bit)
</i>

If you haven't done so already download ActiveMQ from "here":http://activemq.apache.org/download.html
extract the download to a directory of your choice. I placed mine in /usr/local. 
<i>The rest of the guide will assume it's in /usr/local, the full path of my installation is /usr/local/apache-activemq-5.5.0</I>

*Configuration*

Open activemq and set <i>ACTIVEMQ_HOME</i> to point to your installation directory

<pre>
$ sudo vi /usr/local/apache-activemq-5.5.0/bin/linux-x86-64/activemq
</pre>

In activemq

<pre>
ACTIVEMQ_HOME="/usr/local/apache-activemq-5.5.0"
</pre>

Save activemq and open wrapper.conf, change  __set.default.ACTIVEMQ_HOME__ *and* __set.default.ACTIVEMQ_BASE__ to point to your installation directory

<pre>
$ sudo vi /usr/local/apache-activemq-5.5.0/bin/linux-x86-64/wrapper.conf
</pre>

In wrapper.conf

<pre>
set.default.ACTIVEMQ_HOME=/usr/local/apache-activemq-5.5.0
set.default_ACTIVEMQ_BASE=/usr/local/apache-activemq-5.5.0
</pre>

Save wrapper.conf and create a soft link in init.d

<pre>
$ sudo ln -s /usr/local/apache-activemq-5.5.0/bin/linux-x86-64/activemq /etc/init.d/activemq
</pre>

*Note:* When creating a soft link make sure it's the full path even if your currently in that directory. I didn't and I had issues making one.


Update "rc.d":http://www.linux.com/news/enterprise/systems-management/8116-an-introduction-to-services-runlevels-and-rcd-scripts

<pre>
$ sudo update-rc.d activemq \ [hit_enter]
 start 66 2 3 4 5 . stop 34 0 1 6 .
</pre>

And you're done. 

Bonus points

Start or stop the service manually

<pre>
$ service activemq start
$ service activemq stop
</pre>

Check if ActiveMQ is running

<pre>
$ service activemq status
</pre>

Uninstalling the service

<pre>
$ sudo update-rc.d -f activemq remove
$ sudo rm /etc/init.d/activemq
</pre>

If you had any problems let me know

-Matt
