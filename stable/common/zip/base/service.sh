#!/system/bin/sh
#Waiting
sleep 5
wait_boot_complete() {
until [[ "$(getprop sys.boot_completed)" -eq 1 ]] || [[ "$(getprop dev.bootcomplete)" -eq 1 ]]; do
       sleep 2
done
}
wait_boot_complete
sleep 30
su -c  cmd settings put system miui_home_double_tap_to_lock 1
su -c  cmd settings put global GPUTUNER_SWITCH true
#fixing package installer
sleep 30
su -c cmd package install-existing "com.google.android.packageinstaller"

#ptach from pixlify
export DIALER_PREF=/data/data/com.google.android.dialer/shared_prefs/dialer_phenotype_flags.xml
export GBOARD_PREF=/data/data/com.google.android.inputmethod.latin/shared_prefs/flag_value.xml
export FIT=/data/data/com.google.android.apps.fitness/shared_prefs/growthkit_phenotype_prefs.xml
export GOOGLE_PREF=/data/data/com.google.android.googlequicksearchbox/shared_prefs/GEL.GSAPrefs.xml
export TURBO=/data/data/com.google.android.apps.turbo/shared_prefs/phenotypeFlags.xml
export PHOTOS=/data/data/com.google.android.apps.photos/shared_prefs/com.google.android.apps.photos.phenotype.xml

temp=""

pm_enable() {
    pm enable $1 > /dev/null 2>&1
    log "Enabling $1"
}

log() {
    date=$(date +%y/%m/%d)
    tim=$(date +%H:%M:%S)
    temp="$temp
$date $tim: $@"
}

set_prop() {
    setprop "$1" "$2"
    log "Setting prop $1 to $2"
}

bool_patch() {
    file=$2
    if [ -f $file ]; then
        line=$(grep $1 $2 | grep false | cut -c 16- | cut -d' ' -f1)
        for i in $line; do
            val_false='value="false"'
            val_true='value="true"'
            write="${i} $val_true"
            find="${i} $val_false"
            log "Setting bool $(echo $i | cut -d'"' -f2) to True"
            sed -i -e "s/${find}/${write}/g" $file
        done
    fi
}

bool_patch_false() {
    file=$2
    if [ -f $file ]; then
        line=$(grep $1 $2 | grep false | cut -c 14- | cut -d' ' -f1)
        for i in $line; do
            val_false='value="true"'
            val_true='value="false"'
            write="${i} $val_true"
            find="${i} $val_false"
            log "Setting bool $i to False"
            sed -i -e "s/${find}/${write}/g" $file
        done
    fi
}

string_patch() {
    file=$3
    if [ -f $file ]; then
        str1=$(grep $1 $3 | grep string | cut -c 14- | cut -d'>' -f1)
        for i in $str1; do
            str2=$(grep $i $3 | grep string | cut -c 14- | cut -d'<' -f1)
            add="$i>$2"
            if [ ! "$add" == "$str2" ]; then
                log "Setting string $i to $2"
                sed -i -e "s/${str2}/${add}/g" $file
            fi
        done
    fi
}

long_patch() {
    file=$3
    if [ -f $file ]; then
        lon=$(grep $1 $3 | grep long | cut -c 17- | cut -d'"' -f1)
        for i in $lon; do
            str=$(grep $i $3 | grep long | cut -c 17-  | cut -d'"' -f1-2)
            str1=$(grep $i $3 | grep long | cut -c 17- | cut -d'"' -f1-3)
            add="$str\"$2"
            if [ ! "$add" == "$str1" ]; then
                log "Setting string $i to $2"
                sed -i -e "s/${str1}/${add}/g" $file
            fi
        done
    fi
}

mkdir -p /sdcard/GAppsPlus

log "Service Started"

