---
layout: post
title: "Crash reports aren’t everything"
---

Earlier this year, the [iOS](https://twitter.com/cameronspickert) [team](https://twitter.com/dstancioff) at [Oyster](https://www.oysterbooks.com) set a goal to improve the stability of our app. While fixing bugs—especially crashes—has always been a priority for us, we've had to make a few difficult tradeoffs in order to move quickly on feature additions. While the vast majority of our customers have always been able to use the app without encountering crashes, we wanted to take the time to address some of the issues we had been putting off to work on other things.

We've been using [Crashlytics](https://www.crashlytics.com) since around the time we launched publicly in 2013, so we had a pretty good idea where to focus our efforts. After shipping fixes for our top crashes, as well as some subtler multithreading and Core Data issues, we ended up with over 99.5% crash-free sessions according to Crashlytics. The data we were seeing gave us every indication that we'd made a major improvement to our customers' experience in the app.

There was just one problem—according to feedback from many of our customers, our crash rate had  _dramatically increased_. Some were barely able to use the app at all without it suddenly shutting down on them.

Our first thought was that crashes weren't being reflected in Crashlytics. This was a disturbing idea: how many crashes had gone unnoticed as a result of incorrect reporting? As it turned out, crash reports were being delivered correctly—the problem was something else entirely.

When we profiled the app in [Instruments](https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/Introduction/Introduction.html), we realized the app was eating up huge amounts of memory, and suspected that the system was killing the app on older devices. We narrowed the issue down to a bug in an internal feature we had added, which we immediately fixed for the next release. Since then, we've gotten almost no complaints about the app closing unexpectedly.

This episode taught us a few important lessons:

1. First and foremost, **crash reports shouldn't be relied on as the sole indicator of app stability**.
2. If you're building an iOS app, you should be using Instruments and keeping an eye on memory usage.
3. Pay close attention to feedback from customers—they may be encountering issues you didn't anticipate or test for.

If you've run into similar situations or have other ideas about how to improve the stability of your software, [I'd love to hear from you](https://twitter.com/cameronspickert).
