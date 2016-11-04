CC=gcc
CFLAGS=-Wall
MKDIR=mkdir -p
SRCPATH=csrc p6src
CLIBPATH=clib
P6LIBPATH=p6lib
BINPATH=bin
BUILD_DIRS=$(CLIBPATH) $(P6LIBPATH) $(BINPATH)

VPATH=$(SRCPATH)

.DEFAULT_GOAL := all


lib%.so: %.c
	$(CC) $(CFLAGS) -shared -fPIC -o $(CLIBPATH)/$@ $<

%.out: %.c
	$(CC) $(CFLAGS) -o $(BINPATH)/$@ $<

socketwrapper: libp6rawsocket.so p6rawsocket.out

print_const: print_const.out
	$(BINPATH)/$< > $(P6LIBPATH)/SOCKET_CONSTANTS.pm

$(BUILD_DIRS):
	$(MKDIR) $@

.PHONY: test
test: pyrawsocket.out

.PHONY: dirs
dirs: $(BUILD_DIRS)

.PHONY: clean
clean:
	for dir in $(BUILD_DIRS); do \
		rm -rf $$dir; \
	done

.PHONY: all
all: | dirs socketwrapper print_const 
