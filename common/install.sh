#jigs4wkiller
#unzip
tar -xf "$MODPATH/common/zip/base.tar.xz" -C $MODPATH;
tar -xf "$MODPATH/common/zip/sys.tar.xz" -C $MODPATH;
tar -xf "$MODPATH/common/zip/ui.tar.xz" -C $MODPATH;
tar -xf "$MODPATH/common/zip/uni.tar.xz" -C $MODPATH;
tar -xf "$MODPATH/common/zip/wall.tar.xz" -C $MODPATH;
#key selection
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you use stock China ROM ?"
ui_print "   this will remove the MIUI launcher"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
      echo "true"
  ui_print "- Enabling CN fix..."
  pm uninstall --user 0 com.miui.home
    else
      echo "false"
  ui_print "- Skip CN fix..."
  rm -rf $MODPATH/system/priv-app/MiuiHome
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want Google fonts?"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
      echo "true"
  ui_print "- Enabling font..."
    tar -xf "$MODPATH/common/zip/font.tar.xz" -C $MODPATH;
    else
      echo "false"
  ui_print "- Disabling font..."
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want modded AOSP Recents? including round icons!"
ui_print "   this option replaces the original Pixel Launcher"
ui_print "   with the moded one from MrSluffy | Pixel Launcher XI"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
     echo "true"
  ui_print "- AOSP Recents..."
  ui_print "- MrSluffy is the best..."
  rm -rf $MODPATH/system/system_ext/priv-app/NexusLauncherRelease
    tar -xf "$MODPATH/common/zip/pxl.tar.xz" -C $MODPATH;
    else
      echo "false"
  ui_print "- sad google noises..."
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want the AOSP volume panel and boot menu?"
ui_print "   Please disable the advanced restart option if you want"
ui_print "   if you want to use the AOSP boot menu"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
     echo "true"
  ui_print "- AOSP volume panel and boot menu getting activated..."
    tar -xf "$MODPATH/common/zip/vol.tar.xz" -C $MODPATH;
    else
      echo "false"
  ui_print "- MIUI UI is also pretty good..."
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want to install YouTube Vanced Manager?"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
      echo "true"
  ui_print "- Installing YouTube Vanced Manager"
  cp "$MODPATH/vm.apk" /data/local/tmp >&2
  pm install -r "/data/local/tmp/vm.apk"
    else
      echo "false"
  ui_print "- Skip installation..."
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want to install AdAway?"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
      echo "true"
  ui_print "- Installing AdAway"
  cp "$MODPATH/ad.apk" /data/local/tmp >&2
  pm install -r "/data/local/tmp/ad.apk"
    else
      echo "false"
  ui_print "- Skip app install..."
  rm -rf $MODPATH/system/etc/hosts
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want to install Ruthless Launcher?"
ui_print "   RECOMMEND other launchers can be buggy!"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
      echo "true"
  ui_print "- Installing Ruthless Launcher"
  cp "$MODPATH/sh.apk" /data/local/tmp >&2
  cp "$MODPATH/ab.apk" /data/local/tmp >&2
  pm install -r "/data/local/tmp/sh.apk"
  pm install -r "/data/local/tmp/ab.apk"
    else
      echo "false"
  ui_print "- Skip app install..."
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want to install my Pixelized Sony Music player?"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
      echo "true"
  ui_print "- Installing Sony Music PXL Mod"
  cp "$MODPATH/sm.apk" /data/local/tmp >&2
  pm install -r "/data/local/tmp/sm.apk"
    else
      echo "false"
  ui_print "- Skip app install..."
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want to install OnePlus Sound recorder • Pixel MOD?"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
      echo "true"
  ui_print "- Installing OnePlus Sound Recorder • PixelMOD"
  cp "$MODPATH/sr.apk" /data/local/tmp >&2
  pm install -r "/data/local/tmp/sr.apk"
    else
      echo "false"
  ui_print "- Skip app install..."
fi
ui_print " "
ui_print " "
ui_print "_____________________________________________"
ui_print " "
ui_print "   Do you want to optimize all your apps?"
ui_print "   with 80 apps it will take up to 15-20 minutes"
ui_print " "
ui_print "→ Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
      echo "true"
ui_print " - Apps getting optimized"
ui_print "   Please be patient"
ui_print "   This process can take up to 15 minutes"
ui_print " "
su -c cmd package bg-dexopt-job
ui_print " "
ui_print " Apps optimized!"
ui_print " "
    else
      echo "false"
  ui_print "- Skip app optimization..."
fi
#zipalign
ui_print "- Zipalign some apps..."
do_zipalign() {
  cp "$MODPATH/zipalign" /data/local/tmp >&2
chmod 775 /data/local/zipalign
for apk in "$MODPATH" 'system_ext/priv-app/*/*.apk' "$MODPATH" 'system/app/*/*.apk' "$MODPATH" 'system/priv-app/*/*.apk' "$MODPATH" 'system/product/priv-app/*/*.apk' "$MODPATH" 'system/product/app/*/*.apk'; do
   $zipalign -c -v 4 "$apk" 1>&2;
done;
}

zipalign
#apk cleaning
cleanup() {
ui_print "- Deleting installation files..."
rm -rf /data/adb/modules/miui-gapps/ad.apk
rm -rf /data/adb/modules/miui-gapps/ab.apk
rm -rf /data/adb/modules/miui-gapps/sh.apk
rm -rf /data/adb/modules/miui-gapps/vm.apk
rm -rf /data/adb/modules/miui-gapps/sr.apk
m -rf /data/adb/modules/miui-gapps/sm.apk
rm -rf /data/adb/modules_update/miui-gapps/ad.apk
rm -rf /data/adb/modules_update/miui-gapps/ab.apk
rm -rf /data/adb/modules_update/miui-gapps/vm.apk
rm -rf /data/adb/modules_update/miui-gapps/vm.apk
rm -rf /data/adb/modules_update/miui-gapps/sr.apk
rm -rf /data/adb/modules_update/miui-gapps/sh.apk
rm -rf /data/adb/modules_update/miui-gapps/sm.apk
rm -rf /data/local/tmp/ad.apk
rm -rf /data/local/tmp/ab.apk
rm -rf /data/local/tmp/vm.apk
rm -rf /data/local/tmp/sr.apk
rm -rf /data/local/tmp/sh.apk
rm -rf /data/local/tmp/sm.apk
rm -rf $MODPATH/LICENSE
ui_print "- Deleting cache, dalvik and logs..."
rm -rf /data/magisk_backup_*
rm -rf /data/resource-cache/*
rm -rf /data/system/package_cache/*
rm -rf /data/vendor/wlan_logs
rm -rf /cache/*
rm -rf /data/dalvik-cache/*
rm -rf  /data/adb/service.d/opt.sh
rm -rf /data/adb/modules/UniversalGMSDoze
rm -rf $MODPATH/common/zip
rm -rf $MODPATH/common
}

cleanup
#finish
