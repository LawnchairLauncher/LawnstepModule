##########################################################################################
#
# Magisk Module Template Config Script
# by topjohnwu
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure the settings in this file (config.sh)
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
#
##########################################################################################

##########################################################################################
# Defines
##########################################################################################

# NOTE: This part has to be adjusted to fit your own needs

# Set to true if you need to enable Magic Mount
# Most mods would like it to be enabled
AUTOMOUNT=true

# Set to true if you need to load system.prop
PROPFILE=false

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=true

# Unity Variables
# Uncomment and change 'MINAPI' and 'MAXAPI' to the minimum and maxium android version for your mod (note that magisk has it's own minimum api: 21 (lollipop))
# Uncomment DYNAMICOREO if you want libs installed to vendor for oreo and newer and system for anything older
# Uncomment DYNAMICAPP if you want anything in $INSTALLER/system/app to be installed to the optimal app directory (/system/priv-app if it exists, /system/app otherwise)
# Uncomment SYSOVERRIDE if you want the mod to always be installed to system (even on magisk)
# Uncomment RAMDISK if you have ramdisk modifications. If you only want ramdisk patching as part of a conditional, just keep this commented out and set RAMDISK=true in that conditional.
# Uncomment DEBUG if you want full debug logs (saved to SDCARD if in twrp, part of regular log if in magisk manager (user will need to save log after flashing)
MINAPI=28
#MAXAPI=25
#SYSOVERRIDE=true
#DYNAMICOREO=true
#DYNAMICAPP=true
#RAMDISK=true
DEBUG=true

# Custom Variables for Install AND Uninstall - Keep everything within this function
unity_custom() {
if [ -f /storage/emulated/0/Documents/Lawnchair/lawnstep ]; then
  FILE=/storage/emulated/0/Documents/Lawnchair/lawnstep
else
  FILE=/data/system/packages.xml
fi
# Package name(s) for the launcher 
VARS="
ch.deletescape.lawnchair.dev
ch.deletescape.lawnchair.ci
ch.deletescape.lawnchair.plah
ch.deletescape.lawnchair
"
# Alternate Quickstep overlays to delete on install (without .apk)
ALTSTEPS="
Hypestep
"
  ### User defined variables ###
  # The directory and filename of the systemised launcher apk (without .apk)
  LAUNCHER=Lawnchair
  # The filename of the overlay to be placed in $STEPDIR (without .apk)
  QUICKSTEP=Lawnstep
  # Filename of the xml to go in /system/etc/sysconfig/
  CONFXML=lawnchair-hiddenapi-package-whitelist.xml
  # Filename of the xml to go in /system/etc/permissions/
  PERMXML=privapp-permissions-lawnchair.xml
  # Directory for the overlays in this module
  STEP=$INSTALLER/custom/Lawnstep
  # The warning to display if the launcher is already detected as a system app
  systemapp_warn() {
    ui_print " "
    ui_print "          $LAUNCHER is already systemised.           "
    ui_print " "
    ui_print "   If $LAUNCHER came with your rom its recommended   "
    ui_print "    to have $QUICKSTEP built into the rom as well.   "
    ui_print "   If you have issues with the module, ask the rom   "
    ui_print "         developer to incorpirate $QUICKSTEP.        "
    ui_print " "
  }

  ### Don't touch the variables below here ###
  CONF=$INSTALLER/custom/etc/sysconfig
  PERM=$INSTALLER/custom/etc/permissions
  if [ -d /product/overlay ]; then
    STEPDIR=/product/overlay
    ALTDIR=/product/overlay
  else
    STEPDIR=$INSTALLER$VEN/overlay
    ALTDIR=$VEN/overlay
  fi
  APPDIR=$INSTALLER$SYS/priv-app
  PERMDIR=$INSTALLER$SYS/etc/permissions
  CONFDIR=$INSTALLER$SYS/etc/sysconfig
  DATADIR=/data/app
  SYSDIR=/system/priv-app
  
  launcher_abort() {
    ui_print "*********************************************"
    ui_print "*     $QUICKSTEP could not be installed     *"
    ui_print "*    Due to $LAUNCHER not being installed   *"
    ui_print "*                                           *"
    ui_print "*  Please install $LAUNCHER, then try again *"
    ui_print "*********************************************"
    abort
  }
  product_abort() {
    ui_print "***************************************"
    ui_print "*  $QUICKSTEP could not be installed  *"
    ui_print "* Due to /product not being mountable *"
    ui_print "*                                     *"
    ui_print "*   A solution is being looked into   *"
    ui_print "***************************************"
    abort
  }

  if [ $STEPDIR == "/product/overlay" ]; then mount -o remount,rw /product || product_abort; fi
}

