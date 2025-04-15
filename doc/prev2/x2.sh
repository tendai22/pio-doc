#! /bin/sh
cat x1.md |
sed '
/^||||-------/d
s/^||||//
s/^<codeblock>/```/
s/^<\/codeblock>/```/
'