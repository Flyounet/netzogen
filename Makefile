
PREFIX=/usr/local

install:
	cp -f netzogen $(PREFIX)/bin/netzogen
	if [ ! -d "/usr/share/netzogen" ]; then mkdir -p "/usr/share/netzogen"; fi
	cp -f Makefile "/usr/share/netzogen/Makefile"

uninstall:
	rm -f $(PREFIX)/bin/netzogen
	rm -f "/usr/share/netzogen/Makefile"
	rmdir "/usr/share/netzogen"

.PHONY: install uninstall
