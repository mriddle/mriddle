I have been pretty busy this weekend with the site adding new features and modifying the layout. One of the new features I have added is "Disqus":http://disqus.com/ . It's pretty awesome, replacing the conventional comment section with a more 'social-friendly' version. However after implementing it I noticed my page load time went from under 1 second to 14 seconds... "Firebug":http://getfirebug.com/ (Firefox web dev addon) was showing 50+ GET requests for <i>myaccount.disqus.com/count.js</i> with each taking 200-500ms to complete. Some quick investigation showed it was just to retrieve the comment and reaction count for each post. Not worth the wait or necessary but I still wanted to keep it.

I reduced the load times by using a nifty jQuery plugin called "appear":http://code.google.com/p/jquery-appear/ which fires when an element scrolls into view or otherwise becomes visible to the user. This effectively only loading a comment count for a post when a user scrolled down to it.

Once I added the jQuery plugin I made a simple modification to the code Disqus provides.
*From*

<pre>
<script type="text/javascript">
  /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
  var disqus_shortname = 'example'; // required: replace example with your forum shortname

  /* * * DON'T EDIT BELOW THIS LINE * * */
  (function () {
      var s = document.createElement('script'); s.async = true;
      s.type = 'text/javascript';
      s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
      (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0])
         .appendChild(s);
  }());
</script>
</pre>

*To*

<pre>
<script type="text/javascript">
  /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
  var disqus_shortname = 'example'; // required: replace example with your forum shortname

  /* * * DON'T EDIT BELOW THIS LINE * * */
  $("div#post_no_<%= post.id %>").appear(function () {
      var s = document.createElement('script'); s.async = true;
      s.type = 'text/javascript';
      s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
      (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0])
        .appendChild(s);
  });
</script>
</pre>

Where <code>$("div#post_no_<%= post.id %>")</code> is the ID of my post or w/e the viewer will see before the script is executed.

With that simple change pushed to heroku my load times were back down to around 1-2 seconds.

Also, I stumbled upon an alternative to FIrebug if you don't have it installed. It's a web page that is basically the same simply input the URL of the site and check out the load times. It's called "loads.in":http://loads.in/
Enjoy

*EDIT* <i>(04/06/2011 @ 11:09 PM)</i>
"Chris Aitchison":http://chrisaitchison.com/ mentioned YSlow in his comments, it's another Firefox addon that works with Firebug. I have just installed it and am impressed at how easy and useful it is. Check it out "here":http://developer.yahoo.com/yslow/

<blockquote>
YSlow analyzes web pages and suggests ways to improve their performance based on a set of rules for high performance web pages. YSlow is a Firefox add-on integrated with the Firebug web development tool. YSlow grades web page based on one of three predefined ruleset or a user-defined ruleset. It offers suggestions for improving the page's performance, summarizes the page's components, displays statistics about the page, and provides tools for performance analysis, including Smush.it™ and JSLint.
</blockquote>

-Matt