---
layout : post
title : Monitoring our applications - Ruby - Methods
author: mwatts
---

Fozzie was good, and we were happy with progress. We were monitoring applications in real time, the code was looking ok, and the stats looked good on the big screens. On reflection of the code though, we felt there was room for improvement on the way in which were were referencing Fozzie for the timing of code.

We saw a constant pattern of:

```
def foo
 S.time_to_do ["class", "foo"] do
  # bla bla bla
 end
end
```

We felt this would be a massive improvement on this scenario:

```
_monitor
def foo
 # bla bla bla
end
```

### Requirements

In order to achieve this we needed to:
 - Dynamically detect methods being added to classes
 - Alias the method to allow us to automatically wrap our Fozzie code around the original

### Method Added and Singleton Method Added

Ruby supplies a callback for instance and class method declarations; method_added and singleton_method_added.

Because we wanted/needed to be choosy about which methods to measure, we wanted a flag to indicate when a method should be processed. To achieve this we implemented our _monitor dsl method, as follows:

```
def _monitor
 @_monitor_method_flag = true
end
```

And reference the `@_monitor_method_flag` class instance method in our `method_added` and `singleton_method_added` methods.

### Method Aliasing
Once we had the name of the method we wanted to monitor, and we knew it has been created on the Class, we wanted to alias it.

Aliasing enables Fozzie to wrap it's timing logic around the original method.Ruby facets provides a nice `alias_method_chain` that we can use to achieve this.

To alias an instance method we can simply call:

`self.alias_method_chain 'foo', 'monitor'`

To alias a class methods we need to be slightly smarter:

`self.singleton_class.class_eval { alias_method_chain 'foo', 'monitor' }`

The alias_method_chain gives us

```
alias_method :foo_without_monitor, :foo
alias_method :foo, :foo_with_monitor
```

allowing us to access the original method.

### Putting It All Together

Once these elements had been worked out it was all down to tying the pieces together and constructing a neat implementation.

To enable the `_monitor` method to be referenced in any class, we need to include it into the Ruby [Module](https://github.com/lonelyplanet/fozzie/blob/master/lib/core_ext/module/monitor.rb) class, which is required within the main [Fozzie](https://github.com/lonelyplanet/fozzie/blob/master/lib/fozzie.rb) class.

```
class Module
 def _monitor
  # Our code...
 end
end
```

This extension includes [Fozzie::Sniff](https://github.com/lonelyplanet/fozzie/blob/master/lib/fozzie/sniff.rb) into the class, and this then extends the class with the [Fozzie::Sniff::ClassMethods](https://github.com/lonelyplanet/fozzie/blob/master/lib/fozzie/sniff.rb) to tie together all our nitty-gritty aliasing, etc.

