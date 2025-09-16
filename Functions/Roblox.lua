local M = {}

loadstring(game:HttpGet(("https://raw.githubusercontent.com/%s/Suji/main/%s/%s"):format("Jinn0x0", "Bin", "GetService.lua")))() -- Load all services

function M.printPlayersName()
    for _, plr in pairs(Players:GetPlayers()) do
        print(plr.Name)
    end
end

return M
