if (NOT VCPKG_TARGET_IS_MINGW)
    vcpkg_fail_port_install(MESSAGE "${PORT} is only for workflow on Unix-like systems" ON_TARGET "Windows")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sogou/workflow
    REF a7314767c230d5b919350719f9abe8292cfef610
    SHA512 e83e53116770eea15e9f9660ac96b48f8d6a1f48de4d50d008d16e364d23c612f31426b2df620fa1d983d9f3c39f432e78880fc6bae4bf42f74b5be5aebd3ac7
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
