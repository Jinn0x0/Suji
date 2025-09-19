-- Make sure you have import Bin.GetService required at the top of your script

local TestModule = {}

function TestModule.run()
    print("Suji Script Running")
end

function TestModule.TestGetNameFromId(Id)
    local success, username = pcall(function()
        return Players:GetNameFromUserIdAsync(Id)
    end)

    if success then
        print("Username is: " .. username)
    else
        warn("Failed to get username: " .. tostring(username))
    end
end


return TestModule