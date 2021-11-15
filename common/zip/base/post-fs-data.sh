#!/system/bin/sh
MODDIR=${0%/*}
if
rm -rf /cache/magisk.log
touch   /cache/magisk.log
chmod 000  /cache/magisk.log
busybox chattr +i  /cache/magisk.log
chmod 777 /data/user_de/0/com.miui.home/cache/debug_log
rm -rf /data/user_de/0/com.miui.home/cache/debug_log
touch /data/user_de/0/com.miui.home/cache/debug_log
chmod 000 /data/user_de/0/com.miui.home/cache/debug_log
chmod 777 /data/vendor/wlan_logs
rm -rf /data/vendor/wlan_logs
touch /data/vendor/wlan_logs
chmod 000 /data/vendor/wlan_logs
chmod 777 /data/media/0/JuphoonService
rm -rf /data/media/0/JuphoonService
touch /data/media/0/JuphoonService
chmod 000 /data/media/0/JuphoonService
rm -rf /data/user_de/0/com.miui.home/cache/debug_log
touch   /data/user_de/0/com.miui.home/cache/debug_log
chmod 000  /data/user_de/0/com.miui.home/cache/debug_log 
busybox chattr +i  /data/user_de/0/com.miui.home/cache/debug_log
then
echo "√"
fi

#disable logs
echo 0 > /sys/block/dm-0/queue/iostats
echo 0 > /sys/block/mmcblk0/queue/iostats
echo 0 > /sys/block/mmcblk0rpmb/queue/iostats
echo 0 > /sys/block/mmcblk1/queue/iostats
echo 0 > /sys/block/loop0/queue/iostats
echo 0 > /sys/block/loop1/queue/iostats
echo 0 > /sys/block/loop2/queue/iostats
echo 0 > /sys/block/loop3/queue/iostats
echo 0 > /sys/block/loop4/queue/iostats
echo 0 > /sys/block/loop5/queue/iostats
echo 0 > /sys/block/loop6/queue/iostats
echo 0 > /sys/block/loop7/queue/iostats
echo 0 > /sys/block/sda/queue/iostats
