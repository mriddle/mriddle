Hey guys

Just a quick one that I got stuck on at work. 

**TL;DR**
The text needs to be visible on the page (i.e. display:block) for you to select it in Chrome.
In Firefox it only needs to be visible in the DOM

Text selection code example:

```
var range, selection;
expect(startElement).toBeTruthy();
expect(endElement).toBeTruthy();
selection = window.getSelection();
if (selection.rangeCount > 0) {
  selection.removeAllRanges();
}
range = document.createRange();
range.setStart(startElement, startOffset);
range.setEnd(endElement, endOffset);
selection.addRange(range);
```

The *selection.isCollapsed* property defines the cursor as having some text highlighted (true/false). In Chrome you can only highlight whats visible on the page. In Firefox you can highlight any element that resides within the DOM.
It makes sense for you to only be able to highlight text that's visible but if, for example, you had [Jasmine](http://pivotal.github.com/jasmine/) tests, and you have it hidden in a fixture because you want to see the results of the test. It won't work... (in Chrome) unless it's visible.

Long story short. Make sure you set the element to be visible in your sass/css

Apologies if it was chaotic to read, it's very much a brain dump.

-Matt