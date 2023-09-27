using LibCURL3_jll
using MozillaCACerts_jll

const CURLOPT_URL = 10002 % UInt32
const CURLcode = UInt32
const CURLE_OK = 0 % UInt32
const CURLOPT_USE_SSL = 119 % UInt32
const CURLOPT_SSL_VERIFYHOST = 81 % UInt32
const CURLOPT_SSL_VERIFYPEER = 64 % UInt32
const CURLOPT_CAINFO = 10065 % UInt32
const CURLUSESSL_ALL = 3 % UInt32
const CURLOPT_WRITEFUNCTION = 20011 % UInt32

# Setup the callback function to recv data
function curl_write_cb(curlbuf::Ptr{Cvoid}, s::Csize_t, n::Csize_t, p_ctxt::Ptr{Cvoid})
    sz = s * n
    # data = Array{UInt8}(undef, sz)
    # ccall(:memcpy, Ptr{Cvoid}, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), data, curlbuf, sz)
    return sz::Csize_t
end

curl = @ccall libcurl.curl_easy_init()::Ptr{Cvoid}

@ccall libcurl.curl_easy_setopt(curl::Ptr{Cvoid}, CURLOPT_URL::UInt64, "https://www.google.com"::Cstring)::CURLcode


@ccall libcurl.curl_easy_setopt(curl::Ptr{Cvoid}, CURLOPT_USE_SSL::UInt64, CURLUSESSL_ALL::UInt64)::CURLcode
@ccall libcurl.curl_easy_setopt(curl::Ptr{Cvoid}, CURLOPT_SSL_VERIFYHOST::UInt64, 2::UInt64)::CURLcode
@ccall libcurl.curl_easy_setopt(curl::Ptr{Cvoid}, CURLOPT_SSL_VERIFYPEER::UInt64, 1::UInt64)::CURLcode
@ccall libcurl.curl_easy_setopt(curl::Ptr{Cvoid}, CURLOPT_CAINFO::UInt64, MozillaCACerts_jll.cacert::Cstring)::CURLcode

c_curl_write_cb = @cfunction(
    curl_write_cb,
    Csize_t,
    (Ptr{Cvoid}, Csize_t, Csize_t, Ptr{Cvoid})
)
@ccall libcurl.curl_easy_setopt(curl::Ptr{Cvoid}, CURLOPT_WRITEFUNCTION::UInt64, c_curl_write_cb::Ptr{Cvoid})::CURLcode

req = @ccall libcurl.curl_easy_perform(curl::Ptr{Cvoid})::CURLcode

@show req
err = @ccall libcurl.curl_easy_strerror(req::CURLcode)::Ptr{UInt8}
err |> unsafe_string |> println
