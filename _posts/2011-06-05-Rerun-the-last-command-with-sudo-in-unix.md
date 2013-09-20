---
layout: post
title:  "Rerun the last command with sudo in unix"
---

Have you ever executed a command in Unix and noticed the that you had to run it with sudo?
Instead of typing the command again with “sudo” in front of it, just run:

	$ sudo !!

**EDIT** <i>(05/06/2011 @ 10:20 PM)</i>
Mathew pointed out that running

	$ !! command

will put the command at the end of the line. For example

	$ rails
	$ !! server
	#output
	$ rails server

Basically the <code>!!</code> is a replacement for the previous line entered in the Linux shell.

Update:
You can also use !$ for partial replacement. For example

	$ mkdir temp_folder_to_delete
	$ rm -rf !$ #short for rm -rf temp_folder_to_delete

-Matt