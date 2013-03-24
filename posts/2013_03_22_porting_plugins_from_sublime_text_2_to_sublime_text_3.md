
* The place to begin is the [porting guide](http://www.sublimetext.com/docs/3/porting_guide.html), which lists the main changes (python 3.3, asynchronous events, zipped packages, and so on).

* The [plugin API](http://www.sublimetext.com/docs/3/api_reference.html) hasn't changed a great deal. There are a couple of restrictions (most functions now can't be called at importing time), and a few new functions.

* Notably more reliable is the automatic reloading of installed plugins when you edit their sourcefiles. Hooray for plugins being run in a dedicated thread.


#### determining the root directory of a project:

```python
  def root_directory(self):
    try:
      # sublime text 3
      return sublime.active_window().project_data()['folders'][0]['path']
    except:
      # sublime text 2
      return sublime.active_window().folders()[0]
```


#### importing packages

* other plugins can now be imported as modules
* local file imports need to be referenced as a full path:

```python
  # sublime text 2
  from core.machismo import BlazingSaddles

  # sublime text 3
  from MyPlugin.core.machismo import BlazingSaddles
```

This also means you'll need a (possibly empty) ```__init__.py``` within each directory from which you import.

If you want to support both ST2 and ST3, add your plugin to sys.path:

```python
  # to support sublime text 2
  import sys
  sys.path.append(dirname(__file__)+"/../")

  from MyPlugin.core.machismo import BlazingSaddles
```


#### package control

It's worth [submitting your plugin to Package Control](http://wbond.net/sublime_packages/package_control/package_developers#Submitting_a_Package), to make it easily installable via `⌘-Shift-P`. It's just a matter of:
* forking https://github.com/wbond/package_control_channel
* [editing some json files](http://wbond.net/sublime_packages/package_control/package_developers#Submitting_a_Package)
* submitting a pull request

---

References:
* [Porting Guide](http://www.sublimetext.com/docs/3/porting_guide.html)
* [Sublime API](http://www.sublimetext.com/docs/3/api_reference.html)
* [Sublime Technical Forum](http://www.sublimetext.com/forum/)
* [Package Control](http://wbond.net/sublime_packages/package_control/package_developers#Submitting_a_Package)
* [Thoughts on writing a Sublime Text 2 plugin](http://headsexploding.lonelyplanet.com/2012/12/25/thoughts_on_writing_a_sublime_text_2_plugin)
