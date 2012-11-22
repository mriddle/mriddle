Hey folks,

Here is are a few steps to enable VNC access on your mac. 
Run this on the command line via SSH if your stuck externally :)

```
cd /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/
sudo kickstart -configure -allowAccessFor -allUsers -privs -all
sudo kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 
sudo kickstart -configure -clientopts -setvncpw -vncpw password
#Restart
sudo kickstart -restart -agent -console
#Done, VNC GO
```

-Matt
