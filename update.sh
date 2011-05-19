#!/bin/sh

nanoc co
git checkout master || exit 1
cp -R output/* .
git commit -a -m "updated at `date`"
git push origin master
git checkout source
