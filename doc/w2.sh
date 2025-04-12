#! /bin/sh
cat p2.md |
sed '/^<bit-table>/,/^<\/bit-table>/{
    s/^>>>\([^|][^|]*\)||\([^ ][^ ]*\)  *\([^ ][^ ]*\)||/||\1||\2||\3||/
}
/^<register-table>/,/^<\/register-table>/{
    s/^\([^ ][^ ]*\)  *\([^ ][^ ]*\)  *\([^ ]\)/||\1||\2||\3/
}
/^||||## PIO/{
    s/  *Offset/\
\
Offset/
    s/  *Description/\
\
Description/
}
s/^||||//
s/||  */||/g
' |
# Description -> Description:
sed '
/^## PIO:/,/^Table/{
    s/^Description /Description: /
}
s/  */ /g
'
