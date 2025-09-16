local HttpService = game:GetService("HttpService")
loadstring(HttpService:GetAsync("https://raw.githubusercontent.com/Jinn0x0/Suji/main/Bin/GetService.lua"))() -- Load all services

local M = {}

function M.printPlayersName()
    for _, plr in pairs(Players:GetPlayers()) do
        print(plr.Name)
    end
end

return M
