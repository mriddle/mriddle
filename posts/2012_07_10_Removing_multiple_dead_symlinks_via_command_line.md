Stumbled upon this one today, love it! Easily remove all broken sym links in the current directory.

`$ find -L -maxdepth 1 -type l -delete`

**Breakdown:** 

The "-L" option means to always follow symbolic links
The "-type l" will return true when "-L" is in effect only when the symbolic link is broken. 
The "-maxdepth" options means only look in the given directory
The "-delete" deletes the file.

-Matt