# Add a GH_TOKEN to make.conf
# can be port-specific with patmaddox_org_GH_TOKEN

PORTNAME= patmaddox-org
DISTVERSION= g20230208
CATEGORIES= patmaddox
MASTER_SITE_BACKUP=

FETCH_DEPENDS= curl:ftp/curl

FETCH_BINARY=/usr/local/bin/curl
FETCH_ARGS= -s -f -H @${TEMP_AUTH}
FETCH_ARGS+= -o ${DISTDIR}/${DISTFILES}
DISABLE_SIZE= yes # so do-fetch.sh doesn't add a -S flag

USE_GITHUB= yes
GH_ACCOUNT= patmaddox
GH_PROJECT= org
GH_TAGNAME= e70fc8bb5b280805fd2d3a58629e3b60f4637852
GH_TOKEN ?= ${${PKGCATEGORY}_${PORTDIRNAME}_GH_TOKEN}
TEMP_AUTH:= ${:!/usr/bin/mktemp!}

pre-fetch:
	@echo "Authorization: token ${GH_TOKEN}" > ${TEMP_AUTH}

post-fetch:
	@if [ -f ${TEMP_AUTH} ]; then rm ${TEMP_AUTH}; fi

.include <bsd.port.mk>
