---
layout: post
title:  "htaccess pains"
---

I have been lucky enough to play with Apache2 and .htaccess.. if your not getting the desired results you should check the following:

<b>Ports</b> Make sure nothing is stealing your ports
<b>Certificates</b> If you're using certificates make sure the module is enabled and they are being looked up correctly
<b>Virtual Hosts</b> Make sure that AllowOverride is not set to None for your file scope (This one really got me, coming from XAMPP which defaults it to All)
<b>Modules enabled</b> If using "RewriteEngine" for example, make sure you have enabled it using sudo a2enmod rewrite

If you're still having problems make sure you check out the apache error log. Default location is <i>/var/log/apache2/error.log</i> it's usually very helpful. Feel free to comment with any problems you may have had and how you resolved them.

Oh and <b>don't forget to restart Apache!</b> 

-Matt