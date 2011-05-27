---
timestamp: 2011-05-26
kind: article
title: "Key-Value Coding and Collections in Objective-C"
---

Aside from NSObject, the most important Foundation classes new Cocoa programmers should spend time learning are the basic collections: NSArray and NSSet (and their mutable counterparts). While these classes aren't necessarily the most exciting in the SDK (though I think they're pretty cool), learning to use them correctly can save you a lot of time and frustration down the road.

I'm going to focus on a few core areas of collections I wish I had taken the time to learn when I first started learning the Cocoa frameworks:

* valueForKey: and setValue:forKey:
* collection operators

## valueForKey: and setValue:forKey:

After reading some of Apple's documentation and looking at some sample code, these two methods should become very familiar. They're part of the [NSKeyValueCoding protocol](http://developer.apple.com/library/ios/#documentation/cocoa/reference/foundation/Protocols/NSKeyValueCoding_Protocol/Reference/Reference.html), an integral part of the Cocoa frameworks that can be (ab)used in clever ways to accomplish wildly varying tasks,  from accessing instance variables to fetching data from an on-disk Core Data persistent store.

One of the benefits of using these methods everywhere is that Apple provides a consistent interface for accessing data of a key-value coding-compliant objects. Unfortunately for Cocoa newcomers unaware of the different implementations of these methods, this can lead to incorrect assumptions. Thus, I would strongly advise **not** making any assumptions about how these methods are implemented.

Case in point: NSArray and NSSet. While the "Accessor Search Implementation Details" section of the Key-Value Coding Programming Guide discusses valueForKey: and setValue:forKey: in terms of accessing properties of objects, including when those properties represent ordered (NSArray) and unordered (NSSet) collections, it neglects to mention what happens when these methods are called on instances of the collection classes directly. Without any further ado, here's the answer:

* NSArray
	* valueForKey:
		* "Returns an array containing the results of invoking valueForKey: using key on each of the array's objects."
		* "The returned array contains NSNull elements for each object that returns nil."
	* setValue:forKey:
		* "Invokes setValue:forKey: on each of the array's items using the specified value and key."

* NSSet
	* valueForKey:
		* "Return a set containing the results of invoking valueForKey: on each of the receiving set's members."
		* "The returned set might not have the same number of members as the receiving set. The returned set will not contain any elements corresponding to instances of valueForKey: returning nil (note that this is in contrast with NSArray’s implementation, which may put NSNull values in the arrays it returns)."
	* setValue:forKey:
		* "Invokes setValue:forKey: on each of the set’s members."

The first thing to notice is that these methods do not exactly follow Apple's key-value coding guidelines. While this is unfortunate from a consistency standpoint, it makes sense in that the truly important instance data of a collection are the items in the collection, and these methods enable direct bulk manipulation of those items without having to loop over the entire collection.

The best thing about this design decision, however, is that it lays the groundwork for collection operators, which depend on valueForKeyPath:. They are both bizarre and truly awesome once you figure them out.

## Collection operators

Collection operators give us the ability to perform complex queries on a collection of objects, again without the need for any kind of loop. Apple documents them fairly well, and other people have written fascinating articles about them, so I won't go into too much detail here. But let's say you're trying to find the object in a NSArray that is the "maximum" value, according to the contained objects' implementation of compare:. Let's say you have the following NSArray of NSNumber objects:

NSArray *numbers = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:10], [NSNumber numberWithInt:5], nil];

In order to find the maximum value in this array manually, you might be inclined to iterate over the whole array like so:

    NSNumber *max = nil;
    for (NSNumber *number in numbers) {
      if (!max || [number compare:max] == NSOrderedDescending) {
        max = number;
      }
    }

Collection operators give us a much more concise way to do this:

  NSNumber *max = [numbers valueForKeyPath:@"@max.self"];

We can also directly access properties of this maximum-valued object. Think of it this way: the '@max' in the key path string represents the max object in the array. If we wanted to get the integer value of this object directly, this would work, too:

NSInteger maxIntValue = [numbers valueForKeyPath:@"@max.intValue"];

Of course, this is a contrived example, and there are much more useful things collection operators allow you to do, including performing aggregate NSSet operations (union, intersect, etc.). This can be particularly powerful in conjunction with Core Data to-many relationships.

I recommend reading [the official word on collection operators](http://developer.apple.com/library/mac/documentation/cocoa/Conceptual/KeyValueCoding/Articles/CollectionOperators.html#//apple_ref/doc/uid/20002176-BAJEAIEE), and [this excellent article by Dave DeLong on rolling your own custom operators](http://funwithobjc.tumblr.com/post/1527111790/defining-custom-key-path-operators) (as well as the rest of his blog). But, as usual, the best way to figure out how to use them is by trying them yourself.
