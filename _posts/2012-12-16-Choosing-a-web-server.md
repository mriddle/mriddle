---
layout: post
title:  "Choosing a web server"
---

Doing some work with HTML5 WebSockets ATM and been looking at the different web servers, found [this great post](http://stackoverflow.com/questions/6278817/is-sinatra-multi-threaded) on the web and thought I would share.

**Choosing the right one**

The choice is mainly made by the server and middleware you use:

- Multi-Process, non-preforking: Mongrel, Thin, WEBrick, Zbatery
- Multi-Process, preforking: Unicorn, Rainbows, Passenger
- Evented (suited for sinatra-synchrony): Thin, Rainbows, Zbatery
- Threaded: Net::HTTP::Server, Threaded Mongrel, Puma, Rainbows, Zbatery, Thin[1]

*[1] since Sinatra 1.3.0, Thin will be started in threaded mode, if it is started by Sinatra (i.e. with ruby app.rb, but not with the thin command, nor with rackup).*