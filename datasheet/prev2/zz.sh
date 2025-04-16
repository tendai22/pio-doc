#! /bin/sh
cat "$@" |
sed '
/<register-table>/,/^<\/register-table>/{
    s/^\(0x[^ ]*\)  *\([^ ][^ ]*\)  *\(.*\)$/||\1||\2||\3/
}' |
# register-map pre
sed '1,/^<\/register-table>/b
/^>>>31/{
    s/^/\
<bit-table>\
/
}
/^>>>0 /b tail
/^>>>[0-9][0-9]*:0 /b tail
    # end of process
    b
{
:tail
    s/$/\
<\/bit-table>\
/
}
'