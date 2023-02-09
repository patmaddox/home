GCE_IMAGE_VERSION= 2023-02-09_00 # reset _NN to _00 when building on a new day
GCE_POUDRIERE_IMG= /usr/local/poudriere/data/images/131gcebase.img
GCE_TGZ= 131-gce-base-${GCE_IMAGE_VERSION}.tar.gz

default:
	@echo '`just` is the entrypoint!'
	@just

gce_tgz: images/${GCE_TGZ}
images/${GCE_TGZ}: ${GCE_POUDRIERE_IMG}
	@mkdir -p images/work
	cp /usr/local/poudriere/data/images/131gcebase.img images/work/disk.raw
	cd images/work && tar --format=gnutar -zcf disk.raw.tar.gz disk.raw
	mv images/work/disk.raw.tar.gz ${.TARGET}

clean:
	rm -rf images/work
