local M = {}

local SERVICES = {
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
    "VoiceChatService",
}

-- Inject into globals (optional)
function M.load(into)
    local target = into or _G
    for _, name in ipairs(SERVICES) do
        target[name] = game:GetService(name)
    end
    return target
end

-- Return a services table (safer)
function M.get()
    local t = {}
    for _, name in ipairs(SERVICES) do
        t[name] = game:GetService(name)
    end
    return t
end

return M
