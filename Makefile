CC	= xcrun -sdk macosx gcc
CFLAGS = -I./include -Wall -Wno-pointer-sign
CFLAGS += -Os -arch x86_64 -arch arm64
LDFLAGS = -framework IOKit -framework CoreFoundation
BIN = openra1n
SOURCE = openra1n.c lz4/lz4.c lz4/lz4hc.c

.PHONY: all clean payloads openra1n

all: payloads openra1n

payloads:
	@mkdir -p include/payloads
	@for file in payloads/*; do \
		echo " XXD    $$file"; \
		xxd -i $$file > include/$$file.h; \
	done

openra1n: payloads
	@echo " CC     $(BIN)"
	@$(CC) $(CFLAGS) $(LDFLAGS) $(SOURCE) -o $(BIN)
	strip $(BIN)

clean:
	@echo " CLEAN  $(BIN)"
	@rm -f $(BIN)
	@echo " CLEAN  include/payloads"
	@rm -rf include/payloads