if [ $(grep CallScreen $MODDIR/config.prop | cut -d'=' -f2) -eq 1 ]; then
    # Call Screening
    bool_patch speak_easy $DIALER_PREF
    bool_patch speakeasy $DIALER_PREF
    bool_patch call_screen $DIALER_PREF
    bool_patch revelio $DIALER_PREF
    bool_patch record $DIALER_PREF
    bool_patch atlas $DIALER_PREF
    bool_patch transript $DIALER_PREF
    cp -Tf $MODDIR/com.google.android.dialer /data/data/com.google.android.dialer/files/phenotype/com.google.android.dialer
fi

# GBoard
bool_patch nga $GBOARD_PREF
bool_patch redesign $GBOARD_PREF
bool_patch lens $GBOARD_PREF
bool_patch generation $GBOARD_PREF
bool_patch multiword $GBOARD_PREF
bool_patch voice_promo $GBOARD_PREF
bool_patch silk $GBOARD_PREF
bool_patch enable_email_provider_completion $GBOARD_PREF
bool_patch enable_multiword_predictions $GBOARD_PREF
bool_patch_false disable_multiword_autocompletion $GBOARD_PREF
bool_patch enable_inline_suggestions_on_decoder_side $GBOARD_PREF
bool_patch enable_core_typing_experience_indicator_on_composing_text $GBOARD_PREF
bool_patch enable_inline_suggestions_on_client_side $GBOARD_PREF
bool_patch enable_core_typing_experience_indicator_on_candidates $GBOARD_PREF
long_patch inline_suggestion_experiment_version 1 $GBOARD_PREF
long_patch user_history_learning_strategies 1 $GBOARD_PREF
long_patch crank_max_char_num_limit 100 $GBOARD_PREF
long_patch crank_min_char_num_limit 5 $GBOARD_PREF
long_patch keyboard_redesign 1 $GBOARD_PREF
bool_patch fast_access_bar $GBOARD_PREF
bool_patch tiresias $GBOARD_PREF
bool_patch agsa $GBOARD_PREF
bool_patch enable_voice $GBOARD_PREF
bool_patch personalization $GBOARD_PREF
bool_patch lm $GBOARD_PREF
bool_patch feature_cards $GBOARD_PREF
bool_patch dynamic_art $GBOARD_PREF
bool_patch multilingual $GBOARD_PREF
bool_patch show_suggestions_for_selected_text_while_dictating $GBOARD_PREF
bool_patch enable_preemptive_decode $GBOARD_PREF
bool_patch enable_show_inline_suggestions_in_popup_view $GBOARD_PREF
bool_patch enable_nebulae_materializer_v2 $GBOARD_PREF
string_patch crank_inline_suggestion_language_tags "ar,de,en,es,fr,hi-IN,hi-Latn,id,it,ja,ko,nl,pl,pt,ru,th,tr,zh-CN,zh-HK,zh-TW" $GBOARD_PREF
bool_patch_false force_key_shadows $GBOARD_PREF

#google
if [ $(grep Assistant $MODDIR/config.prop | cut -d'=' -f2) -eq 1 ]; then
    chmod 0551 /data/data/com.google.android.googlequicksearchbox/shared_prefs
    name=$(grep current_account_name /data/data/com.android.vending/shared_prefs/account_shared_prefs.xml | cut -d">" -f2 | cut -d"<" -f1)
    if [ ! -z $name ]; then
        string_patch GSAPrefs.google_account $name $MODDIR/GEL.GSAPrefs.xml
    fi #1
    model=$(getprop ro.product.model)
    if [ "$model" != "Pixel 5" ]; then
        string_patch 7325 "Pixel 4,Pixel 4 XL,Pixel 4a,Pixel 4a (5G),Pixel 5,$model" $MODDIR/GEL.GSAPrefs.xml
    fi
    cp -Tf $MODDIR/GEL.GSAPrefs.xml $GOOGLE_PREF
fi

