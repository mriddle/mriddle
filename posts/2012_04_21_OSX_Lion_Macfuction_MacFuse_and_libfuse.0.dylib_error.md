I ran into this problem using Mac Fusion on OSX Lion.

```
dyld: Library not loaded: /usr/local/lib/libfuse.0.dylib
Referenced from: 
/Applications/Macfusion.app/Contents/PlugIns/sshfs.mfplugin/Contents/Resources/sshfs-static
Reason: image not found
```

The Library "libfuse.0.dylib" doesn't exist. With Lion being x64 and [MacFuse](http://code.google.com/p/macfuse/) no longer being maintained.

Have no fear though, there is a  64 bit version via Tuxera and works.

You can downloaded it [here](http://www.tuxera.com/mac/macfuse-core-10.5-2.1.9.dmg)
