vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sogou/workflow
    REF b9c3853eef22be01a60c83c734450bbcf6b7ac7f
    SHA512 7eb260ac0b39acc0e1d282cc481ebeff39ad83bf22a11a92c99a5c6e34e89f3e2cea8cfc6c7ba192a5143cf0587b2a8e1ec26d45cfb08f20280bb7315aa7b506
    HEAD_REF windows
    PATCHES
        fix-cmake-targets.patch
)

# configure_file(${CURRENT_PORT_DIR}/workflow-config.cmake.in ${SOURCE_PATH}/workflow-config.cmake.in COPYONLY)

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

vcpkg_copy_pdbs()