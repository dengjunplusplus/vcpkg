if (NOT VCPKG_TARGET_IS_MINGW)
    vcpkg_fail_port_install(MESSAGE "${PORT} is only for workflow on Unix-like systems" ON_TARGET "Windows")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sogou/workflow
    REF v0.9.3
    SHA512 a687cbcef0ee807953447a95f1828dc06fb072bba9cd6cf53f71ec84fac503569759d1c96fafd8ea6de064c312915bd3fa64ed9250176904b455009f3a3b11f4
    HEAD_REF master
    PATCHES
        fix-cmake-targets.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share)