# Copyright (C) 2015 The CyanogenMod Project
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
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# inherit from universal7420-common
-include device/samsung/universal7420-common/BoardConfigCommon.mk

# Inherit from proprietary vendor
-include vendor/samsung/zero-common/BoardConfigVendor.mk
-include vendor/samsung/zerofltechn/BoardConfigVendor.mk

# Assert
TARGET_OTA_ASSERT_DEVICE := zeroflte,zerofltechn,zerofltezc

# Include path
TARGET_SPECIFIC_HEADER_PATH += device/samsung/zerofltechn/include

# Kernel
TARGET_KERNEL_CONFIG := lineageos_zerofltechn_defconfig

# Radio
BOARD_MODEM_TYPE := mdm9x35
BOARD_ROOT_EXTRA_FOLDERS += firmware

# G9200 external Qualcomm modem policy. Keep this device-specific: the other
# universal7420 variants use Samsung's integrated modem path.
BOARD_SEPOLICY_DIRS += device/samsung/zerofltechn/sepolicy

# Add the G9200-specific NXP NFC HAL declaration to the common device manifest.
DEVICE_MANIFEST_FILE += device/samsung/zerofltechn/manifest.xml

# Partitions
# sda18: 3123200 * 1024 = 3198156800, reserve 3276800 bytes.
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3194880000
