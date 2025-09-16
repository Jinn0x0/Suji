local owner = "Jinn0x0"
local branch = "Bin"

local function webImport(file)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/%s/Suji/refs/heads/main/%s/%s.lua"):format(owner, branch, file))()
end

webImport("GetService")
