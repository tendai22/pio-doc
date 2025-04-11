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
/^11\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\./s/^/##### /
/^11\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\./s/^/#### /
/^11\.[0-9][0-9]*\.[0-9][0-9]*\./s/^/### /
/^11\.[0-9][0-9]*\./s/^/## /
/^Chapter 11\./s/^/# /
# source code marker
s/^[1-9][0-9]* /^^^^/
s/^[1-9][0-9]*$/^^^^/
' |
sed '
# source codes with line numbers
:oloop
    N
    /\n^^^^/!{
        P
        s/^[\n]*\n//
        b oloop
    }
    s/
    ```\
/
:iloop
    N
    /\n^^^^/{
        s/\n^^^^/\
/
        p
        b iool
    }
    s/\n/\
```/
    b oloop
' |tee x1.log |
# sentense compactor
sed '/^<figure>/,/^<\/figure>/b
    /^#/b
    /^$/b
    /^\* /b
    /^  + /b
    /^--------/b
# beginning of line
    s/^/||/
:loop
    N
    /[.:;]\n$/b eos
    $b eos
    b loop
# end of a sentense
:eos
    s/\n\n/>>> /g
    b
'