# GoogleFit
bool_patch DeviceStateFeature $FIT
bool_patch TestingFeature $FIT
bool_patch Sync__sync_after_promo_shown $FIT
bool_patch Sync__use_experiment_flag_from_promo $FIT
bool_patch Promotions $FIT
bool_patch googler $FIT
bool_patch dasher $FIT

# Photos
bool_patch false $PHOTOS

# Wellbeing
pm_enable com.google.android.apps.wellbeing/com.google.android.apps.wellbeing.walkingdetection.ui.WalkingDetectionActivity

while true; do
    boot=$(getprop sys.boot_completed)
    if [ "$boot" == 1 ]; then
        sleep 10
        break
    fi
done

if [ $(grep CallScreen $MODDIR/config.prop | cut -d'=' -f2) -eq 1 ]; then
    mkdir -p /data/data/com.google.android.dialer/files/phenotype
    cp -Tf $MODDIR/com.google.android.dialer /data/data/com.google.android.dialer/files/phenotype/com.google.android.dialer
    chmod 500 /data/data/com.google.android.dialer/files/phenotype
    am force-stop com.google.android.dialer
fi

flip_perm="android.permission.READ_DEVICE_CONFIG
android.permission.SUSPEND_APPS
android.permission.QUERY_ALL_PACKAGES
android.permission.RECEIVE_BOOT_COMPLETED
android.permission.FOREGROUND_SERVICE
android.permission.SYSTEM_ALERT_WINDOW
android.permission.WRITE_SECURE_SETTINGS
android.permission.WRITE_SETTINGS
android.permission.REAL_GET_TASKS
android.permission.INTERACT_ACROSS_USERS_FULL
android.permission.KILL_BACKGROUND_PROCESSES
android.permission.MODIFY_QUIET_MODE
android.permission.INTERACT_ACROSS_PROFILES
android.permission.CONTROL_DISPLAY_COLOR_TRANSFORMS
android.permission.TETHER_PRIVILEGED
android.permission.SUBSTITUTE_NOTIFICATION_APP_NAME"

for i in $flip_perm; do
    pm grant com.google.android.flipendo $i
done

log "Service Finished"
echo "$temp" >> /sdcard/GAppsPlus/logs.txt

#disable logs
sleep 5
am kill logd
killall -9 logd
am kill logd.rc
killall -9 logd.rc
sleep 10
echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
rm -rf /data/vendor/wlan_logs
rm -rf /data/adb/modules/nga

#zipalign
zipalign() {
for DIR in /system/app/* /system/priv-app/* /system/product/app/* /system/product/overlay/* /data/app/* /system/product/priv-app/* /vendor/app/* /vendor/overlay/* /system_ext/app/* /system_ext/priv-app/* /product/app/* /product/priv-app/* /system/system_ext/app/* /system/system_ext/priv-app/*; do
   cd $DIR
   for APK in *.apk; do
      zipalign -c 4 "$APK"
      zipalign -f 4 "$APK" "/cache/$APK"
        cp -af -p "/cache/$APK" "$APK"
        rm -f "/cache/$APK"
    done
done
}
zipalign

#FS Trim
for PARTITION in "/cache" "/data" 
do
    echo "Trimming $PARTITION"  | tee -a "$LOGFILE"
    "$BUSYBOX" fstrim -v "$PARTITION" 2>&1 | tee -a "$LOGFILE"
done
exit 0

#deepsleep
sleep 2
echo lock_me > /sys/power/wake_lock
sleep 1
echo lock_me > /sys/power/wake_unlock
sleep 1
echo lock_me > /sys/power/wake_lock
sleep 1
echo lock_me > /sys/power/wake_unlock
sleep 1
echo lock_me > /sys/power/wake_lock
sleep 1
echo lock_me > /sys/power/wake_unlock
sleep 1
echo lock_me > /sys/power/wake_lock
sleep 1
echo lock_me > /sys/power/wake_unlock
echo "OK" >> /storage/emulated/0/deepsleepok
