# Example port that includes an elixir app's source code.
# This is not a good example of how to package and distribute an Elixir app,
# it's just for testing purposes to get familiar with aspects of the ports framework.

PORTNAME= elixir-bundled-app
DISTVERSION= g202301130937 # I forget what this is - basically a git timestamp?
DISTFILES= # not going to download anything, since the source code is bundled
MAINTAINER= pat@patmaddox.com
COMMENT= A simple port of an elixir application, that brings its own files.
WWW= https://github.com/patmaddox/home/blob/main/ports/patmaddox/elixir-bundled-app
CATEGORIES= patmaddox

ELIXIR_APP_NAME= example_bundled_app
ERLANG_VER?= 24
BUILD_DEPENDS= erlang-runtime${ERLANG_VER}>0:lang/erlang-runtime${ERLANG_VER} elixir-devel>0:lang/elixir-devel
MAKE_ENV+= PATH="${LOCALBASE}/lib/erlang${ERLANG_VER}/bin:${PATH}"
USE_LOCALE= en_US.UTF-8
MIX_ENV?= prod
.export MIX_ENV

# used to substitute the beam SMP version in generated files (e.g. rc script)
#SUB_LIST= ERTS_BEAM_SMP=${ERTS_BEAM_SMP:sh}
#ERTS_BEAM_SMP= cd ${LOCALBASE}/lib/erlang${ERLANG_VER} && find erts-*/bin/beam.smp

PLIST= ${WRKDIR}/PLIST # do-build will dynamically generate the PLIST after `mix release`
RELDIR= ${WRKSRC}/_build/${MIX_ENV}/rel/${ELIXIR_APP_NAME}

do-extract:
	mkdir ${WRKSRC}
	cp -Rp src/${ELIXIR_APP_NAME}/ ${WRKSRC}/

# poudriere needs ALLOW_NETWORKING_PACKAGES="ex_ample"
# to permit hex / rebar / deps network requests
do-build:
	cd ${WRKSRC} && ${MAKE_ENV} mix local.hex --force && ${MAKE_ENV} mix local.rebar --force && ${MAKE_ENV} mix deps.get && ${MAKE_ENV} mix release
	cd ${RELDIR} && find . -name '*.bat' -delete
#	cd ${RELDIR} && find . -name COOKIE -delete
	cd ${RELDIR} && find -s . -type f | sed -e 's/^\./libexec\/${ELIXIR_APP_NAME}/' | tee ${PLIST}

do-install:
	cp -Rp ${RELDIR} ${STAGEDIR}${PREFIX}/libexec/

.include <bsd.port.mk>
