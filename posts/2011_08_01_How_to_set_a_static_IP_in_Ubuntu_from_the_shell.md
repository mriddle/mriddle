Just a quick one this morning. Below are simple instructions on how to set a static IP on Ubuntu from the shell. I am sure the instructions can be used on any Debian based system.

Open interfaces with your favourite editor

<pre>
sudo vi /etc/network/interfaces
</pre>

Modify the lines under __#The primary network interface__ to match your requirements. In this example I use 192.168.0.10

<pre>
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
        address 192.168.0.10
        netmask 255.255.255.0
        network 192.168.0.0
        broadcast 192.168.0.255
        gateway 192.168.0.1
</pre>

Save the file -and reboot the system, the changes will be applied.-
*EDIT:* __(01/08/2011 @ 9:11 PM)__
You never need to reboot, in the above example, after you save you can do the following to apply the changes __^(courtesy of Mat)^__

<pre>
$ sudo /etc/init.d/networking restart
</pre>


*Bonus Points* __(A.K.A Tips)__

If you're only making a temporary change to eth0 (for testing etc..) do __^(courtesy of Mat)^__

<pre>
$ sudo ifconfig eth0 192.168.0.10 netmask 255.255.255.0 
</pre>

-Matt