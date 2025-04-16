cat r0.md |
# cut page delimiters
sed '/^11\.7\. List of Registers/{
    N
    N
    N
    N
    d
}' |tee x1.log |
sed '/^<end-of-registers>/,$b
    :loop
    /^0x[0-9A-Fa-f][0-9A-Fa-f]*$/{
        :iloop
        N
        /\n<end-of/b
        /\n0x/{
        :exit
            P
            s/^[^\n]*\n//
            b loop
        }
        s/\n/ /
        b iloop
    }

' |
sed '1,/^<begin-of-pio-regs>/b
/^PIO: /{
    :loop
    N
    /\nTable [0-9]/!b loop
    #
    s/\nTable /\
||||Table /
    s/\n31/\
\
>>>31/
    #
    s/\n/ /g
    s/||||Table/\
\
||||Table/
    s/>>>31/\
\
>>>31/
    s/^/||||## /
}' |
sed '1,/^<begin-of-pio-regs>/b
/^[0123][0-9]$/b loop
/^[0123][0-9]:/b loop
/^[0-9]$/b loop
/^[0-9]:/b loop
b
:loop
    s/^/>>>/
' |
# compaction bit description
sed '1,/^<begin-of-pio-regs>/b
:compaction
/^>>>/!b
{
    :loop
    N
    /\n>>>/b end
    /\n||||/b end
    s/\n/ /
    b loop
:end
    P
    s/^[^\n]*\n//
    b compaction
}' |
sed '1,/^<begin-of-pio-regs>/b
s/^\(||||## PIO\)/\
\1/' |tee x2.log |
# Table XXXX compactor
sed '1,/^<begin-of-pio-regs>/b
    /^||||Table [1-9][0-9]*/b loop
    /^Table [1-9][0-9]*/b loop
    b
    :loop
    N
    / Register/{
        s/\n/ /
        b
    }
    s/\n/ /
    b loop
'
