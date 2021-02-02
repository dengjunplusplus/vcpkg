_find_package(${ARGS})
if(TARGET workflow)
    if (APPLE)
        set_property(TARGET workflow APPEND PROPERTY INTERFACE_LINK_LIBRARIES pthread OpenSSL::SSL OpenSSL::Crypto)
    elseif (WIN32)
        set_property(TARGET workflow APPEND PROPERTY INTERFACE_LINK_LIBRARIES "ws2_32.lib;Mswsock.lib" OpenSSL::SSL OpenSSL::Crypto)
    else ()
        set_property(TARGET workflow APPEND PROPERTY INTERFACE_LINK_LIBRARIES rt)
    endif () 
endif()