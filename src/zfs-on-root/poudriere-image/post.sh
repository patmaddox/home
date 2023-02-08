msg "Enabling growfs on every boot"
sed -i -e '/KEYWORD: firstboot/d' ${WORLDDIR}/etc/rc.d/growfs
