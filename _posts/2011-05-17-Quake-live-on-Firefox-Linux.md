---
layout: post
title:  "Quake live on Firefox Linux"
---

If you're having trouble installing Quake Live on Firefox 4 in Linux, don't fret, there is an easy fix. Download the QuakeLivePlugin_433.xpi. You can download it from the site or <a href="http://www.mediafire.com/?slfqwjilxwtolr8">here</a>. Once downloaded it open it with Archive Manager and edit the <i>install.rdf</i>. Replace the content in the file with the following:

<pre>
<?xml version="1.0"?>
<RDF xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:em="http://www.mozilla.org/2004/em-rdf#">
   <Description about="urn:mozilla:install-manifest">
      <em:id>quakeliveplugin@idsoftware.com</em:id>
      <em:version>1.0.433</em:version>
      <!-- Target Application this theme can install into,
             with minimum and maximum supported versions. -->
      <em:targetApplication>
            <Description>
                  <em:id>toolkit@mozilla.org</em:id>
                  <em:minVersion>1.9</em:minVersion>
                  <em:maxVersion>2.0.*</em:maxVersion>
            </Description>
      </em:targetApplication>
      <em:name>QuakeLive.com Game Launcher</em:name>
      <em:description>Extension required for play on www.quakelive.com</em:description>
      <em:creator>id Software, Inc.</em:creator>
      <em:unpack>true</em:unpack>
      <!-- Add update links here -->
    </Description>
</RDF>
</pre>

Save it and open it with Firefox, everything should go as planned. I can confirm it works and is malware\crapware free.

Happy fraggin.

-Matt