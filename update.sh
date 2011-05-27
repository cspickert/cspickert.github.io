#!/bin/sh

rm -rf output
git checkout source
nanoc co
git checkout master || exit 1
cp -R output/* .
git add .
git commit -a -m "updated `date`"
git push origin master
git checkout source
