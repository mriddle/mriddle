---
layout: post
title:  "Capybara find error"
---

Simple one I ran into when using Capybara.find(css_selector)

The following code

```ruby
find(".manifest_section[data-title='#{parent_section_name}'] .new_section ")
```

Throws this error

```
Nokogiri::CSS::SyntaxError Exception: unexpected '$' after 'DESCENDANT_SELECTOR'
```

Remove the whitespace at the end yo :P

-Matt