_find_package(${ARGS})
if(TARGET srpc)
    set_property(TARGET srpc APPEND PROPERTY INTERFACE_LINK_LIBRARIES workflow protobuf::libprotobuf lz4 snappy ZLIB::ZLIB)
endif()