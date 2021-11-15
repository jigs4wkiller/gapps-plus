#fix nightlight
env -i USER=shell "$(PATH=/system/xbin:/system/bin:/su/bin:/sbin:/magisk/.core/bin which su)" shell --context u:r:shell:s0 --shell /system/bin/sh --command settings put secure night_display_activated 0 

env -i USER=shell "$(PATH=/system/xbin:/system/bin:/su/bin:/sbin:/magisk/.core/bin which su)" shell --context u:r:shell:s0 --shell /system/bin/sh --command settings put secure night_display_auto_mode 0
