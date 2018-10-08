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
VARS="
ch.deletescape.lawnchair.dev
ch.deletescape.lawnchair.ci
ch.deletescape.lawnchair.plah
ch.deletescape.lawnchair
"
  CONF=$INSTALLER/custom/etc/sysconfig
  PERM=$INSTALLER/custom/etc/permissions
  STEP=$INSTALLER/custom/Lawnstep
  if [ -d /product/overlay ]; then
    STEPDIR=/product/overlay
  else
    STEPDIR=$INSTALLER$VEN/overlay
  fi
  APPDIR=$INSTALLER$SYS/priv-app
  PERMDIR=$INSTALLER$SYS/etc/permissions
  CONFDIR=$INSTALLER$SYS/etc/sysconfig
  DATADIR=/data/app
  SYSDIR=/system/priv-app
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

  set_perm_recursive $UNITY$VEN/* 0 2000 0755
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
}
