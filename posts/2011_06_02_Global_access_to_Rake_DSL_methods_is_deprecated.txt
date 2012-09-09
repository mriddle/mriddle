You may have noticed this error recently running <code>rake db:create</code> or <code> rake db:migrate</code>... The newest version of Rake (0.9+) breaks rails. 

If you are getting this error:
<code>WARNING: Global access to Rake DSL methods is deprecated. Please Include</code>
<code>                ....Rake::DSL into classes and modules which use the Rake DSL methods.</code>

*There are two ways to fix this*
* The quick fix is to just downgrade to Rake 0.8.7 by doing the following:

# Add the gem version to your <i>Gemfile</i>
--- Ruby
gem "rake", "0.8.7"
---
# Remove rake 0.9.1 by running
--- 
gem uninstall rake -v=0.9.1
---
# Update rake 
--- 
bundle update rake
---

* The other option is to add the following to your Rakefile above the <code>load_tasks</code>:
--- Ruby
module ::YourApplicationName
   class Application
    include Rake::DSL
  end
end
module ::RakeFileUtils
  extend Rake::FileUtilsExt
end
---

Let me know if you're still having problems.

-Matt