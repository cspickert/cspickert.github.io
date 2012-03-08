---
layout: post
title: "A great preprocessor use case"
---

Just came across an interesting use of preprocessor `#define`s in one of Apple's [Grand Central Dispatch](http://en.wikipedia.org/wiki/Grand_Central_Dispatch) headers:

{% highlight c %}
#ifndef __DISPATCH_INDIRECT__
#error "Please #include <dispatch/dispatch.h> instead of this file directly."
#include <dispatch/base.h> // for HeaderDoc
#endif
{% endhighlight %}

If you look at `dispatch/dispatch.h`, you'll see the following:

{% highlight c %}
#ifndef __DISPATCH_INDIRECT__
#define __DISPATCH_INDIRECT__
#endif
{% endhighlight %}

Seems like a good way to manage complex multi-file compile-time dependencies. I'm sure there are lots of other cool preprocessor use cases hiding in these headers, too.
