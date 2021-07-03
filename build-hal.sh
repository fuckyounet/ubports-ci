#!/bin/bash
source halium.env
cd $ANDROID_ROOT


source build/envsetup.sh
bash hybris-patches/apply-patches.sh --mb
export USE_CCACHE=1
breakfast $DEVICE
make -j$(nproc) mkbootimg
make -j$(nproc) fec
make -j$(nproc) halium-boot
make -j$(nproc) systemimage 
make -j$(nproc) vendorimage 

echo "md5sum halium-boot.img, system.img and vendor.img"
md5sum $ANDROID_ROOT/out/target/product/clover/halium-boot.img
md5sum $ANDROID_ROOT/out/target/product/clover/system.img
md5sum $ANDROID_ROOT/out/target/product/clover/vendor.img