# Custom Functions for Install AND Uninstall - You can put them here

##########################################################################################
# Installation Message
##########################################################################################

# Set what you want to show when installing your mod

print_modname() {
  ui_print " "
  ui_print "         _____       "
  ui_print "     __ |     | __   "
  ui_print "    |  ||     ||  |  "
  ui_print "    |  ||  ⋋² ||  |  "
  ui_print "    |__||     ||__|  "
  ui_print "        |_____|      "
  ui_print "        Lawnstep     "
  ui_print "                     "
  ui_print "   The Lawnchair Team"
  ui_print " "
}

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# By default Magisk will merge your files with the original system
# Directories listed here however, will be directly mounted to the correspond directory in the system

# You don't need to remove the example below, these values will be overwritten by your own list
# This is an example
REPLACE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here, it will overwrite the example
# !DO NOT! remove this if you don't need to replace anything, leave it empty as it is now
REPLACE="
"

##########################################################################################
# Permissions
##########################################################################################

# NOTE: This part has to be adjusted to fit your own needs

set_permissions() {
  # DEFAULT PERMISSIONS, DON'T REMOVE THEM
  $MAGISK && set_perm_recursive $MODPATH 0 0 0755 0644

  # CUSTOM PERMISSIONS

  set_perm_recursive $UNITY$VEN/overlay 0 2000 0755 0644
  set_perm $UNITY$VEN/overlay/* 0 0 0644

  # Some templates if you have no idea what to do:
  # Note that all files/folders have the $UNITY prefix - keep this prefix on all of your files/folders
  # Also note the lack of '/' between variables - preceding slashes are already included in the variables
  # Use $SYS for system and $VEN for vendor (Do not use $SYS$VEN, the $VEN is set to proper vendor path already - could be /vendor, /system/vendor, etc.)

  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm_recursive $UNITY$SYS/lib 0 0 0755 0644
  # set_perm_recursive $UNITY$VEN/lib/soundfx 0 0 0755 0644

  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm $UNITY$SYS/lib/libart.so 0 0 0644

  if $DEBUG; then
    if $BOOTMODE; then SDCARD=/storage/emulated/0; else SDCARD=/data/media/0; fi
    echo "---Device Info---" > $SDCARD/$MODID-debug-formatted.log
    grep "^ro.product.device[^#]" /system/build.prop | sed 's/ro.product.device/Device/g' >> $SDCARD/$MODID-debug-formatted.log
    grep "^ro.build.type[^#]" /system/build.prop | sed 's/ro.build.type/Buildtype/g' >> $SDCARD/$MODID-debug-formatted.log
    grep "^ro.build.version.security_patch[^#]" /system/build.prop | sed 's/ro.build.version.security_patch/SecurityPatch/g' >> $SDCARD/$MODID-debug-formatted.log
    grep "^ro.product.cpu.abilist[^#]" /system/build.prop | sed 's/ro.product.cpu.abilist/Arch/g' >> $SDCARD/$MODID-debug-formatted.log
    echo -e "\n---Variables---" >> $SDCARD/$MODID-debug-formatted.log
    ( set -o posix ; set ) >> $SDCARD/$MODID-debug-formatted.log
    echo -e "\n---Installed Files---" >> $SDCARD/$MODID-debug-formatted.log
    grep "^+ cp_ch" $SDCARD/$MODID-debug.log | sed 's/.* //g' >> $SDCARD/$MODID-debug-formatted.log
    echo -e "\n---Errors---" >> $SDCARD/$MODID-debug-formatted.log
    grep "^[^+'(ch.)]" $SDCARD/$MODID-debug.log >> $SDCARD/$MODID-debug-formatted.log
    $MAGISK && echo -e "\n---Magisk Version---\n$MAGISK_VER_CODE" >> $SDCARD/$MODID-debug-formatted.log
    echo -e "\n---Module Version---" >> $SDCARD/$MODID-debug-formatted.log
    grep "^versionCode" $INSTALLER/module.prop | sed 's/versionCode/ModuleVersion/g' >> $SDCARD/$MODID-debug-formatted.log
    tar cvf $SDCARD/$MODID-debug.tar -C $SDCARD $MODID-debug.log $MODID-debug-formatted.log > /dev/null
    mkdir -p $SDCARD/Documents/$MODID/logs
    cp -rf $SDCARD/$MODID-debug.tar $SDCARD/Documents/$MODID/logs/
    cp -rf $SDCARD/$MODID-debug.tar /cache/
    rm $SDCARD/$MODID*.log
    rm $SDCARD/$MODID*.tar
  fi
}
