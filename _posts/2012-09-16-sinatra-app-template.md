---
layout: post
title:  "Sinatra App Template"
---

Evening guys,

Created a basic Sinatra template as I couldn't find one with everything in it. Have put it up on "Github":https://github.com/mriddle/sinatra_template feel free to fork it.

It comes integrated with:
 * SASS
 * HAML
 * Coffee-script
 * Sprockets 2 (asset pipeline)
 * Underscore & Backbone JS
 * RSpec2
 * -MongoDB-
 * PostgresSQL

### Why PostgresSQL and not MongoDB?

**TL;DR;** *The right tool for the job*

I have used MongoDB in other projects (Java, way back) and I thought I would give it a go with this template/project I am currently working on since every other project I have done (Ruby) has been backed by PostgresSQL.
However I am serious about the performance and scalability of this project and I feel that MongoDB won't give me what I am looking for especially with the performance enhancements that came out in Postgres 9.2. Soon to take over the world, I'm sure :)

There are a few great articles floating around on the web, I think this "stack overflow question":http://stackoverflow.com/questions/4426540/mongodb-and-postgresql-thoughts best sums it up

> You dumped a decades-tested, fully featured RDBMS for a young, beta-quality, feature-thin document store with little community support. Unless you're already running tens of thousands of dollars a month in servers and think MongoDB was a better fit for the nature of your data, you probably wasted a lot of time for negative benefit. MongoDB is fun to toy with, and I've built a few apps using it myself for that reason, but it's almost never a better choice than Postgres/MySQL/SQL Server/etc. for production applications.
> </br> -- [Stack Overflow](http://stackoverflow.com/a/4427769)

I'd love to hear your thoughts if you disagree.

If I get some more time this week I might add Jasmine-Coffee & AngularJS.

-Matt