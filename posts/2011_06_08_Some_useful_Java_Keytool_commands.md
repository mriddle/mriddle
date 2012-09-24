Below are some commands you might find useful in determining Keystore issues.

*Deleting a certificate*

<pre>
sudo keytool -delete -keystore /usr/lib/jvm/java-6-sun-1.6.0.06/jre/lib/security/jssecacerts
 -alias aliasname
</pre>

*List all of the keystore certificates*

<pre>
keytool -list -v -keystore keystorelocation | more
</pre>

*List all cacerts certificates*

<pre>
keytool -list -keystore /etc/java-6-sun/security/cacerts | more
</pre>

*List or display a certificate*

<pre>
keytool -printcert -v -file anycert.cer | more
</pre>

Hope they come in handy

-Matt