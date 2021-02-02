vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sogou/workflow
    REF c712b1071840b88a8b9703869466b03984e4e6e6
    SHA512 20c608cc9d0a21fdb66eda73838a9389dbdd9e73066505bd6718769e581ea004063f2cd3a7ce360cbd373f9e512a6a49eb9324c80c860dd19da4f72554c354bf
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