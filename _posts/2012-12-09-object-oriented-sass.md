---
layout: post
title: Object Oriented Sass
author: mjennings
---

I've been re-examining how we declare and manage CSS objects at LP, recently using the placeholder syntax (%) in Sass over a class. I had a couple of reservations around this, partly because its a leap away from the traditional OOCSS method of using multiple classes as building blocks but also in its usability and impact on performance.

The more Ive been dabbling with the placeholder approach though; the more I can see that traversing the middle ground between the two is going to result in suboptimal code. So I decided to do some research and disprove my reservations.

For those who haven't yet used them, selectors with placeholders will not be included in the CSS output but they are able to be extended. For example:


```css
%some-unused-class
  color: red
  background: black

%base-button-class
  padding: 10px
  display: inline-block

.checkout-button
  @extend %base-button-class
  background-color: red

.submit-button
  @extend %base-button-class
  background-color: black
```

will output to:

```css
.checkout-button,
.submit-button {
  padding: 10px;
  display: inline-block;
}

.checkout-button {
  background-color: red;
}
.submit-button {
  background-color: black;
}
```

And an example using everyones favourite media object would mean we no longer have to chain the .media class to benefit from its abstraction:

```
%media
   the media object

.comment-block
  @extend %media
```

Effectively what this allows us to do is construct our css objects *in* our css as opposed to in the markup. There are definitely pros and cons to this approach and all could be subjective depending on your existing codebase and workflow. I've highlighted some below but I'd be keen to hear of any that I have missed.


## Lets compare the two from a maintainability standpoint.

<table>
<tbody>
<tr>
<th>OOCSS</th>
<th>OOSass</th>
</tr>
<tr>
<td>Styles are defined by the markup</td>
<td>Styles are solely defined in the Sass</td>
</tr>
<tr>
<td>Simpler, all declarations are available for use in the dom</td>
<td>Only some style declarations are exposed</td>
</tr>
<tr>
<td>Potentially leaner stylesheet</td>
<td>Leaner markup</td>
</tr>
</tbody>
</table>

### OOSass pros and cons:

#### Pros

- More readable style declarations - theres no need to keep your naming short
- Leaner markup
- More selective use of styles (only really applicable to sites with multiple stylesheets responsible for different areas)

#### Cons - all debatable

- Back end devs have to write Sass if they want to build up styles
- Slower to iterate on styles than directly on the dom
- Only possible using preprocessors

#### Questionables (makes sense to me but is it actually a Pro?)

- OO happens within the CSS

## Performance

If you're working with OOCSS chances are you care about performance and metrics. So, whilst the placeholder syntax is feeling like a nice approach to me, I wanted to run some tests to see the effect on css size.

I took the css for [ianfeather.co.uk](http://ianfeather.co.uk/) as the base file. It was written a long time ago with loose OOCSS and is fairly performant but not heavily optimised.

Following this, I optimised the CSS by abstracting out some classes and thinning down a few selectors. I wasn't expecting big improvements but I wanted to ensure that I had a performant baseline file to test against.

My main concern was that the gzipped file size would actually increase because of less repetition in the code so it was good to see that this is minimal and that the final code is still smaller. (This blocker could potentially be removed only by extending placeholders which have at least two rule declarations inside.)

<table>
<tbody>
<tr>
<th></th>
<th>File size</th>
<th>When Gzipped</th>
<th>Compression rate</th>
</tr>
<tr>
<td>Base</td>
<td>26514</td>
<td>7055</td>
<td>73%</td>
</tr>
<tr>
<td>After optimisation</td>
<td>26411</td>
<td>6196</td>
<td>77%</td>
</tr>
<tr>
<td>Using OOSass</td>
<td>24520</td>
<td>5920</td>
<td>76%</td>
</tr>
</tbody>
</table>

## Performance in the browser

The CSS file size is key to the critical path but I also wanted to ensure that using this method wouldnt increase the selector matching or paint time.

I created two pages, each with 1200 buttons, one using chained classes and one using extended classes. I then profiled them using Operas CSS Profiler. Unfortunately the results were absolutely identical so this test was inconclusive. Perhaps a larger test file with more variance would be required to create a true test.

The Profiled results for both pages:

![Opera-profile](http://getfile3.posterous.com/getfile/files.posterous.com/temp-2012-07-30/gqljjyuevtomeeyHxwFoHctuaqjfAHBqCcuqEcufskGgoioubHnEzukhoqqe/opera-profile.jpg)

## Conclusions

Whilst our test showed there was no huge performance benefit for this approach, it also failed to show a **downside** for it. This, for me, is a validation of the approach and allows us to look at the more intangible benefits we outlined earlier.

I also think there are performance gains to be made when scaling up. Well use our Sass gem, Beaker, across a fairly wide range of projects and using this will mean each project has access to all objects and base classes as well as the ability to pick and choose which are required and which will be output to their project.css file.

Whether or not this approach is right for you is likely dependant on your existing css architecture. For us, we have the opportunity to shape our future CSS and I think this is a healthy way of doing it.
