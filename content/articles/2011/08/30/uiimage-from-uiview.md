---
created_at: 2011-08-30
kind: article
title: "Easily create a UIImage from a UIView"
tags: ['objective-c']
---

One of my projects at Aviary necessitated generating a static UIImage from a UIView. Fortunately, Quartz makes it really simple to do this. Here's a quick category on UIView showing how it can be done.

To explain: -createImageFromRect: method generates an image by rendering the portion of the view bounded by "frame" in an image context. Note that CALayer's -renderInContext: method renders the entire layer tree, creating a flat image from the view hierarchy.

<br>
<script src="https://gist.github.com/1181935.js?file=gistfile1.m"></script>
