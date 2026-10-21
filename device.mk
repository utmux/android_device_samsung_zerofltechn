#
# Copyright (C) 2015 The Android Open Kang Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/zerofltechn

## device overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Match the ERK2 product profile expected by Samsung's CHN radio stack.
PRODUCT_CHARACTERISTICS := phone,emulator,china_wlan

# Samsung's proprietary RIL reads its regional feature switches through
# libsecnativefeature from /system/csc/feature.xml.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/csc/feature.xml:system/csc/feature.xml \
    $(LOCAL_PATH)/configs/audio/mixer_paths-audience.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths-audience.xml \
    $(LOCAL_PATH)/configs/audio/mixer_paths-audience.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml

# Properties
TARGET_SYSTEM_PROP += device/samsung/zerofltechn/system.prop

# Vendor security patch level
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lineage.build.vendor_security_patch=2018-11-01

# Install the ERK2 G9200 radio stack before the common blobs so files with
# identical destinations resolve to the CHN/QMI variants.
$(call inherit-product-if-exists, vendor/samsung/zerofltechn/zerofltechn-vendor.mk)

# Inherit from universal7420-common
$(call inherit-product, device/samsung/universal7420-common/universal7420-common.mk)

# G9200 uses an NXP PN66T (PN548 + eSE), not the Samsung S3FWRN5 found on
# the other universal7420 variants.  Replace the common legacy-wrapper service
# with NXP's Android 10 HIDL implementation.  Its dependencies are pulled in by
# the service module; the ERK2 firmware/configuration is supplied by the
# device-specific vendor tree inherited above.
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.1-service

# G9200 uses an STM sensor hub and has no BBD device nodes.  Stop the
# zero-common location-hub daemon before class main is started; otherwise its
# BBD-only binary aborts on /dev/bbd_control and init restarts it every 5s.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/init.g9200.rc:system/vendor/etc/init/init.g9200.rc

# Also get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/zero-common/zero-common-vendor.mk)
