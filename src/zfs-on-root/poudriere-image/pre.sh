zfs_prepare()
{
    msg "Customized zfs_prepare"

    truncate -s ${IMAGESIZE} ${WRKDIR}/raw.img
    md=$(/sbin/mdconfig ${WRKDIR}/raw.img)
    zroot=${ZFS_POOL_NAME}
    tmpzroot=${TMP_ZFS_POOL_NAME}

    msg "Creating temporary ZFS pool"
    zpool create \
	  -O mountpoint=/${ZFS_POOL_NAME} \
	  -O canmount=noauto \
	  -O checksum=sha512 \
	  -O compression=on \
	  -O atime=off \
	  -t ${tmpzroot} \
	  -R ${WRKDIR}/world ${zroot} /dev/${md} || exit

    msg "Creating ZFS Datasets"
    zfs create -o mountpoint=none ${tmpzroot}/${ZFS_BEROOT_NAME}
    zfs create -o mountpoint=/ ${tmpzroot}/${ZFS_BEROOT_NAME}/${ZFS_BOOTFS_NAME}
    zfs create -o mountpoint=/tmp -o exec=on -o setuid=off ${tmpzroot}/tmp
    zfs create -o mountpoint=/usr -o canmount=off ${tmpzroot}/usr
    zfs create ${tmpzroot}/usr/home
    zfs create -o mountpoint=/var -o canmount=off ${tmpzroot}/var
    zfs create -o exec=off -o setuid=off ${tmpzroot}/var/audit
    zfs create -o exec=off -o setuid=off ${tmpzroot}/var/crash
    zfs create -o exec=off -o setuid=off ${tmpzroot}/var/log
    zfs create -o atime=on ${tmpzroot}/var/mail
    zfs create -o setuid=off ${tmpzroot}/var/tmp
    zfs create -o canmount=off ${tmpzroot}/var/db
    zfs create ${tmpzroot}/var/db/tailscale
    chmod 1777 ${WRKDIR}/world/tmp ${WRKDIR}/world/var/tmp
}
