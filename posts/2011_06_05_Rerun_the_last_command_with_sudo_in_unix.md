Have you ever executed a command in Unix and noticed the that you had to run it with sudo?
Instead of typing the command again with “sudo” in front of it, just run:

<pre>
$ sudo !!
</pre>

*EDIT* <i>(05/06/2011 @ 10:20 PM)</i>
Mathew pointed out that running

<pre>
$ !! command
</pre>

will put the command at the end of the line. For example

<pre>
$ rails
$ !! server
#output
$ rails server
</pre>

Basically the <code>!!</code> is a replacement for the previous line entered in the Linux shell.

Update:
You can also use !$ for partial replacement. For example

<pre>
$ mkdir temp_folder_to_delete
$ rm -rf !$ #short for rm -rf temp_folder_to_delete
</pre>

-Matt