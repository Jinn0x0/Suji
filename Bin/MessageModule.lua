local MessageModule = {}

local function AssetLink(assetID)
    return "rbxassetid://" .. assetID
end

function MessageModule.Notification(title, text, duration, iconID)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
        Icon = AssetLink(iconID),
    })
end

function MessageModule.Prompt(title, text, duration, callback, iconID)
    local bindable = Instance.new("BindableFunction")
    bindable.OnInvoke = callback

    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
        Callback = bindable,
        Button1 = "Yes",
        Button2 = "No",
        Icon = AssetLink(iconID),
    })
end

return MessageModule