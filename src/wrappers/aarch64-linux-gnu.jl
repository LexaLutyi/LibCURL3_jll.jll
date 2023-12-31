# Autogenerated wrapper script for LibCURL3_jll for aarch64-linux-gnu
export libcurl

using LibSSH2_jll
using Zlib_jll
using MbedTLS_jll
JLLWrappers.@generate_wrapper_header("LibCURL3")
JLLWrappers.@declare_library_product(libcurl, "libcurl.so.4")
function __init__()
    JLLWrappers.@generate_init_header(LibSSH2_jll, Zlib_jll, MbedTLS_jll)
    JLLWrappers.@init_library_product(
        libcurl,
        "lib/libcurl.so",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@generate_init_footer()
end  # __init__()
