#!/bin/sh

sed -i s/CONFIG_LOCALVERSION=\".*\"/CONFIG_LOCALVERSION=\"-tvall-${1}\"/ .config

ARCH=arm CROSS_COMPILE=../toolchain-cm9/bin/arm-eabi- make -j2

cp arch/arm/boot/zImage zip/kernel
cp drivers/net/tun.ko zip/system/lib/modules
cp drivers/net/wireless/*/*.ko zip/system/lib/modules
sed -i s/CONFIG_LOCALVERSION=\".*\"/CONFIG_LOCALVERSION=\"\"/ .config
cp .config arch/arm/configs/chaos_defconfig

zipfile="tvall_VM670_Kernel_v${1}.zip"
if [ ! $4 ]; then
	echo "making zip file"
	cd zip/
	rm -f *.zip
	zip -r $zipfile *
	rm -f /tmp/*.zip
	cp *.zip /tmp
fi
