---
created_at: 2011-05-31
kind: article
title: "How I Use PyObjC"
---

I started iOS development just under two years ago, while I was a senior in college. The Cocoa frameworks are the first major code library I've used, and while the learning curve was quite steep at first, I finally feel like I've reached a level of fluency that allows me to be productive. Part of the reason I feel so much more productive than I did when I started out is because I've discovered some (probably very non-standard) workflows that let me cut down the amount of time it takes me to produce better code.

One of the biggest bottlenecks for me when learning to use new frameworks in Objective-C is the amount of time it takes to experiment. Call me spoiled, but I find the need to recompile my code every time I change a line to be very annoying, especially in light of the ability to hit command-R in TextMate while programming in Ruby or Python and have my code execute immediately.

**Enter PyObjC**. PyObjC has to be one of the most underrated (or at least under-mentioned) tools around when it comes to experimenting with the Cocoa frameworks. While it's true that it only gives you access to the Mac frameworks (as opposed to iOS-specific behavior), at least the model code is going to be the same for both Mac and iOS.

One simple statement gives you access to the Foundation classes (others, like Core Data and Address Book, are also available):

	>>> from Foundation import *
	
After that, you can experiment away. For example, if you want to test out the syntax and behavior of collection operators on NSSet instances, you can go nuts:

	>>> setOfSets = NSSet.setWithObjects_(
	...		set([1,2,3]),
	...		set([2,3,4])
	...	)
	>>> setOfSets.valueForKeyPath_("@distinctUnionOfSets.self")
	{(
	    3,
	    2,
	    1,
	    4
	)}

Rather than setting up a whole new Xcode project for your experiments, you can simply keep a terminal window (or TextMate) open next to your main project. As a means of interactive testing, it sure beats the pants off of GDB.

Things get even more interesting when you consider using PyObjC to create actual tools that support your Objective-C development. For example, here's [a fully functional tool I wrote to help localize Core Data model files][1]. While I've concluded that PyObjC isn't very good for developing GUI-based apps, it's perfect for self-contained tasks like this one.

If you're learning iOS or Mac development, I highly suggest playing around with PyObjC. Use it while reading the documentation, to test things out, and just to generally make your life easier.

[1]: https://gist.github.com/910824

