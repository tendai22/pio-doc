.SUFFIXES: .md _x.md

all: pic-doc.pdf

#XTARGET= memo_jp_x.md
XTARGET= test_x.md

TARGET= $(XTARGET)

TOCSRC=memo_jp.md

SRC=$(TOCSRC)

CONF=css/sample1.css vivliostyle.config.js

#press-ready: $(TARGET) $(CONF)
#	vivliostyle build --preflight press-ready --preflight-option gray-scale --preflight-option enforce-outlint
#	mv narrowroadEX1.pdf narrowroadEX1-om.pdf

pic-doc.pdf: $(TARGET) $(CONF)
	vivliostyle build
#toc.md: $(TOCSRC)
#	sh maketoc2.sh $(TOCSRC) > toc.md

clean:
	-rm -rf $(XTARGET) toc.md

.md_x.md: 
	(sh do_desc3.sh $< | sh do_note2.sh ) > ./$@