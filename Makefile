.POSIX:

CRYSTAL = crystal
CRFLAGS = --release --warnings all
SOURCES = src/*.cr

DESTDIR =
PREFIX = /usr/local
BINDIR = $(DESTDIR)$(PREFIX)/bin
INSTALL = /usr/bin/install

all: bin/netblog

clean: phony
	rm -f bin/netblog

bin/netblog: $(SOURCES)
	@mkdir -p bin
	$(CRYSTAL) build src/netblog.cr -o bin/netblog $(CRFLAGS)

install: bin/netblog phony
	$(INSTALL) -m 0755 -d "$(BINDIR)"
	$(INSTALL) -m 0755 bin/netblog "$(BINDIR)"

uninstall: phony
	rm -f "$(BINDIR)/netblog"

# rspec and ameba tests
test: check

check: phony
	@./bin/ameba --all

help: phony
	@echo
	@printf '\033[34mall: [default]\033[0m\n'
	@echo
	@printf '\033[34minstall: Requires sudo\033[0m\n'
	@echo
	@printf '\033[34muninstall: Requires sudo\033[0m\n'
	@echo
	@printf '\033[34mclean: Remove compiled binary\033[0m\n'
	@echo
	@printf '\033[34mtest: Spec and ameba tests\033[0m\n'

phony:
