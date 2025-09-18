local M = {}

function M.run()
    print("Hello from Test.lua!")
end

function M.TestGetNameFromId(Id)
    local success, username = pcall(function()
        return Players:GetNameFromUserIdAsync(Id)
    end)

    if success then
        print("Username is: " .. username)
    else
        warn("Failed to get username: " .. tostring(username))
    end
end


return M