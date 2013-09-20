---
layout: post
title:  "It's slash admin not slash console"
---

I think I am late to the party with this discovery. 

If you use `"mstsc /v:SERVERNAME /console"` in a script file or via start>run then the /console will be ignored (with no warning) and you will be connected to a normal session that is not the server console.

For Windows Server 2008, Vista & I believe Windows 7 the flag is now /admin instead.