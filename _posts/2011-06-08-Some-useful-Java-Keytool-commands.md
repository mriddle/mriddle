---
layout: post
title:  "Some useful Java Keytool commands"
---

Below are some commands you might find useful in determining Keystore issues.

**Deleting a certificate**

	sudo keytool -delete -keystore /usr/lib/jvm/java-6-sun-1.6.0.06/jre/lib/security/jssecacerts
 	 -alias aliasname

**List all of the keystore certificates**

	keytool -list -v -keystore keystorelocation | more

**List all cacerts certificates**

	keytool -list -keystore /etc/java-6-sun/security/cacerts | more

**List or display a certificate**

	keytool -printcert -v -file anycert.cer | more

Hope they come in handy

-Matt