Hey Guys,

I ran into a problem today working with TextMate where my search wouldn't complete and I would get a whole lot o red [errors about file encoding](http://img63.imageshack.us/img63/2135/ackmate112error.jpg)

The error message wasn't very clear but, with a minor modification of ackmate_ack you can get it to print each file it searches which will help you identify where the problematic files are.

```
mate /Users/dev/Library/Application\ 
   Support/TextMate/PlugIns/AckMate.tmplugin/Contents/Resources/ackmate_ack
```

and added this on line 1560

`App::Ack::warn( "$filename" );`

Run a search. At the end of the search output, all searched files are now listed and the ones followed by the error are the ones that are not UTF8 encoded.

My problem was a bunch of old tmp cache files that were left lying around in my project dir. I deleted them and didn't have anymore issues. 

Hope that helps!

-Matt