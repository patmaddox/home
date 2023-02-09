zfs_prepare()
{
    msg "Customized zfs_prepare"

    truncate -s ${IMAGESIZE} ${WRKDIR}/raw.img
    md=$(/sbin/mdconfig ${WRKDIR}/raw.img)

    msg "Creating temporary ZFS pool"
    zpool create \
	  -O mountpoint=/${ZFS_POOL_NAME} \
	  -O canmount=noauto \
	  -O checksum=sha512 \
	  -O compression=on \
	  -O atime=off \
	  -t ${zroot} \
	  -R ${WRKDIR}/world ${ZFS_POOL_NAME} /dev/${md} || exit

    msg "Creating ZFS Datasets"
    zfs create -o mountpoint=none ${zroot}/${ZFS_BEROOT_NAME}
    zfs create -o mountpoint=/ ${zroot}/${ZFS_BEROOT_NAME}/${ZFS_BOOTFS_NAME}
    zfs create -o mountpoint=/tmp -o exec=on -o setuid=off ${zroot}/tmp
    zfs create -o mountpoint=/usr -o canmount=off ${zroot}/usr
    zfs create ${zroot}/usr/home
    zfs create -o mountpoint=/var -o canmount=off ${zroot}/var
    zfs create -o exec=off -o setuid=off ${zroot}/var/audit
    zfs create -o exec=off -o setuid=off ${zroot}/var/crash
    zfs create -o exec=off -o setuid=off ${zroot}/var/log
    zfs create -o atime=on ${zroot}/var/mail
    zfs create -o setuid=off ${zroot}/var/tmp
    zfs create -o canmount=off ${zroot}/var/db
    zfs create ${zroot}/var/db/tailscale
    chmod 1777 ${WRKDIR}/world/tmp ${WRKDIR}/world/var/tmp
}
