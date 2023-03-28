local kosinski = require "kosinski"

local function loadFileToBuffer(fileName)
    local file, err = io.open(fileName, "rb")
    if not file then
        print(err)
        return
    end
    local contents = file:read("a")
    file:close()
    return contents
end

local flag = false
for i=1, #arg do
    local filename = arg[i]
    if filename == "-m" then
        flag = true
        goto continue
    end
    local file = loadFileToBuffer(filename)
    if not file then
        print("Could not open "..filename)
        os.exit(-1)
    end
    local uncompressed = kosinski["decompress"..(flag and "Moduled" or "")](file)
    local compressed = kosinski["compress"..(flag and "Moduled" or "")](uncompressed)
    if (#file ~= #compressed) then
        print("File sizes don't match!")
        os.exit(-1)
    end
    if (file ~= compressed) then
        print("The files don't match!")
        os.exit(-1)
    end
    print("Yay the files match!")
    ::continue::
end