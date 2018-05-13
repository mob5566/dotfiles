SRC_FILES := $(wildcard *.cpp)
TAR_FILES := $(patsubst %.cpp,%,$(SRC_FILES))
IN_FILES := $(patsubst %.cpp,%.in,$(SRC_FILES))
OUT_FILES := $(patsubst %.cpp,%.out,$(SRC_FILES))
ANS_FILES := $(patsubst %.cpp,%.ans,$(SRC_FILES))
CC := g++
CFLAGS := -std=c++11 -DDEBUG
RM := rm -f

.PHONY: all test_all test% clean clean_all

all: test_all

test_all: $(TAR_FILES) $(OUT_FILES) $(ANS_FILES)
	@echo "## Test All Problems... ##"
	@diff -q %.ans %.out
	@echo "## All Problems Pass! ##"

test%: % %.out %.ans
	@echo "## Test Problem $*... ##"
	@diff -q $*.out $*.ans
	@echo "## Problem $* Pass! ##"

%.out: %.in %
	./$* < $*.in > $@

%: %.cpp
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(TAR_FILES) $(OUT_FILES)

cleanall: clean
	$(RM) *.in *.ans
