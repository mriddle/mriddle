G'day Guys,

Playing around with [Boxen](http://boxen.github.com/) and setting up some dock preferences. I wanted to be able to read and modify the preferences via the command line. Wasn't straight forward so I thought I would share it.

Thankfully Mac OSX has something built-in to view and edit the plist files. It's called PlistBuddy. (Tested with Mountain Lion).

It works by opening a plist file and then executing commands against it.

```
# Open plist
/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.dock.plist

# Print all file contents as JSON
command: print

# Show value
command: print autohide

# Update value
command: set autohide true

# Save and quit
command: save
command: quit

```

**Note:** Dock prefs only take effect when you restart the dock `/usr/bin/killall -HUP Dock`

-Matt