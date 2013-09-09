---
layout : post
title : Upgrading to Capybara 2
---

Hello fellow code monkeys!

Recently upgraded a Rails 3 project here at LP to [Capybara](https://github.com/jnicklas/capybara) 2 from 1.1.2.
Ran into a few minor bumps along the way which we've shared below. Hopefully it helps others choosing to upgrade.

**Useful links:**

- [Change log](https://github.com/jnicklas/capybara/blob/master/History.md)
- [Upgrade guide](http://techblog.fundinggates.com/blog/2012/08/capybara-2-0-upgrade-guide/)
- [Why wait_until was removed](http://www.elabs.se/blog/53-why-wait_until-was-removed-from-capybara)
- [Upgrading to Capybara 2 with Rspec 2](https://github.com/rspec/rspec-rails/blob/master/Capybara.md)

Most of this work was backwards compatible. We were able to push multiple fixes, keeping close to master and leaving the gem upgrade as the last commit.

### The 4 biggest changes for us

- [wait_until](https://groups.google.com/forum/?fromgroups#!topic/ruby-capybara/qQYWpQb9FzY)
- All methods which find or manipulate fields or buttons now [ignore them when they are disabled](https://github.com/jnicklas/capybara/commit/dd805d639b62a9bf12773f8e3b9df3c5e5dd8cc2)
- [find](https://github.com/jnicklas/capybara/commit/cc05b1d63b1201027da7b568a7bd0467df9f7e0a) now raises an error if more than one element was found. Meaning every selector should be unique or use first instead (which won't wait like find does)
- [undefined method 'visit'](https://github.com/rspec/rspec-rails/blob/master/Capybara.md#upgrading-to-capybara-20). We had a few Rspec-Capybara tests which had to be moved into spec/features.


### wait_until

We have a large collection of features and a lot of those were using wait_until. Updating all our features to not use it was a large task so to keep moving I decided write a monkey patch which gives us access to a wait_until block.
The idea being that we can than weed our features off the old behaviour one at a time instead of a big bang approach.

```ruby
class Capybara::Session

  def wait_until(timeout = Capybara.default_wait_time)
    Timeout.timeout(timeout) do
      sleep(0.1) until value = yield
      value
    end
  end

end
```

### find vs first

There were a lot of places in the code where we were lazy using using find instead of first. Find was changed to through an Ambiguous error when more than one result was found.
There's a gotcha though in upgradining. Using first will get around the exception but first will not wait for the element to appear on the page. Returning nil is valid.

Why does find wait but first does not? Good question -- Source below

```ruby
#Taken from Capybara -v 2.0.2

# File lib/capybara/node/finders.rb, line 25
def find(*args)
  synchronize { all(*args).find! }.tap(&:allow_reload!)
end

# File lib/capybara/node/finders.rb, line 131
def first(*args)
  all(*args).first
end

# File lib/capybara/node/base.rb, line 74
def synchronize(seconds=Capybara.default_wait_time)
  start_time = Time.now

  begin
    yield
  rescue => e
    raise e if @unsynchronized
    raise e unless driver.wait?
    raise e unless driver.invalid_element_errors.include?(e.class) || e.is_a?(Capybara::ElementNotFound)
    raise e if (Time.now - start_time) >= seconds
    sleep(0.05)
    raise Capybara::FrozenInTime, "time appears to be frozen, Capybara does not work with libraries which freeze time, consider using time travelling instead" if Time.now == start_time
    reload if Capybara.automatic_reload
    retry
  end
end

```

The difference is that when calling find it wraps the `all.find!` call in a synchronize block which will raise an exception if exactly one element is not found meaning. When the exception is thrown it's caught by the synchronize block and the `all.find!` is retried.

It could be argued that the code is missing a synchronized `first` equivelant to but I disagree. I believe the current example is great because it forces you to have specific selectors.

Some useful tips

```ruby
# Using the :first selector wont save you
find("parent child:first") # Will throw a Capybara::Ambiguous error

# Be direct, use the child selector
find("parent > child")
# Will still return all children directly under parent but can be used return the first block which may be reused.
# Example:
find(".manifest_section[data-title='#{section_name}'] > .heading > .content_types_wrapper > input.content_type_selector")
# Where there may be sub sections which also contain .content_types_wrapper input.content_type_selector

# Take the content into consideration
find("parent child:contains(cake)")

# Use IDs

```

### checking for disabled elements

We had a step to ensure the button was disabled which had to be changed. Below is the before and after. If there is a better way of doing this let me know!

```ruby
#before
Then /^the "([^\"]*)" button is disabled$/ do |title|
  find_button(title)["disabled"].should_not == nil
end

#after
Then /^the delete button is disabled$/ do
  assert_selector 'input[value="Delete →"][disabled="disabled"]'
end
```

### rack_server witin driver

We have a step which was getting rack server mappings and port number from Capybara rack_server accessor. They were changed to the following respectively.

````ruby
#from
Capybara::current_session.driver.rack_server.app.instance_variable_get(:@mapping)
#to
Capybara::current_session.driver.app.instance_variable_get(:@mapping)

#from
page.driver.rack_server.port
#to (Not backwards compatible)
page.server.port
```

The biggest chunk of work was fixing up the hundereds (exaggeration) of ambiguous errors that we were getting. Thankfully each fix was easily backported so we didn't end up with a massive change set locally or sitting on an ever aging branch.

Hope this helps people with their upgrade
