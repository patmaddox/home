SRCFILES != find src -type f

.MAIN: pre_out
.PHONY: pre_out

.for f in ${SRCFILES}
pre_out/${f:${RELMOD}}: ${f}
	@if [ ! -d ${.TARGET:H} ]; then mkdir -p ${.TARGET:H}; fi
	cp ${.ALLSRC} ${.TARGET}
pre_out: pre_out/${f:${RELMOD}}
.endfor
