INFILES != find src -type f -not -name '*~'

.PHONY: all clean paths

all:

clean:
	rm -rf out paths

.for f in ${INFILES}
out_${f} != ./bin/getoutpath.sh ${f}

${out_${f}}: out ${f}
	./bin/export.sh ${f} ${.TARGET}

all: paths ${out_${f}}

paths/${f}:
	@if [ ! -d ${.TARGET:H} ]; then mkdir -p ${.TARGET:H}; fi
	@./bin/getoutpath.sh ${f} > ${.TARGET}

paths: paths/${f}
.endfor


out:
	@mkdir out
