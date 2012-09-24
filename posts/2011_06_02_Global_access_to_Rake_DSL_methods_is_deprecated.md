You may have noticed this error recently running <code>rake db:create</code> or <code> rake db:migrate</code>... The newest version of Rake (0.9+) breaks rails.

If you are getting this error:
<code>WARNING: Global access to Rake DSL methods is deprecated. Please Include</code>
<code>                ....Rake::DSL into classes and modules which use the Rake DSL methods.</code>

*There are two ways to fix this*
* The quick fix is to just downgrade to Rake 0.8.7 by doing the following:

# Add the gem version to your <i>Gemfile</i>

<pre>
gem "rake", "0.8.7"
</pre>

# Remove rake 0.9.1 by running

<pre>
gem uninstall rake -v=0.9.1
</pre>

# Update rake

<pre>
bundle update rake
</pre>

* The other option is to add the following to your Rakefile above the <code>load_tasks</code>:

<pre>
module ::YourApplicationName
   class Application
    include Rake::DSL
  end
end
module ::RakeFileUtils
  extend Rake::FileUtilsExt
end
</pre>

Let me know if you're still having problems.

-Matt