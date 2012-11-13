Quick one,

Just tried to attach a volume and was confused when AWS said it was attached. I had a look at my devices `cat /proc/partitions` and couldn't see it.

Turns out `/dev/sdf` is the external name and `/dev/xvdf` is the internal name

\#noob /facepalm

This was triggered by [this post](http://blog.taggesell.de/index.php?/archives/85-Amazon-EC2-How-to-migrate-an-EBS-backed-image-from-US-to-EU-or-wherever.html) on migrating an AMI from one AWS region to another.

Moving to AP-Southeast-2 a.k.a Sydney!!!!!


-Matt