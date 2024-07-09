# Dolby Atmos OnePlus 8 Visible Magisk Module

## DISCLAIMER
- OnePlus & Dolby apps and blobs are owned by OnePlus™ & Dolby™.
- The MIT license specified here is for the Magisk Module only, not for OnePlus & Dolby apps and blobs.

## Descriptions
- Equalizer sound effect ported from OnePlus 8 Visible (oneplus8visible) and integrated as a Magisk Module for all supported and rooted devices with Magisk
- Global type sound effect
- Conflicted with `vendor.dolby_v3_6.hardware.dms360@2.0-service`, `vendor.dolby_sp.hardware.dmssp@2.0-service`, & `vendor.dolby.hardware.dms@1.0-service`
- Doesn't support ACDB Magisk Module because using effect proxy

## Sources
- https://dumps.tadiphone.dev/dumps/oneplus/oneplus8visible qssi-user-11-RP1A.201005.001-2103312144-release-keys
- system_10: https://dumps.tadiphone.dev/dumps/oneplus/oneplus8visible OnePlus8Visible-user-10-QKQ1.191222.002-2007221621-release-keys
- DaxUI.apk & libswvqe.so: LENOVO TB-J606F
- libhidlbase.so, libhidltransport.so, & libhwbinder.so: CrDroid ROM Android 13
- android.hardware.audio.effect@*-impl.so: https://dumps.tadiphone.dev/dumps/oneplus/op594dl1 qssi-user-14-UKQ1.230924.001-1701915639192-release-keys--US
- libmagiskpolicy.so: Kitsune Mask R65C33E4F

## Screenshots
- https://t.me/androidryukimodsdiscussions/51861

## Requirements
- Android 9 and up
- Architecture 64 bit
- Magisk or KernelSU installed (Recommended to use Magisk Delta/Kitsune Mask for systemless early init mount manifest.xml if your ROM is Read-Only https://t.me/androidryukimodsdiscussions/100091)

## WARNING!!!
- Possibility of bootloop or even softbrick or a service failure on Read-Only ROM if you don't use Magisk Delta/Kitsune Mask.

## Installation Guide & Download Link
- Recommended to use Magisk Delta/Kitsune Mask https://t.me/androidryukimodsdiscussions/100091
- Remove any other else Dolby Magisk module with different name (no need to remove if it's the same name)
- Reboot
- If you have Dolby in-built in your ROM, then you need to activate data.cleanup=1 at the first time install (READ Optionals bellow!)
- Install this module https://www.pling.com/p/1461991/ via Magisk app or KernelSU app or Recovery if Magisk installed
- Install AML Magisk Module https://t.me/androidryukimodsdiscussions/29836 only if using any other else audio mod module
- If you are using KernelSU, you need to disable Unmount Modules by Default in KernelSU app settings
- Reboot
- If you are using KernelSU, you need to allow superuser list manually all package name listed in package.txt (and your home launcher app also) (enable show system apps) and reboot afterwards
- If you are using SUList, you need to allow list manually your home launcher app (enable show system apps) and reboot afterwards
- If you have sensors issue (fingerprint, proximity, gyroscope, etc), then READ Optionals bellow!

## Optionals
- https://t.me/androidryukimodsdiscussions/2616
- Global: https://t.me/androidryukimodsdiscussions/60861
- Stream: https://t.me/androidryukimodsdiscussions/26764

## Troubleshootings
- https://t.me/androidryukimodsdiscussions/2617
- Global: https://t.me/androidryukimodsdiscussions/29836

## Support & Bug Report
- https://t.me/androidryukimodsdiscussions/2618

## Tested on
- Android 10 CrDroid ROM
- Android 11 DotOS ROM
- Android 12 AncientOS ROM
- Android 12.1 Nusantara ROM
- Android 13 CrDroid ROM
- Android 14 LineageOS ROM

## Credits and Contributors
- https://t.me/viperatmos
- https://t.me/androidryukimodsdiscussions
- @HELLBOY017
- You can contribute ideas about this Magisk Module here: https://t.me/androidappsportdevelopment

## Sponsors
- https://t.me/androidryukimodsdiscussions/2619


