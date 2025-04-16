#! /bin/sh
#cat r0.md |
#sed 's/ \(0x[0-9A-Fa-f]\)/\
#\1/g'
cat r0.md |
#sed '
#/^<register>/,/^<\/register>/b
#:loop
#    $b
#    N
#    /0x[0-9A-Fa-f][0-9A-Fa-f]*/!b loop
#    # split one line
#    s/\(0x[0-9A-Fa-f][0-9A-Fa-f]*\) /\
#\1/
#    P
#:loop
#' |
# cut redundant emply lines
#sed '
#:loop
#/^$/!b
#N
#s/\n//
#b loop
#'
## <codeblock> canceller
sed '1,/^<BEGIN>/b
/^||||--------/d
/^<codeblock>/,/^<\/codeblock>/{
    /^<codeblock>|/d
    s/^||||//
    /^<\/codeblock>/d  
}' |sed '1,/^<BEGIN>/b
/^<\/codeblock/d' |tee x1.log |
## 0x0b8 line compacter
sed '/^0x[0-9A-Fa-f]*$/{
    N
    N
    N
    N
    s/\n\n/ /g
}' |
## PIO register entry formatter
sed '1,/^<BEGIN>/b
s/^PIO:/||||## PIO:/
/^||||## /!s/ PIO:/\
||||##PIO:/' |
sed '1,/^<BEGIN>/b
/^||||## PIO:/{
:loop
    N
    /Table /!b loop
:l2
    N
    / 31/!b l2
    # reformatting heading part
    s/\n/ /g
    s/ 31/\
\
>>>31/
    s/^/\
/
}' |
sed '
/^||||## /{
    s/\(Registers*\) \(Offset\)/\1\
\
||||\2/
    s/ \(Description\)/\
\
||||\1/
}
' |tee x2.log |
sed '1,/^<BEGIN>/b
/^>>>31/,/^|||## PIO:/{
    s/ \([0-9][0-9]*:[0-9][0-9]*\) /\
>>>\1 /g
    /^[0-9][0-9]*:[0-9][0-9]*$/{
        N
        s/\n/ /
    }
    s/^\([0-9][0-9]*:[0-9][0-9]*\) />>>\1 /g
    /^[0-9][0-9]$/b single
    /^[0-9]$/{
        :single
        N
        s/\n/ /
        s/^/>>>/
    }
}'