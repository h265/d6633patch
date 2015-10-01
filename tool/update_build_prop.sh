#!/sbin/sh
# For Z3 Dual 5.1.1 23.4.A.0.5xx
# 2015-09-20
# By luala
#
echo "	Running $0"
if [ ! -f "/system/build.prop" ]; then
	echo "	File /system/build.prop does not exist"
	exit 1
fi
#backup
/sbin/busybox cp /system/build.prop /tmp/build.prop

#Version tag
VERSION_STR="Additional props for D6633 Dual v1.1 by luala"
if ! /sbin/busybox cat /tmp/build.prop | grep "${VERSION_STR}" > /dev/null; then
    echo "" >> /tmp/build.prop
    echo "#${VERSION_STR}" >> /tmp/build.prop
fi

update()
{
	NAME="${1}"
	VALUE="${2}"
	if /sbin/busybox grep -q "${NAME}=" /tmp/build.prop ; then
		/sbin/busybox sed -i "s|${NAME}=.*|${NAME}=${VALUE}|g" /tmp/build.prop
	else
		echo "${NAME}=${VALUE}" >> /tmp/build.prop
	fi
}


#sec-build ver
update ro.build.product "D6633"

update ro.build.description "D6633-user 5.1.1 23.4.A.0.546 864948651 release-keys"
update ro.product.name D6633
update ro.product.device D6633
update ro.build.fingerprint "Sony/D6633/D6633:5.1.1/23.4.A.0.546/864948651:user/release-keys"
update ro.semc.version.cust 1290-5630
update ro.semc.version.cust_revision R6C
update ro.somc.customerid 104
#product ver
update ro.semc.product.model D6633
update ro.semc.ms_type_id "PM-0808-BV"
update ro.semc.product.name "Xperia™ Z3 Dual"
update ro.product.model D6633
#flavor
update ro.build.flavor leo_dsds-user
# NFC
update ro.nfc.on.default false
#Radio
update persist.radio.ignore_dom_time 120
update persist.multisim.config dsds
update persist.radio.disable_flexmap 1
update persist.radio.multisim.config dsds

#backup
/sbin/busybox cp /system/build.prop /system/build.prop.orig
/sbin/busybox mv /tmp/build.prop /system/build.prop
#End