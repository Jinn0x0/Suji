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
for _, serviceName in ipairs(serviceNames) do
    Services[serviceName] = game:GetService(serviceName)
end

return Services
