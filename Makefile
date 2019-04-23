.POSIX:

CRYSTAL = crystal
CRFLAGS = --release
SOURCES = src/*.cr

DESTDIR =
PREFIX = /usr/local
BINDIR = $(DESTDIR)$(PREFIX)/bin
#MANDIR = $(DESTDIR)$(PREFIX)/share/man
INSTALL = /usr/bin/install

all: bin/netblog

clean: phony
	rm -f bin/netblog

bin/netblog: $(SOURCES)
	@mkdir -p bin
	$(CRYSTAL) build src/netblog.cr -o bin/netblog $(CRFLAGS) --warnings all

install: bin/netblog phony
	$(INSTALL) -m 0755 -d "$(BINDIR)"# "$(MANDIR)/man1" "$(MANDIR)/man5"
	$(INSTALL) -m 0755 bin/netblog "$(BINDIR)"
	#$(INSTALL) -m 0644 man/netblog.1 "$(MANDIR)/man1"
	#$(INSTALL) -m 0644 man/netblog-yml.5 "$(MANDIR)/man5"

uninstall: phony
	rm -f "$(BINDIR)/netblog"
#	rm -f "$(MANDIR)/man1/netblog.1"
#	rm -f "$(MANDIR)/man5/netblog-yml.5"

# rspec and ameba tests
test: spec check

spec: phony
	@bin/netblog --generate test_netblog
	$(CRYSTAL) spec spec/netblog_spec.cr

check: phony
	./bin/ameba --all

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
