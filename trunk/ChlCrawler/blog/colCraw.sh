#! /bin/bash
export DISPLAY=:0.0

/usr/local/xulrunner-sdk/bin/run-mozilla.sh ~/workspace/ChlCrawler/mai~/workspace/ChlCrawler/main/gtkMain -r 2 -w /root/workspace/ChlCrawler/blog -l "@nyapc.com/XPCOM/nsColCrawListener;1"

unset DISPLAY