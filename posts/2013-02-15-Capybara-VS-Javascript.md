---
layout : post
title : Capybara vs Javascript
---

After upgrading to Capybara 2 we spent a lot of time giving love to our neglected child. Feature/Acceptance tests. We had a lot of them and it was always the place we spent the least amount of time, we would write a few step definitions and throw in a few Capybara calls but more often than not we would write some javascript to interact with the page.

The reasoning for this is that our app is an offline client-side based up and we couldn't always get Capybara to bend to our will.
The problem was that we would have spurious failures, usually because of timing, to which we would respond with a capybara.wait_until. I believe this was our approach because we didn't understand

With the improvements to Capybara 2 we were able to remove a lot of the old javascript hackery and repalce it with sexy, simple Capybara calls.

I have pulled out a few worthwhile examples of how we are using Capybara instead of javascript to solve the problem :)

####  Expanding a list, deselecting and selecting

<pre lang="diff"><code class="diff">Then /^I wait until manifest loads$/ do
-  wait_for_manifest_to_load(Capybara.default_wait_time)
-end
-
-Then /^I wait a long time for the manifest to load$/ do
-  wait_for_manifest_to_load(120)
-end
-
-Then /^I should not see any errors while syncing$/ do
-  first("#sync_error").visible?.should_not == true unless page.evaluate_script %{$("#sync_error").length == 0}
+  assert_selector(".manifest_title .loading.hidden")
 end

 def check_for_selected_manifest manifest_name
-  check_result = %{$("#content_pack_content ul.selected_items .select_manifests[value='#{manifest_name}']").is(":checked");}
-  evaluate_script_and_wait_for_result(check_result, "Timed out. Unable to find #{manifest_name} within selected items")
+  page.has_checked_field?(manifest_name).should be_true, "Unable to find #{manifest_name} within selected items"
 end

 def check_for_selected_place place_name
-  check_result = %{$("#content_pack_content ul.selected_items div.pack_item_label[data-value='#{place_name}']").length == 1;}
-  evaluate_script_and_wait_for_result(check_result, "Timed out. Unable to find #{place_name} within selected items")
+  within "#content_pack_content .content_pack_places ul.selected_items" do
+    page.has_selector?(".pack_item_label[data-value='#{place_name}']").should be_true, "Unable to find `#{place_name}` within selected items"
+  end
 end

 def check_search_results_are_not_visible
   page.assert_selector "#content_pack_content ul.ui-autocomplete", :visible => false
 end

-def evaluate_script_and_wait_for_result script, timed_out_message
-  begin
-    wait_until {page.evaluate_script(script)}
-  rescue TimeoutError => e
-    raise timed_out_message
-  end
-end
-
 def remove_item_from_content_pack(name)
   first('.pack_item_label', :text => name).first(:xpath,".//..").first('.delete_type').click
 end

 def remove_manifest_from_content_pack(name)
-  page.evaluate_script %{!$("input[type='checkbox'].select_manifests[value = '#{name}']").click().is(":checked")}
-end
-
-def wait_for_manifest_to_load(timeout)
-  wait_until(timeout) { first(".manifest_title .loading.hidden") }
+  #Expand manifest list
+  page.find_field(name).first(:xpath, "./ancestor::ul").first(".pack_item_label").click
+  #Uncheck manifest
+  page.uncheck name
+  page
</code></pre>

#### Waiting that little bit longer

Will wait up to 30 seconds for the class to appear. May be useful when doing a long operation
```ruby
Capybara.using_wait_time(30) do
  @page.find "#page_wrapper.asyncIdle"
end
```

Changing default_wait_time is bad! Negative assertions will wait the full length of time before returning true/false
The default wait time is 2 seconds, if you wanted to speed the check up then:
```ruby
Capybara.using_wait_time(0.5) {@page.has_no_selector? ".heading"}
```

#### has_selector vs assert_selector

A common mistake was for people to get these to mixed up and not use them in the appropriate situations

**has_selector***

Returns true/false catches Capybara::ExpectationNotMet

```ruby
def form_visible?
  has_selector?("#poi_form", :visible => true)
end
```

**assert_selector**

Throws Capybara::ExpectationNotMet

<pre lang="diff"><code class="diff">Then /^I see a Christo extension missing error dialog$/ do
-  page.has_css?("#unsupported_browser_dialog")
+  page.assert_selector "#unsupported_browser_dialog"
 end
</code></pre>

#### Selecting an item from an autocomplete list

<pre lang="diff"><code class="diff">When /^I add the content type "([^\"]*)" to the "([^\"]*)" section$/ do |content_type, section_name|
-  page.execute_script <<-JS
-    $(".manifest_section[data-title='#{section_name}'] div.content_type_selector_icon:first").css('visibility', 'visible').click()
-    $('ul.ui-autocomplete li a:contains("#{content_type}")').trigger('mouseover').click()
-  end
+  page.execute_script %{$(".manifest_section[data-title='#{section_name}'] div.content_type_selector_icon:first").css('visibility', 'visible').click()}
+
+  # Be explicit - Otherwise you may get one of the two children underneath the manifest section. :first doesn't work returns Ambiguous match
+  type_selector = find(".manifest_section[data-title='#{section_name}'] > .heading > .content_types_wrapper > input.content_type_selector")
+  type_selector.set(content_type) # Sends each key in the string as a native key press
+
+  # Wait for autocomplete to show the result
+  sleep(0.5) #ui-autocomplete does magic and replaces the ul causing a Selenium::WebDriver::Error::StaleElementReferenceError
+  page.has_selector? "ul.ui-autocomplete li", :count => 1 # We should have one exact match
+
+  # Select the result
+  type_selector.native.send_keys(:down)
+  type_selector.native.send_keys(:return)
 end
</code></pre>

This step needed to hover over a section, click the button that shows up, select an item from the drop down which was an ui-autocomplete list.
Yes this step is longer but it's closer to what the user does.
I have yet to find a non hacky way to click something that only shows up on hover :(

#### Filling in form details within a section of the page

```diff
 Then /^I fix the errors$/ do
-  wait_until_ajax_inactive
-  page.execute_script('$(".has_error textarea").val("<p></p>").change()')
-  page.execute_script('$(".has_error button").click()')
-  wait_until_ajax_inactive
+  within(:css, ".manifest_item.has_error") do
+    fill_in "erroneous_manifest_acml", :with => ""
+    click_button 'Validate'
+  end
+  digi_loading_finished
 end
```



I believe that's the best of them. If you have any you'd like to share let us know!


