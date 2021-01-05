if (NOT VCPKG_TARGET_IS_MINGW)
    vcpkg_fail_port_install(MESSAGE "${PORT} is only for workflow on Unix-like systems" ON_TARGET "Windows")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sogou/workflow
    REF v0.9.2
    SHA512 08a130b6fdb93744dec7a46d4c1144a084d61bc73b5367cf41f0863e10b8c0f4d2a7ac12425c5c460852b06ca3262ce00d6094144635881da3ed691c746dc98f
    HEAD_REF master
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