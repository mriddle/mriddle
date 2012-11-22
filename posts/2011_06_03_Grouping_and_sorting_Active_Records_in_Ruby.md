I have made a few changes to my blog recently, one of them being a list of posts on the right hand side. I had some difficulties with it as I am still new to Ruby and couldn't find any examples. So here is mine, this is a nice simple way to group Posts by year and month.

<pre>
<% Post.all
        .group_by{|ar| ar.created_at.strftime "%Y %b" }
           .each do |date_str, post_for_month| %>
  <b><%= date_str %></b>
  <ul>
    <% post_for_month.each do |post| %>
      <li><%= link_to(post.title, post_path(post)) %></li>
    <% end %>
  </ul>
<% end %>
</pre>

The expected output will be

<b>2011 January</b>

* post title one
* post title two


<b>2011 February</b>

* post title one


If you want to sort by date as well simply change the code above to this

<pre>
<% Post
       .order("created_at DESC")
         .group_by{|ar| ar.created_at.strftime "%Y %b" }
            .each do |date_str, post_for_month| %>
  <b><%= date_str %></b>
  <ul>
    <% post_for_month.each do |post| %>
      <li><%= link_to(post.title, post_path(post)) %></li>
    <% end %>
  </ul>
<% end %>
</pre>

More information can be found [here](http://ruby-doc.org/core/classes/Enumerable.html#M001497) and [here](http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-group)

-Matt