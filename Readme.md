# LuaKosinski
An [Accurate Kosinski](https://github.com/Clownacy/accurate-kosinski) ([fork used](https://github.com/VanderCat/accurate-kosinski)) wrapper for Lua(JIT) (It probably works with other ffi)

This is a library for compressing and decompressing files in Sega's "Kosinski" format (an LZSS variant). It outputs data identical to Sega's own compressor. Moduled Kosinski is also supported.

Included are basic frontends for a compressor, a decompressor, and a comparison utility.

# Usage
```lua
local kosinski = require "kosinski"

local compressed = kosinski.compress("data")
local decompressed = kosinski.decompress(compressed)

local moduled = kosinski.compressModuled("data")
```

## Standalone tools
### Compression/Decompression Tool
```bash
luajit example/compdecomp_string.lua # for utility help
luajit example/compdecomp_string.lua -c "test data" > result.bin # compress data
echo "test data" | luajit example/compdecomp_string.lua -c > result.bin # compress data from pipe
```
### Decompress then Compress to Test the exact match
```bash
luajit example/main_compare.lua "/path/to/rep/accurate-kosinski/test/kosinski/Sonic 2/art/kosinski/CNZ.bin"
luajit example/main_compare.lua -m "/path/to/rep/accurate-kosinski/test/moduled kosinski/Sonic 3 & Knuckles/Levels/BPZ/KosinskiM Art/Title Card.bin"
```

# Installation
```bash
git clone --recursive https://github.com/VanderCat/LuaKosinski
```
## Building Accurate Kosinski
```bash
cd accurate-kosinski
mkdir build
cd build
cmake .. -DONLYLIBRARY=ON
cmake --build . --config Release
```
Move the DLL in `build/Release` folder to CPATH of Lua(JIT)