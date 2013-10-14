---
layout : post
title : Monitoring our applications - Ruby - Overview
author: mwatts
---

A target of ours has been to improve the monitoring of our applications. I'm sure this is true for nearly all Software companies. We have applications written in various languages, the main "must-monitor" ones in Ruby and Java. This article explains how we implemented [statsd](http://codeascraft.etsy.com/2011/02/15/measure-anything-measure-everything) into our Ruby applications.

### Requirements:

- Simple to setup
- Clean implementation
- Easy to change
- Open source (bonus)

We started with the quick and simple [reinh statsd](https://github.com/reinh/statsd) implementation, but quickly found we wanted more functionality, such as:

- Automatically prefix the application name for the statistic being sent
- Automatically prefix the server name for the statistic being sent
- Automatically prefix the environment name for the statistic being sent
- Configure via YAML file and Ruby code
- Less inline code interference

At this point [Fozzie](https://github.com/lonelyplanet/fozzie) was born. [Fozzie](https://github.com/lonelyplanet/fozzie) rapidly grew in functionality as we learnt what we wanted to measure in our Ruby and Ruby on Rails applications. The simplicity of statsd allowed us to really extend what we wanted to measure, and also abstract the amount of code needed to achieve this.

### YAML Based Configuration
Fozzie settings can be customised via a fozzie.yml file, located at config/ on your application root.

You can set the host, port, appname, and namespaces for your application.

Namespaces are the class calls you want to use in your code to register statistics. The defaults are:

```
Stats.increment 'wat
S.increment 'wat'
Statistics.increment 'wat
Warehouse.increment 'wat'
```

### Ruby Code Monitoring
To monitor some Ruby code Fozzie provided namespace to register your stats against, such as:

```
S.increment 'wat'
S.decrement 'wat'
S.time_for 'wat' { sleep 5 }
S.timing, 'wat', 500
S.time_to_do { sleep 5 }
```

### Rack Middleware
Fozzie allows Rack developers to measure their controller action methods with minimum effort.

```
require 'rack'
require 'fozzie'
app = Rack::Builder.new { use Fozzie::Rack::Middleware lambda { |env| [200, {'Content-Type' =&gt; 'text/plain'}, 'OK'] } }
```

### Rails Middleware
Base upon the Rack middleware, Fozzie can provide statistics of the Rails controller action timings. If Fozzie is added to the Rails application Gemfile, the Fozzie Railtie will automatically load the Rails Middleware into the application stack on application initialization.

### Further Reading
More blog posts will be coming on more functionality we have enabled in Fozzie, but if you just want the code here are the links:

- [Fozzie on Github](https://github.com/lonelyplanet/fozzie)
- [Fozzie on Rubygems](http://rubygems.org/gems/fozzie)
