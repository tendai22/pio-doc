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
/^<description>/,/^<\/description>/b env
/^<directive>/,/^<\/directive>/b env
/^<desc>/,/^<\/desc>/{
:env
    /^<description>/{
        s/^.*/<div class="description">/
        b
    }
    /^<directive>/{
        s/^.*/<div class="directive">/
        b
    }
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
        # escape < to &lt;
        s/</\&lt;/g
        s/\&lt;br>/<br>/g
        s/^||\(..*\)||/ <div class="desc-entry">\
  <span class="word">\1<\/span>\
  <span class="body">/
        b
    }
    /^<\/description>/b endenv
    /^<\/directive>/b endenv
    /^<\/desc>/{
    :endenv
        x
        /^./p
        s/.*//
        x
        s/^.*$/<\/div>/
        b
    }
    # escape < to &lt;
    s/</\&lt;/g
    s/\&lt;br>/<br>/g
}
' |sed '/^  <span class="body">/,/  <\/span>/b conv
/^<div class="[a-z][a-z]*-body">/,/^<\/div>/{
:conv
    s/`\([^`][^`]*\)`/<code>\1<\/code>/g
    s/\*\*\([^*][^*]*\)\*\*/<strong>\1<\/strong>/g
    s/\*\([^*][^*]*\)\*/<em>\1<\/em>/g
    s/\$\$\([^$][^$]*\)\$\$/<span data-math-typeset="true">\\(\1\\)<\/span>/g
}
'
