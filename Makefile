target := hello
sourcedir := source
includedir := include
builddir := .build

CFLAGS += -I$(includedir) -O3 -g -std=gnu11 -Wall -Wextra -Wpedantic -Werror -Wduplicated-cond -Wduplicated-branches -Wlogical-op -Wnull-dereference -Wjump-misses-init -Wshadow -Wformat=2

LDFLAGS += 
MKDIR := mkdir -p

.DEFAULT_GOAL := $(target)

sources := $(wildcard $(sourcedir)/*.c)
dependencies := $(patsubst %.c, $(builddir)/%.d, $(sources))
objects := $(patsubst %.c, $(builddir)/%.o, $(sources))

$(target): $(objects)
	$(CC) -o $@ $(objects) $(LDFLAGS)

$(builddir)/%.o: %.c $(MAKEFILE_LIST)
	$(MKDIR) $(dir $@)
	$(CC) -MMD -MP $(CFLAGS) -o $@ -c $<

-include $(dependencies)
