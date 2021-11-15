env -i USER=shell "$(PATH=/system/xbin:/system/bin:/su/bin:/sbin:/magisk/.core/bin which su)" shell --context u:r:shell:s0 --shell /system/bin/sh --command cmd package install-existing "com.miui.home"
# Don't modify anything after this
if [ -f $INFO ]; then
  while read LINE; do
    if [ "$(echo -n $LINE | tail -c 1)" == "~" ]; then
      continue
    elif [ -f "$LINE~" ]; then
      mv -f $LINE~ $LINE
    else
      rm -f $LINE
      while true; do
        LINE=$(dirname $LINE)
        [ "$(ls -A $LINE 2>/dev/null)" ] && break 1 || rm -rf $LINE
      done
    fi
  done < $INFO
  rm -f $INFO
fi
