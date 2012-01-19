---
layout: post
title: "Easily create a UIImage from a UIView"
---

One of my projects at Aviary necessitated generating a static UIImage from a UIView. Fortunately, Quartz makes it really simple to do this. Here's a quick category on UIView showing how it can be done.

To explain: `-createImageFromRect:` method generates an image by rendering the portion of the view bounded by "frame" in an image context. Note that CALayer's `-renderInContext:`	 method renders the entire layer tree, creating a flat image from the view hierarchy.

{% highlight objc %}

/* implementation UIView (UIImageCreation) */

- (UIImage *)createImageFromRect:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGPoint origin = [self bounds].origin;
    CGPoint offset = frame.origin;

    CGContextTranslateCTM(context, origin.x - offset.x, origin.y - offset.y);

    [[self layer] renderInContext:context];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage *)createImage
{
    return [self createImageFromRect:[self bounds]];
}

/* end */
{% endhighlight %}
