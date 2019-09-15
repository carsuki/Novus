#Copyright 2019 Polar Development

TARGET  = redchain
OUTDIR ?= bin

CC      = xcrun cc -arch x86_64
CFLAGS  = -Wall

.PHONY: all clean

all: $(OUTDIR)/$(TARGET)

DEBUG ?= 0
ifeq ($(DEBUG), 1)
    CFLAGS += 
else
    CFLAGS += -O2
endif

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(OUTDIR)/$(TARGET): redchain.c | $(OUTDIR)
	$(CC) -o $@ $^ $(CFLAGS)	

clean:
	rm -f $(OUTDIR)/$(TARGET)
