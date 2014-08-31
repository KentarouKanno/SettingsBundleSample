#!/bin/sh
APP_VERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $PRODUCT_SETTINGS_PATH)
/usr/libexec/PlistBuddy -c "Set :PreferenceSpecifiers:1:DefaultValue ${APP_VERSION}" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/Settings.bundle/Root.plist"

BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $PRODUCT_SETTINGS_PATH)
/usr/libexec/PlistBuddy -c "Set :PreferenceSpecifiers:2:DefaultValue ${BUILD_NUMBER}" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/Settings.bundle/Root.plist"
