INFILES != find src -type f

all:

clean:
	rm -rf out

.for f in ${INFILES}
out_${f} != ./bin/getoutpath.sh ${f}

${out_${f}}: out ${f}
	cp ${f} ${.TARGET}

all: ${out_${f}}
.endfor


out:
	mkdir out
