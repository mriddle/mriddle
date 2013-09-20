---
layout: post
title:  "Jasmine with Jammit error xyz is not a constructor"
---

G'day guys, long time no post.

Ran into this one a few times and every now and then I forget the answer.

When doing TDD development working with javascript/coffee & jasmine /w jammit I sometimes run into
"'some class bla' is not a function" and that's because the class isn't defined. The reason for this is because the newly created file that I am TDD'ing has NOT being included in my assets.yml

Solution: Include the damn file you're testing in config/assets.yml fool!