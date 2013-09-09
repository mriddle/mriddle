
We've just spent a delightful day writing Jasmine tests for our use of the JQuery [contextMenu](https://github.com/medialize/jQuery-contextMenu) plugin. ContextMenu is a useful piece of code that does exactly what it promises to and is simple to use to boot. What isn't obvious is how to use Javascript to manipulate the various operations of contextMenu in an automated test. Herewith a couple of points you may find useful:

* If you are activating contextMenu with a right-click on the UI it isn't worth trying to replicate this with Javascript. It is possible, but way too much trouble. The 'contextmenu' event also triggers the appearance of the menu so use that instead:

```
myElement.trigger('contextmenu');
```

* The event that triggers a selection on a content menu item is **mouseup**, not click. To trigger a click event on the third item in your menu:

```
$('.context-menu-item').eq(2).trigger('mouseup');
```

* Jasmine before/after blocks are not especially good at tearing down contextMenus, you'll need to explicitly destroy the menu after each it-block or the events won't bind/unbind properly:

```
 $.contextMenu('destroy');
```
