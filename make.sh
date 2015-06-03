Target=$1

if [[ $Target == 311 ]]; then
	echo "SGP311" > .MODEL
else
	echo "" > .MODEL
fi

rm -f arch/arm/boot/*.dtb
rm -f .version

### get defconfig
ARCH=arm CROSS_COMPILE=./arm-eabi-4.6/bin/arm-eabi- make fusion3_pollux_windy_custom_defconfig

### compile kernel
ARCH=arm CROSS_COMPILE=./arm-eabi-4.6/bin/arm-eabi- make

#echo "checking for compiled kernel..."
#if [ -f arch/arm/boot/zImage ]
#then
#
#echo "generating device tree..."
#./dtbTool -o dt.img -s 2048 -p ./scripts/dtc/ ./arch/arm/boot/
#
#echo "DONE"

#fi

## Tablet Z
if [[ $Target == 311 ]]; then
./mkbootimg --kernel arch/arm/boot/zImage --ramdisk kernel.sin-ramdisk-SGP311.cpio.gz --pagesize 2048 --base 0x80200000 --cmdline "androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3 vmalloc=400M androidboot.emmc=true" --ramdisk_offset 0x02000000 --output boot.img
else
./mkbootimg --kernel arch/arm/boot/zImage --ramdisk kernel.sin-ramdisk-SGP321.cpio.gz --pagesize 2048 --base 0x80200000 --cmdline "androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3 vmalloc=400M androidboot.emmc=true" --ramdisk_offset 0x02000000 --output boot.img
fi
