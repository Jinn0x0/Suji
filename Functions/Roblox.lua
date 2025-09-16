local M = {}

local Players = game:GetService("Players")

function M.printPlayersName()
    for _, plr in pairs(Players:GetPlayers()) do
        print(plr.Name)
    end
end

function M.printPlayersID()
    for _, plr in pairs(Players:GetPlayers()) do
        print(plr.UserId)
    end
end


return M