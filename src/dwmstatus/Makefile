CC = cc
CFLAGS = -lX11
DESTDIR = /usr/local

all: dwmstatus

dwmstatus:
	${CC} -o $@ ${CFLAGS} dwmstatus.c

clean:
	rm -f dwmstatus

install: all
	mkdir -p ${DESTDIR}/bin
	cp -f dwmstatus ${DESTDIR}/bin
	chmod 755 ${DESTDIR}/bin/dwmstatus

uninstall:
	rm -f ${DESTDIR}/bin/dwmstatus

.PHONY: all clean install uninstall
