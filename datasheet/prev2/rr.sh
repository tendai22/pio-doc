#! /bin/sh
cat p1_jp.md |
sed 's/「\([A-Za-z0-9_-][A-Za-z0-9_-]*\) *」/ "\1" /g'