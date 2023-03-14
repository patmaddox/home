PKG = pkg-create-example-${VERSION}.pkg
VERSION= 1.0.0
PREFIX= /usr/local

.PHONY: all clean clean-stage

all: ${PKG}
clean: clean-stage
	rm -f ${PKG} pkg-plist manifest
clean-stage:
	rm -rf stage

SRC_FILES = ${:! find src -type f !}

${PKG}: clean-stage ${SRC_FILES}
	mkdir -p stage${PREFIX}
	cp -Rp src/ stage${PREFIX}/
	cat manifest.in | sed -e 's|%%VERSION%%|${VERSION}|' | sed -e 's|%%PREFIX%%|${PREFIX}|' > manifest
	echo ${:! find stage -type f !:C/^stage//} | tr ' ' '\n' > pkg-plist
	pkg create -M manifest -r stage -p pkg-plist
