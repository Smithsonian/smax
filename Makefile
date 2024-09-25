# Path to where the xchange library is located
XCHANGE ?= $(PWD)/xchange

# Path to where the RedisX library is ocated
REDISX ?= $(PWD)/redisx

# Path to where the smax-clib library is located
SMAXLIB ?= $(PWD)/smax-clib

# We'll install all libraries and binaries to the following locations
BIN ?= $(PWD)/bin
LIB ?= $(PWD)/lib

# Expor the settings above to sub-makes
export XCHANGE REDISX SMAXLIB BIN LIB

.PHONY: deploy
deploy: shared tools

.PHONY: all
all: shared static tools local-dox

.PHONY: shared
shared:
	make -C xchange shared
	make -C redisx shared
	make -C smax-clib shared

.PHONY: static
static: LDFLAGS += -static
static:
	make -C xchange static
	make -C redisx static
	make -C smax-clib static

.PHONY: tools
tools:
	make -C smax-clib tools
	make -C smax-postgres

.PHONY: local-dox
local-dox:
	make -C xchange local-dox
	make -C redisx local-dox
	make -C smax-clib local-dox
	make -C smax-postgres local-dox

.PHONY: clean
clean:
	make -C xchange clean
	make -C redisx clean
	make -C smax-clib clean
	make -C smax-postgres clean

.PHONY: distclean
distclean:
	make -C xchange distclean
	make -C redisx distclean
	make -C smax-clib distclean
	make -C smax-postgres distclean

# Built-in help screen for `make help`
.PHONY: help
help:
	@echo
	@echo "Syntax: make [target]"
	@echo
	@echo "The following targets are available:"
	@echo
	@echo "  deploy        Builds 'shared' and 'tools' targets (default)."
	@echo "  tools         executable programs."
	@echo "  shared        shared (.so[.1]) libraries."
	@echo "  static        static (.a) libraries."
	@echo "  local-dox     Compiles local HTML API documentation using 'doxygen'."
	@echo "  all           All of the above."
	@echo "  clean         Removes intermediate products."
	@echo "  distclean     Deletes all generated files."
	@echo

