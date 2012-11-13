Quick one,

Just tried to attach a volume and was confused when AWS said it was attached. I had a look at my devices `cat /proc/partitions` and couldn't see it.

Turns out `/dev/sdf` is the external name and `/dev/xvdf` is the internal name

#noob /facepalm

-Matt