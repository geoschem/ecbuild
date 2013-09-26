
function(_get_test_data basename dirname)

    # TODO: make that 'at ecmwf'
    #if(1) 
    #unset(ENV{no_proxy})
    #unset(ENV{NO_PROXY})
    #set(ENV{http_proxy} "http://proxy.ecmwf.int:3333")
    #endif()

    # TODO: choose between wget and curl
    add_custom_command(
        OUTPUT ${basename}
        COMMAND curl --silent --show-error --fail --output ${basename} http://download.ecmwf.org/test-data/${dirname}/${basename})
endfunction()


# Will create target 'test_data_foo_grib' from 'foo.grib'

function (ecbuild_get_test_data basename dirname md5)

    STRING(REGEX REPLACE "[^A-Za-z0-9_]" "_"
        TARGET "test_data_${basename}")

    message(STATUS "Created download target ${TARGET}")

    _get_test_data(${basename} ${dirname})

    message(STATUS "MD5 is ${md5}")

    # if(md5) with fail, while if(MD5) works ....
    set(MD5 ${md5})

    if(MD5)
        add_custom_command(
            OUTPUT ${basename}.localmd5
            COMMAND md5sum ${basename} > ${basename}.localmd5)

        add_custom_command(
            OUTPUT ${basename}.ok
            COMMAND diff ${basename}.md5 ${basename}.localmd5 && touch ${basename}.ok
            )

        _get_test_data(${basename}.md5 ${dirname})
        set(depends ${basename} ${basename}.md5 ${basename}.localmd5 ${basename}.ok)
    else()
        set(depends ${basename})
    endif()


    ADD_CUSTOM_TARGET(${TARGET} DEPENDS ${depends})

endfunction(ecbuild_get_test_data)

