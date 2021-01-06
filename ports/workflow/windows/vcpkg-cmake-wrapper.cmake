_find_package(${ARGS})
if(WORKFLOW_FOUND)
    set_property(TARGET workflow APPEND PROPERTY INTERFACE_LINK_LIBRARIES "Crypt32.lib;ws2_32.lib;Mswsock.lib")
endif()
