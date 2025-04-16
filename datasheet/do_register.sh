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
/^<register-table>/,/^<\/register-table>/{
    s/^||/>>rt||/
    b
}
/^<bit-table>/,/^<\/bit-table>/{
    s/^||/>>bt||/
    b
}
' |
sed '
/^<register-table>/,/^<\/register-table>/b env
/^<bit-table>/,/^<\/bit-table>/b env
/^<desc>/,/^<\/desc>/{
:env
    /^<register-table>/{
        s/^.*/<div class="register-table">/
        b
    }
    /^<bit-table>/{
        s/^.*/<div class="bit-table">/
        b
    }
    /^<desc>/{
        s/^.*/<div class="desc">/
        b
    }
    /^>>[rb]t||/{
        x
        /^./p
        s/.*//
        x
        # escape < to &lt;
        s/</\&lt;/g
        s/\&lt;br>/<br>/g
        # divide entries
        /^>>rt/{
            s/^>>rt||\([^|][^|]*\)||\([^|][^|]*\)||/<\/span>\
<\/div>\
>>>\
<div class="desc-entry">\
<span class="addr">\1<\/span>\
<span class="symbol">\2<\/span>\
<span class="register-body">/
            h
            # hold space, keep first half
            s/\n>>>.*$//
            x
            # pattern space, keep last half
            s/^.*\n>>>//
            b
        }
        /^>>bt/{
            # \2, \3 を body より後ろに回す。ホールドスペースに押し込む
            # 行前半がtail(最後に出力)で、後半がhead(最初に出力)、
            # それらの間を "\n>>>\n" で区切っている。
            s/^>>bt||\([^|][^|]*\)||\([^|][^|]*\)||\([^|][^|]*\)||/<\/div>\
<span class="type">\2<\/span>\
<span class="reset">\3<\/span>\
<\/div>\
>>>\
<div class="desc-entry">\
<span class="addr">\1<\/span>\
<div class="bit-body">/
            h
            # hold space, keep first half
            s/\n>>>\n.*$//
            x
            # pattern space, keep last half
            s/^.*\n>>>\n//
            p
            # dump hold space (for debug)
            #x
            #s/^/ZZZ /
            #s/$/YYY/p
            #s/ZZZ //
            #s/YYY$//
            #x
            d
        }
        b
    }
    /^<\/register-table>/b endenv
    /^<\/bit-table>/b endenv
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
' |sed '/^  <span class="body">/,/  <\/span>/{
    s/`\([^`][^`]*\)`/<code>\1<\/code>/g
    s/\*\([^*][^*]*\)\*/<em>\1<\/em>/g
    s/\$\$\([^$][^$]*\)\$\$/<span data-math-typeset="true">\\(\1\\)<\/span>/g
}
'
