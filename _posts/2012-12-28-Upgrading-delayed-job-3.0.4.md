---
layout: post
title:  "Upgrading delayed job 3.0.4"
---

Ran into this one at work today.

Ugpraded [delayed_job](https://github.com/collectiveidea/delayed_job) gem from 3.0.3 to 3.0.4 and started getting the following error when trying to queue up jobs

```
Delayed::Job.enqueue(MyJob.new())
# BARF
ActiveRecord::UnknownAttributeError (unknown attribute: queue)
```

Someone upgraded us to 3.0.0 and missed the post install instructions of running `rails generate delayed_job:upgrade` which adds the queue coloumn to the delayed tasks table. There is a ticket [here](https://github.com/collectiveidea/delayed_job/issues/453) if you want more info.

Hope this comes up on google for upgrading 3.0.3 to 3.0.4 and saves you guys a few minutes.

-Matt