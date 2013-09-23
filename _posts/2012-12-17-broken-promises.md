---
layout : post
title : Broken promises
author: tmoore
---


**Broken Promises: Counter-intuitive Exception Handling with jQuery's Deferred**
***or, why "always" doesn't always mean always***

Given this code:

```javascript
function doDeferred(f) {
  return $.Deferred(f).resolve()
    .done(function() { console.log("Done!") })
    .fail(function() { console.log("Failed :(") })
    .always(function() { console.log("Goodbye") })
}
```

What do you expect when you call this:

```javascript
doDeferred(function() {
  console.log("Hello")
})
```

Probably this:

```
Hello
Done!
Goodbye
```

You are correct! Great job. Grab a drink of water... it only goes downhill from here.

What about if your function throws an exception?

```javascript
doDeferred(function() {
  throw "a tantrum"
})
```

I might have expected:

```
Failed :(
Goodbye
```

but, no, I only get

<pre>
<code style="color:red">"a tantrum"</code>
</pre>

It turns out that jQuery does not catch exceptions thrown in the function passed to the deferred constructor, it lets them bubble out.

OK, maybe that's understandable, but it gets weirder. With this:

```javascript
function doDeferredOrThrow(f) {
  return $.Deferred(f)
    .done(function() {
      console.log("Done!")
    })
    .fail(function() {
      throw "Failed :("
    })
    .always(function() {
      console.log("Goodbye")
    })
}
```

Here are the results I get when I resolve or reject:

```javascript
doDeferredOrThrow(function() {
  console.log("Hello")
}).resolve()
```

gives me:

```
Hello
Done!
Goodbye
```

so far, so good

```javascript
doDeferredOrThrow(function() {
  console.log("Hello")
}).reject()
```

gives me:

<pre>
<code>Hello</code>
<code style="color:red">"Failed :("</code>
</pre>

hmmm... this is a little more concerning. We're supposed to be able to attach multiple callback handlers to the same promise, but if one of them throws an exception, the others never get called. These examples are a bit contrived, but with something a little more complex, it's easier to see how this gets confusing.

```javascript
function handleError(e) {
  throw e
}

function politelyPromise(promiseMaker) {
  console.log("Hello")
  return promiseMaker().always(function() {
    console.log("Goodbye")
  })
}

function promise(text, isKept, whenBroken) {
  if (isKept) {
    console.log("I promise to " + text)
    return $.Deferred().resolve()
  } else {
    console.log("I promise not to " + text)
    return $.Deferred().fail(whenBroken).reject(text)
  }
}
```

running:

```javascript
politelyPromise(function() {
  return promise("be good", true, handleError)
})
```

gives:

```
Hello
I promise to be good
Goodbye
```

but this:

```javascript
politelyPromise(function() {
  return promise("be good", false, handleError)
})
```

gives:

<pre>
<code>Hello</code>
<code>I promise not to be good</code>
<code style="color:red">"be good"</code>
</pre>

It never says goodbye!

In this example, the function I'm passing in to handle errors doesn't know that it's being used in a promise, it's just a generic error handler. The function that wraps a promise with "Hello" and "Goodbye" is supposed to work with arbitrary promise-creating functions, and doesn't know that anything has attached an error handler. The function that creates the promise and decides whether it is successful or not doesn't know any details about the behaviour of the error handler, or the fact that it's getting wrapped. All three pieces work in isolation, but when you put them together, they break when the promise is rejected.

The take-away here is that promise callbacks are not just ordinary functions: they need to guarantee that they will never throw any exceptions, or else they will break other callbacks that may need to be invoked to reset the application back to an expected state. That means that they need to guarantee that nothing that they call throws an exception, either. This gets a bit tricky.

The real-life example that led to this discovery in Christo was code that tried to show a loading dialog while an AJAX request is in process, and hide it when complete. An exception while processing the AJAX response in a callback meant that the dialog was never hidden.

Some other JavaScript promise libraries do not exhibit this behaviour. Related to the article I sent last week, the Promises/A spec does require compliant implementations to handle exceptions more intuitively, but the jQuery developers do not wish to change their implementation. You can read the whole sordid flamewar [in the jQuery bug tracker](http://bugs.jquery.com/ticket/11010). Note that the critic of jQuery's implementation is the same person who authored the [You're Missing the Point of Promises gist](https://gist.github.com/3889970).

As we rely heavily on promises throughout our code, we will be considering alternative libraries. The three big ones out there that I know of are [Q](https://github.com/kriskowal/q), [when.js](https://github.com/cujojs/when) and [rsvp.js](https://github.com/tildeio/rsvp.js?utm_source=javascriptweekly). We'll do some research and post again with our results.
