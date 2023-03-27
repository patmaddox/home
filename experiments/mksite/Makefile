INFILES != find src -type f -not -name '*~'

all:

clean:
	rm -rf out

.for f in ${INFILES}
out_${f} != ./bin/getoutpath.sh ${f}

${out_${f}}: out ${f}
	cat ${f} | sed -E -e '/---/,/---/d' | markdown -o ${.TARGET}

all: ${out_${f}}
.endfor


out:
	mkdir out
