---
layout: post
title:  "Upgrading Rails 2 to 3"
---

Upgrading from rails 2.3 to 3.x at Lonely Planet and have come across a few problems/tips which I thought would be useful to share.

## RSpec matchers

### with_tag & have_tag matchers are gone as of RSpec 2. 

*Solution:* Install "rspec-html-matchers":https://github.com/kucaahbe/rspec-html-matchers
*Notes:* 
 * Usage changed slightly. See example below
 * No longer works against XML with CDATA

```
# HTML
# Rails 2.x /w RSpec 1.x
  with_tag('review summary', '&lt;p&gt;Lots of fun, especially the B&amp;B&lt;/p&gt;')
# Rails 3.x /w rspec-html-matchers
  with_tag('review summary', '<p>Lots of fun, especially the B&B</p>')
# The solution wasn't obvious because the failure message would be:
  '&lt;p&gt;Lots of fun, especially the B&amp;B&lt;/p&gt;' != '&lt;p&gt;Lots of fun, especially the B&amp;B&lt;/p&gt;'
# XML
# Rails 2.x /w RSpec 1.x
 with_tag('review_summary', '<p>Lots of fun, especially the B&B</p>')
# Rails 3.x /w rspec-html-matchers
  @xml.should have_text("<review_summary><![CDATA[<p>Lots of fun, especially the B&B</p>]]></review_summary>")
```

I have a heap more and when I get time I will throw them up.

-Matt