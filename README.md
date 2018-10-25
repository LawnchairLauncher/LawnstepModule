# Lawnstep - Lawnchair Quickstep enabler
Lawnstep is a magisk module which systemlessly enables Pie recents (Quickstep) in Lawnchair

## Donations:
If you wish to donate to Till for creating Lawnchair you can do so by purchasing [Donut Donation](https://play.google.com/store/apps/details?id=ch.deletescape.donut) or via his [Paypal](https://paypal.me/Deletescape).
Or if you wish to donate to Skittles9823 for making the module you can do so [here](https://paypal.me/Skittles2398).

## Compatibility:
- Magisk v17.2+
- SuperSU
- Init.d support if not using Magisk or SuperSU (Try [Init.d Injector](https://forum.xda-developers.com/android/software-hacking/mod-universal-init-d-injector-wip-t3692105))

## Requirements:
- Magisk v17.2+
- Android 9.0 Pie
- Lawnchair v2 - 420+ (p_merge branch)

## Sources and used/needed tools:
- [Module Source](https://github.com/LawnchairLauncher/LawnstepModule)
- [Lawnchair](https://github.com/LawnchairLauncher/Lawnchair)
- [Unity](https://github.com/Zackptg5/Unity) by [Zackptg5](https://github.com/Zackptg5)
- [Magisk](https://github.com/topjohnwu/Magisk) by [topjohnwu](https://forum.xda-developers.com/member.php?u=4470081)
- [Magisk module template](https://github.com/topjohnwu/magisk-module-template) by [topjohnwu](https://forum.xda-developers.com/member.php?u=4470081)

## Changelog:
### v1.0.7
- fix install for users with /product/overlay

### v1.0.6
- fix logging

### v1.0.5
- add Lawnchair to battery optimisation whitelist (should prevent Lawnchair from getting killed in the background)
- format code in install.sh
- add formatted debugging logs
- change log output to /sdcard/Documents/Lawnchair/logs/Lawnstep-logs.tar

### v1.0.4
- fix permissions for the overlay
- add changelog to README.md due to contemplating submitting the module to the Magisk repo
- set minMagisk to 17200 so Magisk 17.2 must be used to install the module
- prepare for packaging the module with Lawnchair
- Cleanup unused code

### v1.0.3
- fix Lawnfeed breaking the install

### v1.0.2
- rm /data/resource-cache/overlays.list on install too
- Always delete /data/resource-cache/overlays.list on uninstall to attempt to prevent bootloops
- Remove the backup script as the script doesn't delete the user app anymore
- Fix lawnfeed breaking the module

### v1.0.1
- don't delete lawnchair from /data/app on install

### v1.0.0
- Initial release
