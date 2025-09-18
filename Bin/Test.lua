local M = {}

function M.run()
    print("Hello from Test.lua!")
end

function M.TestGetNameFromId(userId)
    local success, username = pcall(function()
        return Players:GetNameFromUserIdAsync(userId)
    end)

    if success then
        print("Username is: " .. username)
    else
        warn("Failed to get username: " .. tostring(username))
    end
end


return M