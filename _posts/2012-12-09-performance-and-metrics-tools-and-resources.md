---
layout: post
title: Performance and metrics tools and resources
author: mjennings
excerpt: Tools and resources mentioned in our VelocityConf talk
---

As promised, here are all the tools and resources mentioned in our ([@mjenno](https://twitter.com/mjenno) and [@davenolan](https://twitter.com/davenolan)) [talk at VelocityConf today.](http://velocityconf.com/velocityeu2012/public/schedule/detail/26634)

Graphite and friends

 - [graphite](http://graphite.wikidot.com/): scalable realtime metrics

Alternative frontends

- [graphiti](https://github.com/paperlesspost/graphiti)
- [tasseo](https://github.com/obfuscurity/tasseo)
- [gdash](https://github.com/ripienaar/gdash)
- [descartes](https://github.com/obfuscurity/descartes)

Related tools

- [statsd](https://github.com/etsy/statsd)
- [fozzie](https://github.com/lonelyplanet/fozzie)
- [flamsteed](https://github.com/lonelyplanet/fozzie)
- [statsd plugin for nginx](https://github.com/zebrafishlabs/nginx-statsd)

Holt-Winters

- [Exponential smoothing](http://en.wikipedia.org/wiki/Exponential_smoothing)
- [Introductory article (pdf)](http://forecasters.org/pdfs/foresight/free/Issue19_goodwin.pdf)
- [Paper evaluating H-W applied to real-time time series (pdf)](http://www.evanmiller.org/poisson.pdf)
- [It's built into Graphite!](http://graphite.readthedocs.org/en/0.9.10/functions.html#graphite.render.functions.holtWintersAberration)

Also

- [cubism](http://square.github.com/cubism/)
- [d3 js viz lib](http://d3js.org/)
- [Patrick's excellent 'Monitoring Wonderland' posts](http://jedi.be/blog/2012/01/03/monitoring-wonderland-metrics-api-gateways/)

Continuous experimentation

- [Our continuous experimentation chef cookboook](https://gist.github.com/3833637)
- [openresty](http://openresty.org/) turns Nginx into a Swiss-Army knife

And there will be more posts on CE here soon (if there aren't, please harass me on Twitter).
