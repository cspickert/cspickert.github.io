---
layout: post
title: "On Interface Builder"
---

The other today I came across a blog post and some interesting comments on Twitter about Interface Builder and its role in iOS development.

<blockquote class="twitter-tweet"><p>"Real men do use Interface Builder" <a href="http://t.co/gU7cikqW" title="http://berzniz.com/post/32597579083/8-reasons-why-real-men-do-use-interface-builder">berzniz.com/post/325975790…</a></p>&mdash; Mert Dümenci (@mertdumenci) <a href="https://twitter.com/mertdumenci/status/283962767852056578" data-datetime="2012-12-26T15:49:34+00:00">December 26, 2012</a></blockquote>

<blockquote class="twitter-tweet"><p>Real men don’t use Interface Builder (much). Unless you think real men build shit apps.</p>&mdash; Max Howell (@mxcl) <a href="https://twitter.com/mxcl/status/283990082149572610" data-datetime="2012-12-26T17:38:06+00:00">December 26, 2012</a></blockquote>

Every iOS developer seems to have an opinion about Interface Builder (generally referred to as "IB"). Many label the much-maligned tool as a crutch for beginners who don't understand how to code a UI from scratch. Others claim to use it almost exclusively for UI development, even to the point of encouraging non-coders to dig their teeth into the world of `.xib` files directly. I have a feeling most opinions are somewhere in the middle--torn between the "no IB whatsoever" and "use IB for everything" viewpoints.

While it's true you can't quite build an app entirely in IB, it's still a powerful tool that lets you minimize the amount of boilerplate code you have to write to build an interactive UI. In recent years, its capabilities have grown with the addition of storyboards, gesture recognizers and autolayout support. Still, there are a few shortcomings that are difficult to overlook, including lack of support for resizable images, pattern colors, animations, and constants shared with code, just to name a few.

It seems clear to me that our tools will never be perfect, and both code and GUI-based UI development have a long way to go. Whenever I consider this situation, a couple maxims spring to mind:

### Use the best tool for the job.

Here are a couple of reasons why I think IB is not only a great choice for UI development, but should be understood and used by all app developers:

* **It's an opportunity to replace code with static configuration files**. It's rarely the case that more code is better than less, and relying on a static file reduces the probability of bugs appearing in your app.

* **Interface Builder is one of the oldest, most deeply ingrained tools in the entire Mac/iOS ecosystem**. It's existed since the days of NeXT, and even plays a role in Apple's Objective-C APIs (see `initWithNibName:bundle:`). Something so integral to the way these platforms work is unlikely to disappear. On the contrary, all signs point to IB improving over time, making it a sound investment in the future of your software.

### Consistency is better than perfection.

The best way I've found to take advantage of the most desirable properties of IB and code-based development is to come up with, and adhere to, some basic conventions. These conventions can be as simple or as complicated as needed, but here are a few examples:

* Decide where to put `.xib` files in your project so they're not haphazardly scattered among your other source files.

* Always define autoresizing masks (or autolayout constraints) in nib files and avoid complicated layout code whenever possible.

* Define custom view classes and override `-awakeFromNib` and `-layoutSubviews` to encapsulate additional configuration and layout behavior if needed.

Every developer should at least have a few conventions in mind, but it might help to write them down somewhere. If you use GitHub, a wiki would be a great place to list these things out, along with any other general comments/instructions that don't belong in code-level comments or a README file.

My opinions may evolve over time, but for now I plan to continue exploring Interface Builder's capabilities, and to stay as rational as possible when it comes to making decisions about which tools to use to get my job done.
