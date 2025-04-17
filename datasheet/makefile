.SUFFIXES: .md _x.md

all: pic-datasheet_jp.pdf

#XTARGET= pio1_jp_x.md
XTARGET= pio-registers_jp_x.md
#XTARGET= x1_x.md

TARGET= $(XTARGET)

#TOCSRC=pio1_jp.md

SRC=$(TOCSRC)

CONF=css/sample1.css vivliostyle.config.js

#press-ready: $(TARGET) $(CONF)
#	vivliostyle build --preflight press-ready --preflight-option gray-scale --preflight-option enforce-outlint
#	mv narrowroadEX1.pdf narrowroadEX1-om.pdf

pic-datasheet_jp.pdf: $(TARGET) $(CONF)
	vivliostyle build
#toc.md: $(TOCSRC)
#	sh maketoc2.sh $(TOCSRC) > toc.md

clean:
	-rm -rf $(XTARGET) toc.md

.md_x.md: 
	(sh do_desc3.sh $< |sh do_register.sh ) > ./$@