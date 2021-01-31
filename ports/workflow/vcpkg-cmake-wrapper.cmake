_find_package(${ARGS})
if(TARGET Workflow::workflow)
    set_property(TARGET Workflow::workflow APPEND PROPERTY INTERFACE_LINK_LIBRARIES "ws2_32.lib;Mswsock.lib")
endif()