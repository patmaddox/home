INFILES != find src -type f -not -name '*~'

.PHONY: all clean

all:

clean:
	rm -rf out paths

rebuild: clean .WAIT all

paths: .EXEC
paths: paths/paths.sql

paths/paths.sql:
	@mkdir -p paths
	@sqlite3 paths/paths.sql 'create table paths(id int primary key not null, path string unique not null)'

.for f in ${INFILES}
out_${f} != ./bin/mksite.sh getoutpath ${f}

${out_${f}}: paths paths/${f} ${f}
	./bin/mksite.sh export ${f} ${.TARGET}

all: ${out_${f}}

paths/${f}: ${f}
	@if [ ! -d ${.TARGET:H} ]; then mkdir -p ${.TARGET:H}; fi
	@./bin/mksite.sh upsertpath ${f}
	@touch ${.TARGET}

paths: paths/${f}

.for l in ${:! ./bin/mksite.sh getlinks $f !}
${out_${f}}: $l
.endfor
.endfor
