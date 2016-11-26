CC=gcc
CFLAGS=-Wall
MKDIR=mkdir -p

CSRCPATH=csrc
P6SRCPATH=p6src
CLIBPATH=clib
P6LIBPATH=p6lib
BINPATH=bin
SRCPATH=$(CSRCPATH) $(P6SRCPATH)
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

.PHONY: ctypes
ctypes: ctypes.out

$(BUILD_DIRS):
	$(MKDIR) $@

.PHONY: test
test: pyrawsocket.out

.PHONY: dirs
dirs: $(BUILD_DIRS)

.PHONY: clean
clean:

	rm -rf $(P6SRCPATH)/.precomp

	for dir in $(BUILD_DIRS); do \
		rm -rf $$dir; \
	done

.PHONY: all
all: | dirs socketwrapper print_const ctypes 
