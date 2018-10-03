if [ -f $DATADIR/ch.deletescape.lawnchair.dev*/base.apk ] || [ -f $DATADIR/ch.deletescape.lawnchair.ci*/base.apk ] || [ -f $DATADIR/ch.deletescape.lawnchair.plah*/base.apk ] || [ -f $DATADIR/ch.deletescape.lawnchair-*/base.apk ] || [ -f $SYSDIR/Lawnchair*/Lawnchair*.apk ]; then
  for var in $VARS; do
    case $(grep -F "$var" "$XML") in
      *ch.deletescape.lawnchair.dev*)
        ui_print "   $var detected!"
        if [ -d $DATADIR/$var* ]; then
          cp_ch $DATADIR/$var*/*.apk $APPDIR/Lawnchair-Dev/Lawnchair-Dev.apk
        elif [ -d $SYSDIR/Lawnchair-Dev ]; then
          ui_print "   $var already systemlessly systemised"
        fi
        cp_ch $STEP/LawnstepDev.apk $STEPDIR/Lawnstep-Dev.apk
        sed -i "s|<VAR>|$var|" $PERM/privapp-permissions-lawnchair.xml
        sed -i "s|<VAR>|$var|" $CONF/lawnchair-hiddenapi-package-whitelist.xml
        cp_ch $PERM/privapp-permissions-lawnchair.xml $PERMDIR/privapp-permissions-lawnchair-dev.xml
        cp_ch $CONF/lawnchair-hiddenapi-package-whitelist.xml $CONFDIR/lawnchair-dev-hiddenapi-package-whitelist.xml
        LCVAR="-Dev"
        VARIANT=ch.deletescape.lawnchair.dev
        break;;
      *ch.deletescape.lawnchair.ci*)
        ui_print "   $var detected!"
        if [ -d $DATADIR/$var* ]; then
          cp_ch $DATADIR/$var*/*.apk $APPDIR/Lawnchair-Ci/Lawnchair-Ci.apk
        elif [ -d $SYSDIR/Lawnchair-Ci ]; then
          ui_print "   $var already systemlessly systemised"
        fi
        cp_ch $STEP/LawnstepCi.apk $STEPDIR/Lawnstep-Ci.apk
        sed -i "s|<VAR>|$var|" $PERM/privapp-permissions-lawnchair.xml
        sed -i "s|<VAR>|$var|" $CONF/lawnchair-hiddenapi-package-whitelist.xml
        cp_ch $PERM/privapp-permissions-lawnchair.xml $PERMDIR/privapp-permissions-lawnchair-ci.xml
        cp_ch $CONF/lawnchair-hiddenapi-package-whitelist.xml $CONFDIR/lawnchair-ci-hiddenapi-package-whitelist.xml
        LCVAR="-Ci"
        VARIANT=ch.deletescape.lawnchair.ci
        break;;
      *ch.deletescape.lawnchair.plah*)
        ui_print "   $var detected!"
        if [ -d $DATADIR/$var* ]; then
          cp_ch $DATADIR/$var*/*.apk $APPDIR/Lawnchair-Plah/Lawnchair-Plah.apk
        elif [ -d $SYSDIR/Lawnchair-Plah ]; then
          ui_print "   $var already systemlessly systemised"
        fi
        cp_ch $STEP/LawnstepPlah.apk $STEPDIR/Lawnstep-Plah.apk
        sed -i "s|<VAR>|$var|" $PERM/privapp-permissions-lawnchair.xml
        sed -i "s|<VAR>|$var|" $CONF/lawnchair-hiddenapi-package-whitelist.xml
        cp_ch $PERM/privapp-permissions-lawnchair.xml $PERMDIR/privapp-permissions-lawnchair-plah.xml
        cp_ch $CONF/lawnchair-hiddenapi-package-whitelist.xml $CONFDIR/lawnchair-plah-hiddenapi-package-whitelist.xml
        LCVAR="-Plah"
        VARIANT=ch.deletescape.lawnchair.plah
        break;;
      *'ch.deletescape.lawnchair '*)
        ui_print "   $var detected!"
        if [ -d $DATADIR/$var* ]; then
          cp_ch $DATADIR/$var*/*.apk $APPDIR/Lawnchair/Lawnchair.apk
        elif [ -d $SYSDIR/Lawnchair ]; then
          ui_print "   $var already systemlessly systemised"
        fi
        cp_ch $STEP/Lawnstep.apk $STEPDIR/Lawnstep.apk
        sed -i "s|<VAR>|$var|" $PERM/privapp-permissions-lawnchair.xml
        sed -i "s|<VAR>|$var|" $CONF/lawnchair-hiddenapi-package-whitelist.xml
        cp_ch $PERM/privapp-permissions-lawnchair.xml $PERMDIR/privapp-permissions-lawnchair.xml
        cp_ch $CONF/lawnchair-hiddenapi-package-whitelist.xml $CONFDIR/lawnchair-hiddenapi-package-whitelist.xml
        LCVAR=
        VARIANT=ch.deletescape.lawnchair
        break;;
    esac
    rm /data/resource-cache/overlays.list
  done
else
  abort "   Lawnchair not detected. aborting"
fi
