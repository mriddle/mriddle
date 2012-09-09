This could be off topic for people that follow my blog but it recently came up and I thought it was worthwhile sharing the solution.

This is related to the IBM FileNet OSAR (Optical Storage and Retrieval) unit, a robotic optical storage jukebox storing up to 64 2.6-gigabyte optical disks along with a complement of drivers supporting server peripherals.

There was an issue retrieval documents, after some investigation I discovered that one of the surfaces was disabled for reads. I originally tried to simply re-enable it using xapex (the user interface for the OSAR) but nothing happened and nothing was shown in the logs either. Turns out you need to disable both sides to the disk before you can enable it for read/write.

So if anyone out there also happens to be troubleshooting why documents aren't being retrieved because the surface is disabled for reads then simply disable the other side/surface and enable both for read/write. It's most likely not a common problem that the average developer/consultant has though.

-Matt