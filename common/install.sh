for VAR in $VARS; do
  if [ -f $DATADIR/$VAR-*/base.apk ] \
    || [ -f $SYSDIR/$LAUNCHER*/$LAUNCHER*.apk ]; then
    STEPAPK=$(grep -Fo -m 1 "$VAR" "$FILE")
    STEPAPK=$(echo $STEPAPK | sed "s| .*||")
    if [ ! -z $STEPAPK ]; then
      SUCCESS=true
      ui_print " "
      ui_print "   $VAR detected!"
      ui_print " "
      if [ -d $DATADIR/$VAR* ]; then
        cp_ch $DATADIR/$VAR*/*.apk $APPDIR/$LAUNCHER/$LAUNCHER.apk
      elif [ -d $SYSDIR/$LAUNCHER -a ! -f $STEPDIR/$QUICKSTEP.apk ]; then
        systemapp_warn
      fi
      cp_ch $STEP/$STEPAPK.apk $STEPDIR/$QUICKSTEP.apk
      sed -i "s|<VAR>|$VAR|" $PERM/$PERMXML
      sed -i "s|<VAR>|$VAR|" $CONF/$CONFXML
      cp_ch $PERM/$PERMXML $PERMDIR/$PERMXML
      cp_ch $CONF/$CONFXML $CONFDIR/$CONFXML
      rm /data/resource-cache/overlays.list
      for ALT in $ALTSTEPS; do
        case $(find $ALTDIR/$ALT*) in
          *$ALT*)
            rm -rf $ALTDIR/$ALT*
            ui_print " "
            ui_print "   Alternate quickstep overlay found!"
            ui_print "        Deleting $ALTDIR/$ALT        "
            ui_print " ";;
        esac
      done
      break
    fi
  fi
done
if [ -z $SUCCESS ]; then launcher_abort; fi