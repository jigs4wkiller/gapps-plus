#MMT Extended Config# MMT Extended Config Script
#Config Flags
MINAPI=30
MAXAPI=30
DYNLIB=true

#Replace list
REPLACE="
/system/media/theme/miui_mod_icons
/system/data-app/ota-miui-MiGalleryLockscreen
/system/product/priv-app/LatinIMEGoogle
/system/product/app/LatinIMEGoogle
/system/product/app/LatinImeGoogle
/system/media/bootaudio.mp3
/system/bin/diag_mdlog_system
/system/bin/kernellog.sh
/system/bin/logcat
/system/bin/logcatkernel.sh
/system/bin/logcatlog.sh
/system/bin/logd
/system/bin/logwrapper
/system/bin/mtdoopslog.sh
/system/bin/crash_dump32
/system/bin/crash_dump64
/system/bin/dumpstate
/system/bin/dumpsys
/system/bin/lpdump
/system/bin/lpdumpd
/system/bin/subsystem_ramdump_system
/system/xbin/mqsasd
/system/vendor/bin/diag_klog
/system/vendor/bin/diag_mdlog
/system/vendor/bin/diag_socket_log
/system/vendor/bin/diag_uart_log
/system/vendor/bin/logwrapper
/system/vendor/bin/pktlogconf
/system/vendor/bin/dumpsys
/system/vendor/bin/i2cdump
/system/vendor/bin/minidump64
/system/vendor/bin/subsystem_ramdump
/system/vendor/bin/tcpdump
/system/vendor/bin/dumpsys
/system/vendor/bin/i2cdump
/system/vendor/bin/minidump64
/system/vendor/bin/subsystem_ramdump
/system/vendor/bin/tcpdump
/system/vendor/bin/ssr_diag
/system/vendor/bin/ssr_setup
"

#Permissions
set_permissions() {
set_perm_recursive $MODPATH 0 0 0755 0644
}

#start uninstall script
unzip -qjo "$ZIPFILE" 'common/ua.sh' -d $TMPDIR >&2
chmod +x "$TMPDIR" 'ua.sh'
. $TMPDIR/ua.sh

#fix yellowish display
unzip -qjo "$ZIPFILE" 'common/nl.sh' -d $TMPDIR >&2
chmod +x "$TMPDIR" 'nl.sh'
. $TMPDIR/nl.sh

#Wifi Bonding (bysimonsmh)
[ -x "$(which magisk)" ] && MIRRORPATH=$(magisk --path)/.magisk/mirror || unset MIRRORPATH
array=$(find /system /vendor -name WCNSS_qcom_cfg.ini)
for CFG in $array
do
[[ -f $CFG ]] && [[ ! -L $CFG ]] && {
SELECTPATH=$CFG
mkdir -p `dirname $MODPATH$CFG`
ui_print "- Migrating $MIRRORPATH$SELECTPATH"
cp -af $MIRRORPATH$SELECTPATH $MODPATH$SELECTPATH
ui_print "- Starting modifiy"
sed -i '/gChannelBondingMode24GHz=/d;/gChannelBondingMode5GHz=/d;/gForce1x1Exception=/d;s/^END$/gChannelBondingMode24GHz=1\ngChannelBondingMode5GHz=1\ngForce1x1Exception=0\nEND/g' $MODPATH$SELECTPATH
}
done
[[ -z $SELECTPATH ]] && abort "- Installation FAILED. Your device didn't support WCNSS_qcom_cfg.ini." || { mkdir -p $MODPATH/system; mv -f $MODPATH/vendor $MODPATH/system/vendor;}

#MMT Extended Logic - Don't modify anything after this
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh
