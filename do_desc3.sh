#! /bin/sh
cat "$@" |
sed '/^<coverpage>/,/<\/coverpage>/b
    /^    /b
    /^<desc>/,/^<\/desc>/b
    /<figure>/,/<\/figure>/b
    /<xref>/,/<\/xref>/b
    /<img /b
    /<code>/,/<\/code>/b
#    s/</\&lt;/g
' |
sed '# preprocess
/^<term>/,/^<\/term>/{
    /^||/{
        s/^||\([^|][^|]*\)|\(.*\)$/||\1|\
\
\2/
    }
}' |
sed '
/^<desc>/,/^<\/desc>/{
    /^<desc>/{
        s/^.*/<div class="desc">/
        b
    }
    /^||/{
        x
        /^./p
        s/.*/  <\/span>\
 <\/div>/
        x
        s/^||\([^|][^|]*\)||/ <div class="desc-entry">\
  <span class="desc-word">\1<\/span>\
  <span class="desc-body">/
    }
    /^<\/desc>/{
        x
        /^./p
        s/.*//
        x
        s/^.*$/<\/div>/
        b
    }
}
'
