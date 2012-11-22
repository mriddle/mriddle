Just a quick one this morning. Below are simple instructions on how to set a static IP on Ubuntu from the shell. I am sure the instructions can be used on any Debian based system.

Open interfaces with your favourite editor

`sudo vi /etc/network/interfaces`

Modify the lines under *#The primary network interface* to match your requirements. In this example I use 192.168.0.10

```
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
```

Save the file -and reboot the system, the changes will be applied.-
**EDIT:** *(01/08/2011 @ 9:11 PM)*
You never need to reboot, in the above example, after you save you can do the following to apply the changes *(courtesy of Mat)*

`$ sudo /etc/init.d/networking restart`

**Bonus Points** *(A.K.A Tips)*

If you're only making a temporary change to eth0 (for testing etc..) do *(courtesy of Mat)*

`$ sudo ifconfig eth0 192.168.0.10 netmask 255.255.255.0`

-Matt