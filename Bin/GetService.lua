return function() 
    local env = getfenv() 
    for _, service in ipairs(
        { "CoreGui", "Players", "UserInputService", "TweenService", "HttpService", "MarketplaceService", "RunService", "TeleportService", "StarterGui", "GuiService", "Lighting", "ContextActionService", "ReplicatedStorage", "GroupService", "PathfindingService", "SoundService", "Teams", "StarterPlayer", "InsertService", "Chat", "ProximityPromptService", "ContentProvider", "Stats", "MaterialService", "AvatarEditorService", "TextService", "TextChatService", "CaptureService", "VoiceChatService" 
    }) do 
        env[service] = game:GetService(service) 
    end 
end
--Test