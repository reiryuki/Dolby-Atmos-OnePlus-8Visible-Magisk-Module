MODPATH=${0%/*}
API=`getprop ro.build.version.sdk`
AML=/data/adb/modules/aml

# debug
exec 2>$MODPATH/debug.log
set -x

# property
#resetprop ro.sys.oneplus.support 11.11.0
resetprop ro.vendor.dolby.dax.version DAX3_3.5.6.11_r1
#11resetprop ro.vendor.product.device.db OP_DEVICE
#11resetprop ro.vendor.product.manufacturer.db OP_PHONE
#10resetprop vendor.product.device OP_PHONE
#10resetprop vendor.product.manufacturer OPD
resetprop vendor.audio.dolby.ds2.enabled false
resetprop vendor.audio.dolby.ds2.hardbypass false
#resetprop vendor.audio.gef.debug.flags false
#resetprop vendor.audio.gef.enable.traces false
#resetprop vendor.dolby.dap.param.tee false
#resetprop vendor.dolby.mi.metadata.log false

# function
stop_service() {
for NAMES in $NAME; do
  if getprop | grep "init.svc.$NAMES\]: \[running"; then
    stop $NAMES
  fi
done
}
run_service() {
for FILES in $FILE; do
  killall $FILES
  $FILES &
  PID=`pidof $FILES`
done
}

# stop
NAME="dms-hal-1-0 dms-hal-2-0 dms-v36-hal-2-0"
stop_service

# mount
DIR=/odm/bin/hw
FILE=$DIR/vendor.dolby_v3_6.hardware.dms360@2.0-service
if [ "`realpath $DIR`" == $DIR ] && [ -f $FILE ]; then
  mount -o bind $MODPATH/system/vendor/$FILE $FILE
fi

# run
FILE=`realpath /vendor`/bin/hw/vendor.dolby.hardware.dms@2.0-service
run_service

# restart
VIBRATOR=`realpath /*/bin/hw/vendor.qti.hardware.vibrator.service*`
[ "$VIBRATOR" ] && killall $VIBRATOR
POWER=`realpath /*/bin/hw/vendor.mediatek.hardware.mtkpower@*-service`
[ "$POWER" ] && killall $POWER
killall android.hardware.usb@1.0-service
killall android.hardware.usb@1.0-service.basic
killall android.hardware.sensors@1.0-service
killall android.hardware.sensors@2.0-service-mediatek
killall android.hardware.light-service.mt6768
killall android.hardware.lights-service.xiaomi_mithorium
CAMERA=`realpath /*/bin/hw/android.hardware.camera.provider@*-service_64`
[ "$CAMERA" ] && killall $CAMERA

# wait
sleep 20

# aml fix
DIR=$AML/system/vendor/odm/etc
if [ -d $DIR ] && [ ! -f $AML/disable ]; then
  chcon -R u:object_r:vendor_configs_file:s0 $DIR
fi

# mount
if [ -d $AML ] && [ ! -f $AML/disable ]\
&& find $AML/system/ -type f; then
  NAME="*audio*effects*.conf -o -name *audio*effects*.xml"
#p  NAME="*audio*effects*.conf -o -name *audio*effects*.xml -o -name *policy*.conf -o -name *policy*.xml"
  DIR=$AML/system/vendor
else
  NAME="*audio*effects*.conf -o -name *audio*effects*.xml -o -name *policy*.conf -o -name *policy*.xml"
  DIR=$MODPATH/system/vendor
fi
FILE=`find $DIR/etc -maxdepth 1 -type f -name $NAME`
if [ "`realpath /odm/etc`" == /odm/etc ] && [ "$FILE" ]; then
  for i in $FILE; do
    j="/odm$(echo $i | sed "s|$DIR||")"
    if [ -f $j ]; then
      umount $j
      mount -o bind $i $j
    fi
  done
fi
if [ -d /my_product/etc ] && [ "$FILE" ]; then
  for i in $FILE; do
    j="/my_product$(echo $i | sed "s|$DIR||")"
    if [ -f $j ]; then
      umount $j
      mount -o bind $i $j
    fi
  done
fi

# restart
PID=`pidof audioserver`
if [ "$PID" ]; then
  killall audioserver
fi

# wait
sleep 40

# grant
PKG=com.dolby.daxservice
pm grant $PKG android.permission.READ_EXTERNAL_STORAGE
pm grant $PKG android.permission.WRITE_EXTERNAL_STORAGE
if [ "$API" -ge 30 ]; then
  appops set $PKG AUTO_REVOKE_PERMISSIONS_IF_UNUSED ignore
fi
killall $PKG

# allow
PKG=com.dolby.daxappui
if pm list packages | grep $PKG ; then
  if [ "$API" -ge 30 ]; then
    appops set $PKG AUTO_REVOKE_PERMISSIONS_IF_UNUSED ignore
  fi
fi

# grant
PKG=com.oneplus.sound.tuner
if pm list packages | grep $PKG ; then
  pm grant $PKG android.permission.READ_EXTERNAL_STORAGE
  pm grant $PKG android.permission.WRITE_EXTERNAL_STORAGE
  pm grant $PKG android.permission.READ_PHONE_STATE
  pm grant $PKG android.permission.READ_CALL_LOG
  if [ "$API" -ge 30 ]; then
    appops set $PKG AUTO_REVOKE_PERMISSIONS_IF_UNUSED ignore
  fi
  OBM=`settings get system oem_black_mode`
  if [ "$OBM" == null ] || [ "$OBM" == 0 ]; then
    settings put system oem_black_mode 1
  fi
fi


