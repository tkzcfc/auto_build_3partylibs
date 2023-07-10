DIST_ROOT=$1
LIB_NAME=openssl
DIST_DIR="${DIST_ROOT}/${LIB_NAME}"

dist_lib ${LIB_NAME} ${DIST_DIR} $DISTF_ALL configuration.h config.h.in openssl/

# create flat lib for ios
if [ -f "install_ios_arm/${LIB_NAME}/lib/libssl.a" ] ; then
  lipo -create install_ios_arm/${LIB_NAME}/lib/libssl.a install_ios_arm64/${LIB_NAME}/lib/libssl.a install_ios_x64/${LIB_NAME}/lib/libssl.a -output ${DIST_DIR}/prebuilt/ios/libssl.a
  lipo -create install_ios_arm/${LIB_NAME}/lib/libcrypto.a install_ios_arm64/${LIB_NAME}/lib/libcrypto.a install_ios_x64/${LIB_NAME}/lib/libcrypto.a -output ${DIST_DIR}/prebuilt/ios/libcrypto.a
else
  lipo -create install_ios_arm64/${LIB_NAME}/lib/libssl.a install_ios_x64/${LIB_NAME}/lib/libssl.a -output ${DIST_DIR}/prebuilt/ios/libssl.a
  lipo -create install_ios_arm64/${LIB_NAME}/lib/libcrypto.a install_ios_x64/${LIB_NAME}/lib/libcrypto.a -output ${DIST_DIR}/prebuilt/ios/libcrypto.a
fi

# create flat lib for tvos
if [ -f "install_tvos_arm/${LIB_NAME}/lib/libssl.a" ] ; then
  lipo -create install_tvos_arm/${LIB_NAME}/lib/libssl.a install_tvos_arm64/${LIB_NAME}/lib/libssl.a install_tvos_x64/${LIB_NAME}/lib/libssl.a -output ${DIST_DIR}/prebuilt/tvos/libssl.a
  lipo -create install_tvos_arm/${LIB_NAME}/lib/libcrypto.a install_tvos_arm64/${LIB_NAME}/lib/libcrypto.a install_tvos_x64/${LIB_NAME}/lib/libcrypto.a -output ${DIST_DIR}/prebuilt/tvos/libcrypto.a
else
  lipo -create install_tvos_arm64/${LIB_NAME}/lib/libssl.a install_tvos_x64/${LIB_NAME}/lib/libssl.a -output ${DIST_DIR}/prebuilt/tvos/libssl.a
  lipo -create install_tvos_arm64/${LIB_NAME}/lib/libcrypto.a install_tvos_x64/${LIB_NAME}/lib/libcrypto.a -output ${DIST_DIR}/prebuilt/tvos/libcrypto.a
fi

# check the flat lib
lipo -info ${DIST_DIR}/prebuilt/ios/libssl.a
lipo -info ${DIST_DIR}/prebuilt/ios/libcrypto.a

# check the flat lib
lipo -info ${DIST_DIR}/prebuilt/tvos/libssl.a
lipo -info ${DIST_DIR}/prebuilt/tvos/libcrypto.a

# create fat lib for mac
lipo -create install_osx_arm64/${LIB_NAME}/lib/libssl.a install_osx_x64/${LIB_NAME}/lib/libssl.a -output ${DIST_DIR}/prebuilt/mac/libssl.a
lipo -create  install_osx_arm64/${LIB_NAME}/lib/libcrypto.a install_osx_x64/${LIB_NAME}/lib/libcrypto.a -output ${DIST_DIR}/prebuilt/mac/libcrypto.a

# check the fat lib
lipo -info ${DIST_DIR}/prebuilt/mac/libssl.a
lipo -info ${DIST_DIR}/prebuilt/mac/libcrypto.a
