---
layout: post
title: Fozzie Updates
author: mjennings
---

This week we received a pull request to the [Fozzie](https://github.com/lonelyplanet/fozzie) gem, which enabled developers to turn off the Fozzie Rails Middleware when used within a Rails application.

After some thinking I felt a better way to handle this was to abstract the Rails specific functionality into a seperate Gem, in the same pattern as the RSpec and RSpec Rails gems.

It also felt like a good time to promote Fozzie to Version 1.0.0, after some positive feedback I received at the [WebPerfDay](http://www.meetup.com/London-Web-Performance-Group/events/67296732/) on Friday.

Therefore, [Fozzie 1.0.0](http://rubygems.org/gems/fozzie/versions/1.0.0) is now up and requires you to add the following to your Rails application to monitor your Controller methods:

`gem 'fozzie_rails'`

If you want to use Fozzie in your Rails application, but without the Controller monitoring, use:

`gem 'fozzie'`

A big thank you to all who have so far contributed code and comments to Fozzie.
