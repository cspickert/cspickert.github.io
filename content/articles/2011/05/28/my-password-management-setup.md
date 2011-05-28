---
created_at: 2011-05-28
kind: article
title: "My Password Management Setup"
---

Since [my last post](/2011/05/27/internet-disaster-preparedness/) on identity theft/worst case scenarios regarding user accounts on the web was a bit technical/unclear, I figured I'd follow up with a better answer to the question: "so what should I do about it?" Since weak passwords and site-specific attacks are the biggest threat, I think the best way for me to answer that question is to walk through my current account management scheme.

My system runs on one simple rule: **don't use the same password twice**. When I register new accounts online, I use a different password every time. That way, if one site I use gets compromised, my other accounts won't be affected. Obviously, this would be impractical if I had to remember every single password I registered with, or even if I had to keep them all written down. So here are the supporting requirements of my system:

1. **Keep memorization to a minimum.** I don't want to waste brain power memorizing hundreds of passwords.
2. I should be able to access my passwords **quickly**--only slightly slower than the same amount of time it would take to recall them from memory and type them out.
3. I should be able to access my passwords **wherever I am**.

I'm basically looking for the convenience of using a single password everywhere, but with much better security. Fortunately, this is easily accomplished using a few tools and some initial setup time.
    
* **Oplop** (Web-based) - <https://oplop.appspot.com/>

    Oplop is actually [a specification](http://code.google.com/p/oplop/wiki/HowItWorks) for generating passwords, but there is also a [web-based implementation](http://oplop.appspot.com) you can actually use. You choose a master password and a "nickname," and it spits out a strong password. The beauty of Oplop is that given the same nickname and master password, it generates the same output every time. What this means is that you don't actually need to store anything at all; just pick a single master password and use an easily memorizable nickname for each of your accounts (like "amazon" for your Amazon account). That way, you only need to remember one master password, but you end up with separate passwords for each of your accounts online. You just need to use the generator each time you want to access your password (which, once you get used to it, is only a slight inconvenience that can be mitigated by using 1Password and a web browser plugin).

* **1Password** (Mac, Windows, iOS, Android) - <http://agilebits.com/onepassword>

    You may be familiar with storing passwords for your various web user accounts in your browser (like when it asks if you want to "Save this password" for later). Rather than storing your information in the browser, you can store it in 1Password, which serves as a central repository for your sensitive information (in this way, it's similar to the Keychain feature of Mac OS X, but better). Everything you enter is protected by a master password and strong encryption. You can even store 1Password's database file (the ".agilekeychain" file) on a web-accessible file system like Dropbox and access it via an HTML interface. I use 1Password in addition to Oplop for a few reasons: to have an offline-accessible "database" of my passwords and other info; to be able to log in using a keystroke via the included browser plugins; and, to sync my information to Dropbox/my iPhone for mobile access.

These two tools allow me to satisfy my three requirements above. Both of them allow me to avoid memorizing any passwords except the master. When I'm on my own computer, 1Password's browser plugins allow me to fill out login forms with a single keystroke. When I'm on someone else's computer, I can look up my password on my iPhone or use Oplop to retrieve it.

This isn't necessarily the simplest system to set up--after all, it requires you to change all your current account passwords and your behavior. But I can guarantee that if you do both, you'll be protecting yourself better than most other internet users.
