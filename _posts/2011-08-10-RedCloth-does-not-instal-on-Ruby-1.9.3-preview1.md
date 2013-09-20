---
layout: post
title:  "RedCloth does not install on Ruby 1.9.3-preview1"
---

Hey guys,

Installing my RoR environment on my laptop and thought I would give Ruby 1.9.3-preview1 a whirl (via RVM). When running 

`$ bundle install`

I ran into an error installing RedCloth. Below is an extract

```
make
compiling redcloth_inline.c
cc1: warnings being treated as errors
ragel/redcloth_inline.c.rl: In function ‘red_parse_title’:
ragel/redcloth_inline.c.rl:68:7: error: ISO C90 forbids mixed declarations and code
ragel/redcloth_inline.c.rl: In function ‘red_block’:
ragel/redcloth_inline.c.rl:99:3: error: ISO C90 forbids mixed declarations and code
```

If you want to install the RedCloth gem then run the following command

`gem install RedCloth -- --with-cflags="-std=c99"`

**Note:** I also had the same issue with the *gherkin-2.3.3* gem.

Hope it helps others out.


-Matt