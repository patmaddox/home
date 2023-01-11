PORTNAME= jectl
PORTVERSION=0.0.1
CATEGORIES= sysutils

MAKE_ARGS= -m /usr/src/share/mk

USE_GITHUB= yes
GH_ACCOUNT= KlaraSystems
GH_TAGNAME= 68fa5ef9ab5e221f378a88f92c0b317ddd10d315

PLIST_FILES= sbin/jectl

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${PORTNAME} ${STAGEDIR}${PREFIX}/sbin

.include <bsd.port.mk>
