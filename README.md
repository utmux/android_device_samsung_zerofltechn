# LineageOS 17.1 device tree for Samsung Galaxy S6 (SM-G9200)

Android 10 bring-up for the Chinese dual-SIM Galaxy S6, codename
`zerofltechn`. This tree targets the SM-G9200 only and uses the
`G9200ZCU2ERK2` Android 7.0 firmware as its proprietary-blob base.

## Source layout

| Path | Repository |
| --- | --- |
| `device/samsung/zerofltechn` | `utmux/android_device_samsung_zerofltechn` |
| `device/samsung/universal7420-common` | `utmux/android_device_samsung_universal7420-common` |
| `vendor/samsung` | `utmux/proprietary_vendor_samsung` |
| `kernel/samsung/universal7420` | `utmux/android_kernel_samsung_universal7420` |

The device tree also carries the small LineageOS 17.1 source patches required
for the G9200 radio stack:

- `patches/frameworks_opt_telephony.patch`
- `patches/hardware_samsung.patch`

Apply them from the Android source root before building:

```bash
git -C frameworks/opt/telephony apply \
    "$PWD/device/samsung/zerofltechn/patches/frameworks_opt_telephony.patch"
git -C hardware/samsung apply \
    "$PWD/device/samsung/zerofltechn/patches/hardware_samsung.patch"
```

## Build

```bash
source build/envsetup.sh
lunch lineage_zerofltechn-userdebug
mka bacon -j4
```

## Tested

- Boots LineageOS 17.1 / Android 10
- Dual-SIM detection
- China Telecom and China Unicom mobile data
- Wi-Fi, Bluetooth and audio
- Light, proximity, pressure and other sensors
- NXP PN66T NFC, including off/on cycles

## Known limitations

- SELinux is permissive.
- China Mobile VoLTE has not been tested.
- The legacy Exynos 7420 OMX blobs do not support Android 10's
  `DynamicANWBuffer` direct-output path. FFmpeg/mpv applications such as
  PiliPlus must use `mediacodec-copy` or software decoding instead of direct
  `mediacodec` output.

## Notes

The proprietary G9200 blobs were extracted from `G9200ZCU2ERK2`. They remain
the property of their respective copyright holders and are provided only to
support this device.

This work builds on the LineageOS and universal7420 community device trees.

