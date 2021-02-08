vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sogou/workflow
    REF eb0ef062cb4be64f3a152c740ed3d32e468c13fe
    SHA512 0dafe5637c78bfa8d415ef54d9ac91f6a6f525a5876ec54c321a533d05b010c1f94829107808348bbf2ffe58914547930abf2fc4b0b07c2990a55c44bb9fd2e3
    HEAD_REF windows
    PATCHES
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