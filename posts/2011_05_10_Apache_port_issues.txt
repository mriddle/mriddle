If you ever get errors restarting apache or an SSL exception like the one below
<i>ssl_error_rx_record_too_long</i>
It's most likely because something is using the ports that Apache is trying to use. I know this is most likely not new to most people but if you are having issues this could be it. I have found that Skype is a repeat offender using ports 80 and 443 by default.

-Matt