local owner = "Jinn0x0"
local branch = "Bin"

local function webImport(file)
    return loadstring(
        game:HttpService:GetAsync(
            ("https://raw.githubusercontent.com/%s/Suji/main/%s/%s.lua"):format(owner, branch, file)
        )
    )()
end

webImport("GetService")