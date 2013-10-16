---
layout: post
title: A History of Web Performance @ Lonely Planet
author: mjennings
---

Screamingly fast is now a requirement of all our projects. Weve only made incremental improvements to our page performance over the past couple of years but this is about to change dramatically. Ill be sharing our progress on this blog. Were also experimenting with tools to help us capture performance data in real time and well share some of this data when we can.

If you're in London and want to know more about what were doing at Lonely Planet, were presenting at the London Web Performance Meetup on [Metrics Driven Engineering](http://www.meetup.com/London-Web-Performance-Group/events/69285112/). Come down and check us out, we'd love to see you!

**Turn the clock back 2 years**

Web performance became a hot topic at LP when our then Director of IT, [Ed Cortis](http://linkd.in/MZ6dZI), returned from Velocity 2010 a changed man. Ed made web performance a focus at Lonely Planet and is largely responsible for my passion. Soon after Ed's return, graphs like the one below were being hotly discussed around the office in Melbourne.

![Conversion](http://getfile4.posterous.com/getfile/files.posterous.com/temp-2012-08-06/hzgvrlfjmEqIkdpxnGsujxoBmqEbnjonEkFsmwJqHgbEcpkqkvazysCHklGc/conversion.jpeg.scaled699.jpg)

(From an [excellent piece](http://bit.ly/PAnjaO) written by Josh Bixby of Strangeloop)

If our site adhered to Joshuas model, this graph showed us that Lonely Planet was potentially losing 40% of our conversions due to poor page performance.

Many believed the delays were caused by third party content and thats where improvements were needed. This presented a challenge to business owners as it meant changing revenue generating features.

My favourite suggestion for performance improvement was removing some ads to speed up the page and calculating whether the net increase in conversion made up for the loss in ad revenue. This was a bit too radical for our tastes.

We ran an A/B test asynchronously loading some ads in iFrames.But [lazy loading](http://en.wikipedia.org/wiki/Lazy_loading) some ads on non-eCommerce areas of the site did not make much difference to conversion. We had designed a poor proof of concept.

Page speed was never viewed as a feature, rather as [technical debt](http://en.wikipedia.org/wiki/Technical_debt). Presented with a choice of developing new features or improving page performance, new features were always made a priority. It was extremely difficult to make improvements.

**Fast forward to today**

In the past 12 months, weve been busy moving our online operations from Melbourne to London. But now that were up and running, the importance of web performance is back in a big way. New team, new focus and weve learnt from our previous endeavours.

Weve recently completed a series of experiments on driving traffic to eCommerce areas of our site. The blue line below depicts the success of various experiments. The orange line is the control.The only difference between the big dip in experiment E and surrounding weeks D & F is that we intentionally slowed down the user experience.


![experiment](http://getfile1.posterous.com/getfile/files.posterous.com/temp-2012-08-06/bzvJHGpCIelmtgsJwrrJtJcckphkJipmBEbnGugFfBlldpcgyuGcmpHhmjJt/Experiments.png)


There it was staring us in the face  the first hard evidence from **our own site** that page performance has a significant impact. Hardly a shock, but the magnitude of impact on our own users was now clear and undeniable.

My next blog post will benchmark our current performance. If you have any questions post them in the comments or email: engineering @lonelyplanet.com.

Finally, dont forget to check out our presentation on [Metrics Driven Engineering](http://www.meetup.com/London-Web-Performance-Group/events/69285112/) at the London Web Performance Meetup. If you're not in London I'll catch you up on what happens in another blog post. Stay tuned!


