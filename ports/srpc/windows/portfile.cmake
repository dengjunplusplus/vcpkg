vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sogou/srpc
    REF bbf21b54a82f35d18b5fef19828a588684726df6
    SHA512 8b0c8b64c45123c00cf40249ccb67ee41409e5b2a7a04d7db9ee0f558ecea4bfd9e8537b2c8d98959b1115ca799dff17fa977b12e7fe23a1b8c60b935b9d8cac
    HEAD_REF master
    PATCHES
        fix-cmake-targets.patch
        use-lib-for-lz4-and-snappy.patch
        fix-compile-error-on-win.patch
        fix-bin-error.patch
)


vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/srpc)
if (VCPKG_TARGET_IS_WINDOWS)
	file(RENAME ${CURRENT_PACKAGES_DIR}/bin/srpc_generator.exe ${CURRENT_PACKAGES_DIR}/tools/srpc/srpc_generator.exe)
else()
	file(RENAME ${CURRENT_PACKAGES_DIR}/bin/srpc_generator ${CURRENT_PACKAGES_DIR}/tools/srpc/srpc_generator)
endif()

vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/srpc") 

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin")

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share)

vcpkg_copy_pdbs()