MODPATH=${0%/*}
APP="`ls $MODPATH/system/priv-app` `ls $MODPATH/system/app`"
for APPS in $APP; do
  rm -f `find /data/system/package_cache -type f -name *$APPS*`
  rm -f `find /data/dalvik-cache /data/resource-cache -type f -name *$APPS*.apk`
done
PKG="com.oneplus.sound.tuner
     com.oneplus.config
     com.dolby.daxappui
     com.dolby.daxservice"
for PKGS in $PKG; do
  rm -rf /data/user/*/$PKGS/cache/*
done

