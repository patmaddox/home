INFILES != find src -type f

.for f in ${INFILES}
out_${f} = ${:! echo ${f} | sed -e 's/^src\//out\//' !}

${out_${f}}: out ${f}
	cp ${f} ${.TARGET}
.endfor

out:
	mkdir out
