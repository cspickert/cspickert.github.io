---
layout: post
title: "Using multiple Dropbox accounts in Mac OS X"
---

This post [has been written before](http://forums.dropbox.com/topic.php?id=3166), but it's such a useful hack that I figured I'd share it here for those who haven't seen it. It's particularly useful for people who want to use separate "home" and "work" Dropbox accounts.

### Running two instances of Dropbox.app

The trick is to get Mac OS X to run multiple instances of Dropbox.app at the same time. As far as I'm aware, there's no way to do this through the Finder (for any application). Fortunately, it's easy to do in two Terminal commands:

	mkdir -p "$HOME/.dropbox-alt"
	HOME="$HOME/.dropbox-alt" open -n -a Dropbox.app
	
(You can replace `.dropbox-alt` with whatever you want).

The first line simply creates a new hidden folder in your home folder, if it doesn't already exist. Although it looks like the second line should be two commands, it's really just one. Invoking `open` with the `-n` flag causes a new instance of the application to launch (and if you use the `-a` flag, you don't need to specify the full path to the Dropbox app). Setting the `HOME` environment variable to its new value fools the new Dropbox instance into thinking your home folder is at `$HOME/.dropbox-alt`. Since Dropbox normally stores its settings in your home directory, you can have a new set of preferences in this folder that doesn't conflict with your primary account.

After you run those lines in Terminal for the first time, the new Dropbox instance will prompt you to set up your account. Once you go through the initial setup, running those commands will simply launch the second Dropbox instance and begin syncing your files.

### Launch a second Dropbox instance automatically

While it's not difficult to run these commands, it can get tedious after a few logins. Wouldn't it be nice if you could start your alternative Dropbox from Finder, or start it automatically when you log in? With Automator, you can do just that.

Here are the steps:

1. Launch Automator (/Applications/Automator.app).
2. Create a new "Application" document.
3. In the Actions library, search for "Run Shell Script".
4. Double click or drag the "Run Shell Script" action into the workflow (on the right).
5. Select `/bin/sh` from the "Shell" menu, and paste the two Terminal lines above in the text area.
6. Save the result to your Applications folder (call it "Dropbox Alt.app" or something similar).

Now you can launch your secondary Dropbox instance by running the application you just created! To add it as a login item:

1. Go to System Preferences and search for "Login Items" in the search bar.
2. Click the plus and add your "Dropbox Alt" application.

Hope you find this as useful as I do!
