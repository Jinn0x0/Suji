local M = {}

function M.printPlayersName()
    for _, plr in pairs(Players:GetPlayers()) do
        print(plr.Name)
    end
end

return M