#! /bin/sh
cat "$@" |
sed '/^11\./{
    N
    N
    N
    N
    /RP2350 Datasheet/!b
    s/\n/>>>/g
    s/.*/>>>>/
    p
    d
}' |sed '/^$/{
    N
    /\n>>>>$/!b
    N
    s/.*/----------/p
    d
}' |
# chapter heading
sed '#
/^11\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\./s/^/||||##### /
/^11\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\./s/^/||||#### /
/^11\.[0-9][0-9]*\.[0-9][0-9]*\./s/^/||||### /
/^11\.[0-9][0-9]*\./s/^/||||## /
/^Chapter 11\./s/^/||||# /
/^[*] /s/^/||||/
/^  + /s/^/||||/
/^</s/^/||||/
/^--------/s/^/||||/
' |
# code block marker
sed '
    /^ [1-9] /b numline
    /^[1-9][0-9]*$/b numline
    /^[1-9][0-9]* /b numline
    b
:numline
    s/^/||||/
' |
# sentense compactor
sed '/^<figure>/,/^<\/figure>/b
    /^<codeblock>/,/^<\/codeblock>/b
    /^||||/b
# beginning of line
:loop
    N
    /\n||||/b nextline
    /[.:;]\n$/b eos
    $b eos
    b loop
# end of a sentense
:eos
    s/\n\n/ /g
    b
:nextline
    b
' | tee x1.log |
# source code compactor
sed '
/^||||[ 1-9][0-9][0-9]*/{
    N
    s/\n$//
    b
}' |
sed '
:loop
    N
    s/\n/\\\\\\\\/
    p
    s/^.*\\\\\\\\//
    b loop
' |
sed '
## codeblock delimiters
/^||||[ 1-9].*\\\\\\\\||||[ 1-9]/b
s/\\\\\\\\||||\([ 1-9]\)/\\\\\\\\\
<codeblock>||||\1/
s/\(||||[ 1-9].*\)\\\\\\\\$/\1\\\\\\\\\
<\/codeblock>\\\\\\\\/
s/\(||||[ 1-9].*\)\\\\\\\\\([^ 1-9]\)/\1\\\\\\\\\
<\/codeblock>\\\\\\\\\
\\\\\\\\\2/
' |tee x2.log |
sed 's/\\\\.*$//'
