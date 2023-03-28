local ffi = require "ffi"
ffi.cdef[[
    typedef unsigned char byte;
    size_t KosinskiDecompress(byte *in_file_buffer, byte **out_file_buffer, size_t *out_file_size);
    size_t KosinskiCompress(byte *file_buffer, size_t file_size, byte **output_buffer_pointer);

    size_t KosinskiCompressModuled(byte *file_buffer, size_t file_size, byte **p_output_buffer);
    size_t KosinskiDecompressModuled(byte *in_file_buffer, byte **out_file_buffer);
]]
local rawKosinski = ffi.load(jit and (jit.os == "Windows" and "kosinski" or "libkosinski") or "kosinski")

local kosinski = {}

function kosinski.decompress(data)
    assert(type(data)=="string", "Data is empty or not a string!")
    local uncompressedBuffer = ffi.new("byte*[?]", 8192)
    local bufferSize = ffi.new("size_t[1]")
    local ffiData = ffi.new("byte[?]",#data,  data)
    rawKosinski.KosinskiDecompress(ffiData, uncompressedBuffer, bufferSize)
    return ffi.string(uncompressedBuffer[0], bufferSize[0])
end

function kosinski.compress(data)
    assert(type(data)=="string", "Data is empty or not a string!")
    local compressedBuffer = ffi.new("byte*[?]", 8192)
    local ffiData = ffi.new("byte[?]", #data, data)
    local bufferSize = rawKosinski.KosinskiCompress(ffiData, #data, compressedBuffer)
    return ffi.string(compressedBuffer[0], bufferSize)
end

function kosinski.decompressModuled(data)
    assert(type(data)=="string", "Data is empty or not a string!")
    local uncompressedBuffer = ffi.new("byte*[?]", 8192)
    local ffiData = ffi.new("byte[?]",#data,  data)
    local bufferSize = rawKosinski.KosinskiDecompressModuled(ffiData, uncompressedBuffer)
    return ffi.string(uncompressedBuffer[0], bufferSize)
end

function kosinski.compressModuled(data)
    assert(type(data)=="string", "Data is empty or not a string!")
    local compressedBuffer = ffi.new("byte*[?]", 8192)
    local ffiData = ffi.new("byte[?]", #data, data)
    local bufferSize = rawKosinski.KosinskiCompressModuled(ffiData, #data, compressedBuffer)
    return ffi.string(compressedBuffer[0], bufferSize)
end

return kosinski