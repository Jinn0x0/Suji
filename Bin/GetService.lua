return function() 
    local env = getfenv() 
    local Services = { "CoreGui", "Players", "UserInputService", "TweenService", "HttpService", "MarketplaceService", "RunService", "TeleportService", "StarterGui", "GuiService", "Lighting", "ContextActionService", "ReplicatedStorage", "GroupService", "PathfindingService", "SoundService", "Teams", "StarterPlayer", "InsertService", "Chat", "ProximityPromptService", "ContentProvider", "Stats", "MaterialService", "AvatarEditorService", "TextService", "TextChatService", "CaptureService", "VoiceChatService" }
    
    for _, Service in ipairs(Services) do 
        env[Service] = game:GetService(Service) 
    end
end
