---
layout: post
title:  "Objects on rails"
---

Hey guys,

Reading an awesome book at the moment and I highly recommend it. It's called 'Objects on Rails'. You can
read it for free "here":http://objectsonrails.com/ or buy it ($5) to get the DRM-free PDF, EPUB, and Kindle versions of the book.

Here are a few awesome snippets

> Posts vs. Entries. Hold on a sec. Aren't we getting our terms confused here? First we said a Blog has "entries". But then we started talking about "posts". Shouldn't we pick one or the other?
>
>
> In fact, this choice to use multiple terms is deliberate. The dark side of having sensible framework conventions is that after a while, those conventions turn into assumptions. In this case, if we called the entries collection posts instead, there's a good chance we'd start mentally conflating it with the Post class. Anything in blog.posts is a Post object, end of story.
> 
> This is one of those subtle assumptions that can lead to big problems. For instance, if we assume blog.new_post is equivalent to Post.new, we might start to just skip the Blog part and write Post.new(...) or Post.create(...) whenever we want a new blog entry.
>
> Now imagine some time passes, and we add the ability for a Blog to have many different types of posts—photos, embedded videos, etc, each represented by different classes such as PhotoPost and VideoPost. A call to Blog.new_post(...) looks at the arguments arguments and chooses the right type of object to instantiate. Unfortunately, we hard-coded references to Post everywhere, and now we have to go back and change them all.
> </br> -- [Objects on rails](http://objectsonrails.com/#ID-a58a2ad4-12d3-4cec-8c0d-8d590a49ec2f)

-Matt