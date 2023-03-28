INFILES != find src -type f -not -name '*~'

.PHONY: all clean

all:

clean:
	rm -rf out paths

paths/paths.sql:
	@mkdir -p paths
	@sqlite3 paths/paths.sql 'create table paths(id int primary key not null, path string unique not null)'

.for f in ${INFILES}
out_${f} != ./bin/getoutpath.sh ${f}

${out_${f}}: paths/paths.sql ${f}
	./bin/export.sh ${f} ${.TARGET}

all: ${out_${f}}

paths/${f}: .USE
	@if [ ! -d ${.TARGET:H} ]; then mkdir -p ${.TARGET:H}; fi
	@./bin/insertpath.sh ${f}
	touch ${.TARGET}

paths/paths.sql: paths/${f}
.endfor
