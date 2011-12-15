---
layout: post
title: "On Internet Disaster Preparedness"
location: "Starbucks on 2nd ave"
---

Most people don't worry about keeping themselves safe online. However, like backing up your files, it's something that many only realize they need when it's too late.

Yesterday, a friend of mine met with an unpleasant surprise when she logged into her iTunes account: someone had gained access to her account, and had made a $100 purchase using her credit card. While this charge can and will be quickly revoked, she faces a more serious problem. Like most people, she uses the same password for many other accounts online, meaning that her other accounts could also be compromised.

First, let's look at a couple of the possible ways she could have gotten hacked:

1. **She is a victim of [session hijacking][1]**.

	Many sites use [HTTPS][2] to protect their users' data from being intercepted by a third party. However, many sites still use the faster, but less secure HTTP protocol. Using tools like the widely publicized [Firesheep][3], attackers can take control of a user's login session. While most sites wouldn't allow them to change the account password without access to a registered email account, they could still access sensitive information and generally wreak havoc. As more sites adopt the use of HTTPS by default, this will become less of a problem, but a universal solution has not yet been implemented.
	
	In order to protect yourself from this kind of attack, you should do the following:
	
	* Think twice before accessing an HTTP-only service on a public wi-fi network. You can tell if you're using HTTP or HTTPS by looking at the beginning of the URL in your browser's address bar (`http://...` vs. `https://...`).
	* Enable HTTPS as the default protocol on sites that offer the option. For example, in Facebook, go to your account settings and enable "Secure Browsing (https)" under "Account Security".
	* Use a secure proxy service like [the cloak][4] or similar, or (for more advanced users), [tunnel your traffic to a trusted server via SSH][5].
	
    As with all of these attacks, if you become a victim, you should change your password immediately.

2. **The attacker knows her password, either by guessing or by exploiting a vulnerability in another site.**

    This is by far the most dangerous situation. It's only likely to happen if you use the same password for many sites, but this is, unfortunately, the case for many people. Let me put this as simply as I can: **you should not rely on sites to keep your password safe**. Recently, users registered on the Gawker network [learned this the hard way][6]. 
  
    The best way to protect yourself against site vulnerabilities is to use a different password for every account you register. It's not as hard as you might expect, and there are a lot of different utilities out there that make it very easy to do. I use a combination of [oplop][7] and [1Password][8]. Both of these utilities rely on the idea of a single "master" password that you memorize, but instead of exposing this master password to the outside world by using it to register accounts, you use it to generate and protect your set of unique, account-specific passwords, none of which are important to memorize. It's an extremely secure system, and very convenient once you get used to it.

3. **The attacker found and exploited a security vulnerability in iTunes that allowed him/her to gain access to the account.**

    This is similar to the situation above, and the only way to protect yourself is to change your account password. If the service you're using is unreliable, you should strongly consider removing all personal information from your account and using something else.
  
In all situations, the best thing you can do is change your password(s), and be eternally skeptical any time a site guarantees the safety of your information. With our increased reliability on internet services to accomplish vital tasks like online banking, it is _always_ a good idea to be overly cautious.

Also, I could write an entirely different post about this, but continuing in the spirit of being prepared for disasters: **go back up your important files NOW**. With free services like [Dropbox][9] readily available, you have no more excuses not to.

  [1]: http://en.wikipedia.org/wiki/Session_hijacking
  [2]: http://en.wikipedia.org/wiki/HTTP_Secure
  [3]: http://codebutler.com/firesheep
  [4]: http://www.the-cloak.com/anonymous-surfing-faq.html
  [5]: http://en.wikipedia.org/wiki/Tunneling_protocol#Secure_Shell_tunneling
  [6]: http://www.slate.com/id/2277768/
  [7]: http://code.google.com/p/oplop/wiki/HowItWorks
  [8]: http://agilebits.com/onepassword
  [9]: https://www.dropbox.com/
