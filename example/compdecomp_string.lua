local kosinski = require "kosinski"
local result
if arg[1] == "-c" then
    result = kosinski.compress(arg[2] or io.read("*all"))
elseif arg[1] == "-u" then
    result = kosinski.decompress(arg[2] or io.read("*all"))
elseif arg[1] == "-cm" then
    result = kosinski.compressModuled(arg[2] or io.read("*all"))
elseif arg[1] == "-um" then
    result = kosinski.decompressModuled(arg[2] or io.read("*all"))
else
    result = [[
Kosinski Compress/Decompress
Usage:  luajit compdecomp_string.lua -[c/cm/u/um] DATA
        echo DATA | luajit compdecomp_string.lua -[c/cm/u/um]

    -c          compress
    -u          decompress
    -cm         compress (moduled)
    -um         decompress (moduled)
    ]]
end
io.write(result)