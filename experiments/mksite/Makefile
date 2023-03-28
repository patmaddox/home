INFILES != find src -type f -not -name '*~'

.PHONY: all clean

all:

clean:
	rm -rf out paths

paths: .EXEC
paths: paths/paths.sql

paths/paths.sql:
	@mkdir -p paths
	@sqlite3 paths/paths.sql 'create table paths(id int primary key not null, path string unique not null)'

.for f in ${INFILES}
out_${f} != ./bin/getoutpath.sh ${f}

${out_${f}}: paths paths/${f} ${f}
	./bin/export.sh ${f} ${.TARGET}

all: ${out_${f}}

paths/${f}: ${f}
	@if [ ! -d ${.TARGET:H} ]; then mkdir -p ${.TARGET:H}; fi
	@./bin/upsertpath.sh ${f}
	@touch ${.TARGET}

paths: paths/${f}
.endfor
