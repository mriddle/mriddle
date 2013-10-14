---
layout : post
title : Rails and Sass Error on First Request in Production
excerpt: Identifying and resolving Rails3 & SASS issues
author: mwatts
---

Simple issue, but something we bumped into. If you just want the answer please skip straight to The Fix

**The stack:**

- Rails 3 application
- Nginx
- Unicorn
- Rails engine for majority of UI codebase
- Sass
- HAML

**Issue behaviour:**

1. Deployment of application via Chef
2. Code checkout and symlink on completion
3. Asset precompilation
4. Unicorn restart
5. First request to application via brower shows error

**Logs:**

```
Sass::SyntaxError (File to import not found or unreadable: colours. Load paths: /opt/apps/app/releases/20120503122043/public/stylesheets/sass /opt/apps/app/releases/20120503122043/app/assets/stylesheets): /app/assets/stylesheets/application.sass:1
```

The question that struck was why Sass was even looking/amending these files, even though we have already precompiled the assets?

The answer lies in the Sass Plugin, which "provides global options and checks whether CSS files need to be updated."

**The Fix**

When using Rails engines to define Sass files which you want to import in your stylesheet manifest, make sure you add the following to your engine initializer:

```
Sass::Plugin.add_template_location File.join(Gem.loaded_specs['{my_gem_name}'].full_gem_path, '/app/assets/stylesheets')
```

This will ensure that when the Sass Plugin checks for updates on the stylesheet files when the application is restarted, and it processes the @import directive, it searches for the filename within your main application asset path, and your engine's asset path. e.g. `@import 'colours'`
