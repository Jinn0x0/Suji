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

local Services = {}

function Services.Get()
    local env = getfenv() 
    for _, serviceName in ipairs(serviceNames) do
        env[service] = game:GetService(service) 
    end
end

return Services
