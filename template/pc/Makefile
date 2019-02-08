SRC_FILES := $(wildcard *.cpp)
TAR_FILES := $(patsubst %.cpp,%.prog,$(SRC_FILES))
IN_FILES := $(wildcard *.in)
OUT_FILES := $(patsubst %.in,%.out,$(IN_FILES))
ANS_FILES := $(patsubst %.in,%.ans,$(IN_FILES))
CC := g++
CFLAGS := -std=c++11
RM := rm -f
SHELL := /bin/bash

ifndef NODEBUG
    CFLAGS += -DDEBUG
endif

.PHONY: all test-all test-% clean clean-all
.SECONDEXPANSION:

all: test-all

test-all: $(OUT_FILES) $(ANS_FILES)
	@echo "## Test All Problems... ##"
	@for out_file in $(OUT_FILES) ; do \
		echo " - Testing $$out_file" ; \
		diff $$out_file $${out_file/out/ans} || exit 1 ; \
	done
	@echo "## All Problems Pass! ##"

test-%: $$(filter %%, $(OUT_FILES)) $$(filter %%, $(ANS_FILES))
	@echo "## Test Problem $*... ##"
	@for out_file in $**.out ; do \
		echo " - Testing $$out_file" ; \
		diff $$out_file $${out_file/out/ans} || exit 1 ; \
	done
	@echo "## Problem $* Pass! ##"

cat-%: %.out
	@cat $<

%.out: $$(basename %).prog %.in
	./$< < $*.in > $@

%.prog: %.cpp
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(TAR_FILES) $(OUT_FILES)

clean-all: clean
	$(RM) $(IN_FILES) $(ANS_FILES)
