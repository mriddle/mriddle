---
layout: post
title:  "Multi threaded java application development"
---

Most, if not all computers now have multiple cores. With the relatively easy support for multi-threaded development, Java comes well-equipped, ready to use of all that grunt under the hood.

However, the Java Virtual Machine runs in 'client mode' (@-client@) by default. Client mode maps all of the java threads onto one single native thread. This has the effect of making the JVM run on only one processor core at any given time.

In order to make the JVM use more than one native thread, you have to supply the -server command line option, in your eclipse.ini, JVM options or run configuration.

Just a short one, if you're ever developing a multi-threaded application in eclipse on a computer with multiple cores make sure you add -server to your <i>eclipse.ini</i>. 

Most applications probably shouldn't be chewing up the processor, so only use this option if you need too, you may find the fault lies with your application.

For a better explanation check out the Sun "white papers,":http://java.sun.com/docs/white/langenv/ below is an extracts:
<i><blockquote>The JDK includes two flavors of the VM -- a client-side offering, and a VM tuned for server applications. These two solutions share the Java HotSpot runtime environment code base, but use different compilers that are suited to the distinctly unique performance characteristics of clients and servers. These differences include the compilation inlining policy and heap defaults.

Although the Server and the Client VMs are similar, the Server VM has been specially tuned to maximize peak operating speed. It is intended for executing long-running server applications, which need the fastest possible operating speed more than a fast start-up time or smaller runtime memory footprint.

The Client VM compiler serves as an upgrade for both the Classic VM and the just-in-time (JIT) compilers used by previous versions of the JDK. The Client VM offers improved run time performance for applications and applets. The Java HotSpot Client VM has been specially tuned to reduce application start-up time and memory footprint, making it particularly well suited for client environments. In general, the client system is better for GUIs. </blockquote></i>
 

You really do learn something new every day

-Matt