INFILES != find src -type f -name '*.md'

.PHONY: all clean rebuild test
.MAIN: all

all:

clean:
	rm -rf out

rebuild: clean .WAIT all

.for f in ${INFILES}
out_${f} != ./bin/mksite.sh getoutpath ${f}

${out_${f}}: ${f}
	./bin/mksite.sh export ${f} ${.TARGET}

all: ${out_${f}}

.for l in ${:! ./bin/mksite.sh getlinks $f !}
$l: $f
.endfor
.endfor

make test:
	cd test && kyua test
