---
layout: post
title: "Remove the arm64 architecture from CocoaPods targets"
---

It's been a few months since Apple released the first iDevices to feature 64-bit support. While many developers have embraced the impending 64-bit future, not all third party libraries support this architecture yet, including those installable via [CocoaPods](http://cocoapods.org/).

Despite the lack of universal 64-bit support among 3rd-party pods, CocoaPods still includes the `arm64` architecture (via `ARCHS_STANDARD_INCLUDING_64_BIT`) in its generated targets' build settings. This can cause problems if your app's dependencies don't support `arm64`, or you only want to build for `armv7` and `armv7s` for other reasons.

Fortunately, there's a quick and easy automated fix. Just add the following to the bottom of your `Podfile` to revert the `ARCHS` build setting to `ARCHS_STANDARD`:

{% highlight ruby %}
# Remove 64-bit build architecture from Pods targets
post_install do |installer|
  installer.project.targets.each do |target|
    target.build_configurations.each do |configuration|
      target.build_settings(configuration.name)['ARCHS'] = '$(ARCHS_STANDARD_32_BIT)'
    end
  end
end
{% endhighlight %}

To test, target the “iPhone Retina (4-inch 64-bit)” simulator and build.

**Update:** The latest Xcode 5.1 beta redefined `ARCHS_STANDARD` to include `arm64`. I've updated the code above with a fix.
