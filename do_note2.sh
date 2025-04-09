#! /bin/sh
cat "$@" |
# convert short format to tags
#
# ^^X, ^^Y, ^^Zで脚注場所を指定し、
# そのすぐ下の段落間に '^^X{ ... ^^}' で囲んで脚注本文を書く。
# 脚注場所と本文の順序が交差する個数は最大3個までと想定している。
# 出現順にX,Y,Zを回転出現させれば確実だが、面倒なら、入れ子になっていない
# 場合は常にXを使う、でも構わない。
#
sed '#
/\^\^[XYZ]{/{
    s/\^\^\([XYZ]\){/<div class="refbody" ref="###_\1_###">/
}
s/\^\^[XYZ]}/<\/div>/
s/\^\^}/<\/div>/
/\^\^[XYZ]/{
    s/\^\^\([XYZ]\)/<span class="refcall" ref="###_\1_###"><\/span>/g
}
s/ ref="\([XYZ]\)"/ ref="###_\1_###"/g
' |
awk 'BEGIN {
    nn = 1
}
/class="refcall"/{
    if (sub(/###_X_###/, nn) != 0)
        nnX = nn++
    if (sub(/###_Y_###/, nn) != 0)
        nnY = nn++
    if (sub(/###_Z_###/, nn) != 0)
        nnZ = nn++
}
/class="refbody"/{
    sub(/###_X_###/, nnX)
    sub(/###_Y_###/, nnY)
    sub(/###_Z_###/, nnZ)
}
{ print }
'
