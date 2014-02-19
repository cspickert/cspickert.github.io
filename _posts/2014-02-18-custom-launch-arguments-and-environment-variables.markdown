---
layout: post
title: "Custom launch arguments and environment variables"
---

While developing iOS apps, it can sometimes be useful to temporarily redefine the default behavior of your app for convenience or debugging purposes. For example, maybe you're working on a first-run feature—a tutorial, for example—that users should only see the first time they open your app. In production, you might want this feature to appear based on a flag stored in [NSUserDefaults](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/nsuserdefaults_Class/Reference/Reference.html):

{% highlight objc %}
BOOL tutorialShown = [[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialShown"];
if (!tutorialShown) {
    [self showTheTutorial];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialShown"];
}
{% endhighlight %}

While building this feature, however, you want it to appear every time you build and run. What are your options in this situation? Well, you could comment out chunks of code to force the feature to show up while you're working on it:

{% highlight objc %}
// BOOL tutorialShown = [[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialShown"];
// if (!tutorialShown) {
    [self showTheTutorial];
//  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialShown"];
// }
{% endhighlight %}

The simplicity of this approach is tempting, but the disadvantages are fairly obvious. For one, you have to remember to uncomment the code before committing it to your repository. This can be especially annoying (and even dangerous) if you're working with other people who might have difficulties with—or worse, accidentally ship—your temporarily commented-out version.

Another approach might be to use a preprocessor conditional, perhaps based on a custom build setting in your prefix header file, your project, or a `.xcconfig` file:

{% highlight objc %}
#if ALWAYS_SHOW_TUTORIAL
[self showTheTutorial];
#else
BOOL tutorialShown = [[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialShown"];
if (!tutorialShown) {
    [self showTheTutorial];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialShown"];
}
#endif
{% endhighlight %}

This is better, but it still shares some major disadvantages with commenting out the code. As above, you're still making changes you'll have to revert, and you and your coworkers still run the risk of using the wrong build settings when archiving the app for production if you're not careful.

**The best way I've found to deal with this scenario relies on a combination of the preprocessor and custom launch arguments defined in an Xcode scheme.** You may be familiar with launch arguments and environment variables already, but if not, you should check out [this great guide on NSHipster](http://nshipster.com/launch-arguments-and-environment-variables/). In addition to controlling the behavior of the frameworks you're using, launch arguments can be great for overriding boolean flags in your own code during development:

{% highlight objc %}
BOOL tutorialShown = [[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialShown"];
#ifdef DEBUG
if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-always_show_tutorial"]) {
    tutorialShown = NO;
}
#endif
if (!tutorialShown) {
    [self showTheTutorial];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialShown"];
}
{% endhighlight %}

If you need to override specific non-boolean values, environment variables are a great alternative to launch arguments. For example, if you're working on a login screen for your app, it might be useful to pre-populate your username and password text fields with default values, while avoiding committing sensitive information to your repository:

{% highlight objc %}
#ifdef DEBUG
NSDictionary *environment = [[NSProcessInfo processInfo] environment];
[[self usernameField] setText:environment[@"USERNAME"]];
[[self passwordField] setText:environment[@"PASSWORD"]];
#endif
{% endhighlight %}

If you typically use a shared scheme for building and running your app (which is committed to version control), make sure to duplicate it locally before making these additions. Oh, and make sure you're using the latest and greatest [gitignore file for Objective-C development](https://github.com/github/gitignore/blob/master/Objective-C.gitignore).

Have a different way of doing things? [Let me know on Twitter](http://twitter.com/cameronspickert). Thanks for reading!
