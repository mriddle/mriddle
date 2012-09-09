I tried to use chkconfig today and found it wasn't included with my vanilla Ubuntu install. To install it simply run the following command
---
$ sudo apt-get install chkconfig
---
OR you can download it from "here":http://ubuntu2.cica.es/ubuntu/ubuntu/pool/universe/c/chkconfig/

An explanation of chkconfig

A system tool to enable or disable system services

Chkconfig is a utility to update and query runlevel information for system services. Chkconfig manipulates the numerous symbolic links in /etc/init.d/, to relieve system administrators of some of the drudgery of manually editing the symbolic links.

This package also contains the program "service" for running init scripts in a predictable environment.

In Debian, there are several tools with similar functionality, but users coming from other Linux distributions will find the tools in this package more familiar. 

Hope it helps folks out

-Matt