---
layout : post
title : Upgradinate
excerpt: Staying on master while doing heavy upgrades
author: Matthew Riddle
---

**Staying on master while doing heavy upgrades**

[Upgradinating](http://www.urbandictionary.com/define.php?term=Upgradinate&defid=6869980) is a process we have used a few times at Lonely Planet now that's saved us a lot of time and grief.

We have recently completed a few technical milestones that have been haunting us for some time:

- Upgrading from Rails 2.3.x to Rails 3.2.x
- Upgrading from Ruby 1.8.7 (REE) to Ruby 1.9.3

Having issues in the past with large chunks of work and a strong desire not to branch, we wanted a way we could keep shipping code without interrupting or slowing down our releases. We came up with the idea of forward-porting what we could and scripting up all other changes - and we called it upgradinating.

Enough talk, time for the code!

**Simple demo**

*upgradinate_script.rb*

```
  helper = UpgradinateFileHelper.new 'OLD NESS', 'NEW-NESS'
  helper.upgradinate_files [
      "/path/to/project/Gemfile"
    ]
```

*Gemfile*

```
  # NEW-NESS gem 'awesome_thing_to_put_in'
  gem 'deprecated_badness' # OLD NESS
```

*Usage*

`ruby upgradinate_script.rb`

**NOTE:**

- You may need to update grep to use '--exclude-dir'
- Make sure upgradinate_script.rb is executable

```
  # Mac OSX
  brew install xz #required for installing grep through homebrew
  brew install https://raw.github.com/Homebrew/homebrew-dupes/master/grep.rb
```

**Examples**

 - [Simple example updating from an old Jasmine version to Jasminerice](https://gist.github.com/4275962#file-upgradinate_script-rb)
 - [Upgrading from Ruby 1.8.7 to 1.9.3](https://gist.github.com/4276016#file-ree-rb)

**Why this works**

 - You don't disrupt the rest of the team's development work
 - Easy to test your changes, can setup a CI build on old and new versions
 - You're changes are visible to the rest of the team, less conflicts
 - Ability to push your changes quickly

**More reading**
- [Branching by abstraction] (http://paulhammant.com/blog/branch_by_abstraction.html)
