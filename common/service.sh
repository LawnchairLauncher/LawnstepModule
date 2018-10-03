# This script will be executed in late_start service mode
# More info in the main Magisk thread
if [ "$SEINJECT" != "/sbin/sepolicy-inject" ]; then
  $SEINJECT --live "allow priv_app device file { read open }"
else
  $SEINJECT -Z priv_app -l
fi
