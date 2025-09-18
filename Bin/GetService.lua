local Services = {}

function Services.Get()
    local env = getfenv() 
    local serviceNames = {
        "CoreGui",
        "Players",
        "UserInputService",
        "TweenService",
        "HttpService",
        "MarketplaceService",
        "RunService",
        "TeleportService",
        "StarterGui",
        "GuiService",
        "Lighting",
        "ContextActionService",
        "ReplicatedStorage",
        "GroupService",
        "PathfindingService",
        "SoundService",
        "Teams",
        "StarterPlayer",
        "InsertService",
        "Chat",
        "ProximityPromptService",
        "ContentProvider",
        "Stats",
        "MaterialService",
        "AvatarEditorService",
        "TextService",
        "TextChatService",
        "CaptureService",
        "VoiceChatService"
    }

    for _, serviceName in ipairs(serviceNames) do
        env[serviceName] = game:GetService(serviceName) 
    end
end

return Services
