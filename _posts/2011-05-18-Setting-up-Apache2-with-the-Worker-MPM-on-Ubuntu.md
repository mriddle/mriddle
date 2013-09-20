---
layout: post
title:  "Setting up Apache2 with the Worker MPM on Ubuntu"
---

I hit a bottle neck the other day during development (stress-testing) and I found by modifying my Apache2 MPM I could achieve better results. By default my installation of Apache2 on Ubuntu had the <a href="http://httpd.apache.org/docs/2.0/mod/prefork.html">Prefork Multi-Processing module</a> configured which is great for single or dual core systems where one process handles one request at a time (no threading) and is thread safe. I wanted to utilize the resources on the box so I reconfigured my Apache2 install to use the <a href="http://httpd.apache.org/docs/2.0/mod/worker.html">Worker Multi-Processing Module</a>. The Worker MPM is generally better for multi core systems.
<blockquote>
This Multi-Processing Module (MPM) implements a hybrid multi-process multi-threaded server. By using threads to serve requests, it is able to serve a large number of requests with less system resources than a process-based server. Yet it retains much of the stability of a process-based server by keeping multiple processes available, each with many threads.
</blockquote>

<b>Lets begin</b>
Check what version you have by running the following command

<pre>
$ /usr/sbin/apache2ctl -V
Server version: Apache/2.2.17 (Ubuntu)
Server built:   Feb 22 2011 18:35:11
Server's Module Magic Number: 20051115:25
Server loaded:  APR 1.4.2, APR-Util 1.3.9
Compiled using: APR 1.4.2, APR-Util 1.3.9
Architecture:   64-bit
Server MPM:     Worker
  threaded:     yes (fixed thread count)
    forked:     yes (variable process count)
Server compiled with....
 -D APACHE_MPM_DIR="server/mpm/worker"
 -D APR_HAS_SENDFILE
 -D APR_HAS_MMAP
 -D APR_HAVE_IPV6 (IPv4-mapped addresses enabled)
 -D APR_USE_SYSVSEM_SERIALIZE
 -D APR_USE_PTHREAD_SERIALIZE
 -D SINGLE_LISTEN_UNSERIALIZED_ACCEPT
 -D APR_HAS_OTHER_CHILD
 -D AP_HAVE_RELIABLE_PIPED_LOGS
 -D DYNAMIC_MODULE_LIMIT=128
 -D HTTPD_ROOT="/etc/apache2"
 -D SUEXEC_BIN="/usr/lib/apache2/suexec"
 -D DEFAULT_PIDLOG="/var/run/apache2.pid"
 -D DEFAULT_SCOREBOARD="logs/apache_runtime_status"
 -D DEFAULT_ERRORLOG="logs/error_log"
 -D AP_TYPES_CONFIG_FILE="mime.types"
 -D SERVER_CONFIG_FILE="apache2.conf"
</pre>

This tells you the Server MPM being used amongst other things. <i>Make sure the Worker MPM is right for you and your environment before going any further.</i>

<b>#01 - Install Apache MPM Worker</b>
<i>Note:</i> Before proceeding with this step, if you have made any changes to the php.ini then I suggest you back it up because the file will be overwritten and you will have to make those changes again. I found this out the hard way. Thankfully I didn't have many differences from the vanilla file. The new file is located here: <i>/etc/php5/cgi/php.in</i> after the install.

<pre>
$ sudo apt-get install apache2-mpm-worker php5-cgi
Reading state information... Done
The following packages were automatically installed and are no longer required:
The following packages will be REMOVED apache2-mpm-prefork libapache2-mod-php5
The following NEW packages will be installed apache2-mpm-worker
0 upgraded, 1 newly installed, 2 to remove and 46 not upgraded.
Need to get 0B/259kB of archives. After this operation, 6193kB disk space will be freed.
</pre>

As you may have noticed by installing <code>apache2-mpm-worker</code>, <code>apache2-mpm-prefork</code> and <code>libapache2-mod-php5</code> are removed. The PHP5 library is removed because <code>apache2-mpm-worker</code> is <b>not thread safe</b>, scripts in the old library which use the PHP <code>fork();</code> function would error. <code>php5-cgi</code> was included in the install command for this reason.

<b>#02 - Enable necessary modules</b>

<pre>
$ a2enmod cgi
$ a2enmod cgid
</pre>

This does nothing else but creates the proper links to the module .load and .conf files, if you wanted to disable these at any point do so by running <code>a2dismod</code>

<b>#03 - Activate the mod_actions apache modules</b>

<pre>
$ cd /etc/apache2/mods-enabled
$ sudo ln -sf ../mods-available/actions.load
$ sudo ln -sf ../mods-available/actions.conf
</pre>

<b>#04 - Modify configuration options to enable the worker module to use the newly installed php5-cgi</b>

<pre>
$ sudo vi /etc/apache2/mods-available/actions.conf
</pre>

Add the following to the file:

<pre>
<IfModule mod_actions.c>
Action application/x-httpd-php /cgi-bin/php5
</IfModule>
</pre>

<b>#05 - (Optional) Configure your module settings</b>

<pre>
$ sudo vi /etc/apache2/apache2.conf
</pre>

Change any of the following to the desired value

<pre>
<IfModule mpm_worker_module>
StartServers 2
MaxClients 150
MinSpareThreads 25
MaxSpareThreads 75
ThreadsPerChild 25
MaxRequestsPerChild 0
</IfModule>
</pre>

<b>#06 - Verify install/configuration</b>

<pre>
$ /usr/sbin/apache2ctl -t
Syntax OK
</pre>

If you got something other than Syntax OK go over the setup and fix any necessary errors.

<b>#07 - Restart Apache to apply changes</b>

<pre>
$ sudo /etc/init.d/apache2 restart
</pre>

Happy keyboard mashing,

-Matt

