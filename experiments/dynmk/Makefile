.MAIN: all

SRCSUB = C/^src\///
OUTSUB = C/^out\///

clean:
	rm -rf out out2

INFILES != find src -type f -not -name '*~'

.for f in ${INFILES}
out/${f:${SRCSUB}}: out ${f}
	cp ${f} ${.TARGET}
all: out/${f:${SRCSUB}}
.endfor

out:
	mkdir out
out2:
	mkdir out2

.if exists(out)
NEWFILES != find out -type f
.for f in ${NEWFILES}
out2/${f:${OUTSUB}}: out2 ${f}
	cp ${f} ${.TARGET}

all: out2/${f:${OUTSUB}}
.endfor
.endif
