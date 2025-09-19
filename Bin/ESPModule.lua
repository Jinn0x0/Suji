local ESPModule = {}

-- ESP types
ESPModule.Enums = {
    GUI = "GUI",
    DRAWING = "DRAWING",
}

ESPModule.ESPStyle = {
    Color = Color3.fromRGB(255, 0, 0);
    Thickness = 3;
    Filled = false;
    InterpolateColor = true;
    InterpolateTime = 5;
    Transparency = 0.5;
}

-- ESP values
ESPModule.Values = {
    ESPTargets = {},
}

-- Object Bounds
local function GetBounds(object: Instance): (Vector2, Vector2)?
    -- Check if the object is real and exists
    if not object or not object.Parent then return end

    local camera = workspace.CurrentCamera

    -- Check if the camera exists
    if not camera then return end

    -- Depending on object get needed values
    local cframe, size
    if object:IsA("Model") then
        cframe, size = object:GetBoundingBox()
    elseif object:IsA("BasePart") then
        cframe = object.CFrame
        size = object.Size
    else return end

    local halfSize = size / 2
    local screenPoints = {}

    -- two diagonal points for the bounding box
    for _, offset in ipairs({
        Vector3.new(-halfSize.X, -halfSize.Y, -halfSize.Z),
        Vector3.new(halfSize.X, halfSize.Y, halfSize.Z),
    }) do
        local worldPos = cframe.Position + (cframe:VectorToWorldSpace(offset))
        local screenPos, onScreen = camera:WorldToViewportPoint(worldPos)
        if onScreen then
            table.insert(screenPoints, screenPos)
        else return end
    end

    local minX, minY = math.min(screenPoints[1].X, screenPoints[2].X), math.min(screenPoints[1].Y, screenPoints[2].Y)
    local maxX, maxY = math.max(screenPoints[1].X, screenPoints[2].X), math.max(screenPoints[1].Y, screenPoints[2].Y)

    return Vector2.new(minX, minY), Vector2.new(maxX, maxY)
end

-- Create ESP
function ESPModule.CreateESP(target: Instance, ESPType: string)
    -- Exit if already exists
    if ESPModule.Values.ESPTargets[target] then return end

    local CurrentStyle = ESPModule.ESPStyle

    local visual

    if ESPType == ESPModule.Enums.GUI then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "ESP_GUI"
        screenGui.ResetOnSpawn = true
        screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

        local frame = Instance.new("Frame")
        frame.Name = "ESP_Frame"
        frame.Size = UDim2.fromOffset(100, 100)
        frame.BackgroundColor3 = CurrentStyle.Color
        frame.BorderColor3 = CurrentStyle.Color
        frame.BorderSizePixel = CurrentStyle.Thickness
        frame.BackgroundTransparency = CurrentStyle.Transparency
        frame.Parent = screenGui

        visual = frame

    elseif ESPType == ESPModule.Enums.DRAWING then
        local box = Drawing.new("Square")
        box.Color = CurrentStyle.Color
        box.Thickness = CurrentStyle.Thickness
        box.Filled = CurrentStyle.Filled
        box.Visible = false

        visual = box
    end

    ESPModule.Values.ESPTargets[target] = {
        Type = ESPType,
        Visual = visual,
    }
end

-- Removes ESP
function ESPModule.RemoveESP(target: Instance)
    -- If doesn't exist return
    local data = ESPModule.Values.ESPTargets[target]
    if not data then return end

    -- Check and do for each type
    if data.Type == ESPModule.Enums.GUI then
        if data.Visual and data.Visual.Parent then
            data.Visual.Parent:Destroy()
        end
    elseif data.Type == ESPModule.Enums.DRAWING then
        if data.Visual.Remove then
            data.Visual:Remove()
        end
    end

    -- Remove from table
    ESPModule.Values.ESPTargets[target] = nil
end


-- Updates ESP
function ESPModule.UpdateESP()
    for target, data in pairs(ESPModule.Values.ESPTargets) do
        -- No Target then remove it
        if not target or not target.Parent then
            ESPModule.RemoveESP(target)
            continue
        end

        local topLeft, bottomRight = GetBounds(target)

        -- Not on screen then hide
        if not topLeft or not bottomRight then
            if data.Visual then
                data.Visual.Visible = false
            end
            continue
        end

        -- Update if on screen
        local size = bottomRight - topLeft
        if data.Visual then
            data.Visual.Visible = true
            if data.Type == ESPModule.Enums.GUI then
                data.Visual.Position = UDim2.fromOffset(topLeft.X, topLeft.Y)
                data.Visual.Size = UDim2.fromOffset(size.X, size.Y)
            elseif data.Type == ESPModule.Enums.DRAWING then
                data.Visual.Position = topLeft
                data.Visual.Size = size
            end
        end

        if ESPModule.ESPStyle.InterpolateColor then
            local cycleTime = ESPModule.ESPStyle.InterpolateTime
            local hue = (tick() % cycleTime) / cycleTime
            local color = Color3.fromHSV(hue, 1, 1)
            if data.Type == ESPModule.Enums.GUI then
                data.Visual.BackgroundColor3 = color
                data.Visual.BorderColor3 = color
            elseif data.Type == ESPModule.Enums.DRAWING then
                data.Visual.Color = color
            end
        end
    end
end

return ESPModule

--
--[[
-- IMPORT ALL SERVICES BEFORE
local LocalPlayer = Players.LocalPlayer

-- Load ESP module
local ESPModule = -- GET ESP

-- Define a custom style for character ESP
local CharacterESPStyle = {
    Color = Color3.fromRGB(0, 255, 0),
    Thickness = 2,
    Filled = false,
    InterpolateColor = true,
    InterpolateTime = 4,
    Transparency = 0.3,
}

-- Make ESP for character
local function setupCharacterESP(character)
    if not character then return end
    ESPModule.CreateESP(character, ESPModule.Enums.DRAWING, CharacterESPStyle)
end

-- Logic for each player
local function setupPlayer(player)
    -- When the character spawns
    player.CharacterAdded:Connect(setupCharacterESP)
    if player.Character then
        setupCharacterESP(player.Character)
    end

    -- When the character is being destroyed
    player.CharacterRemoving:Connect(function(character)
        ESPModule.RemoveESP(character)
    end)
end

-- Add to existing players
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        setupPlayer(player)
    end
end

-- Add to new players
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        setupPlayer(player)
    end
end)

-- Render ESP movement
RunService.RenderStepped:Connect(ESPModule.UpdateESP)
]]

-- ====================================================================================

-- Copilot Version :V (It look nice idk how it work thou, I know but I dont know how to make that)
--[[

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ESPModule = {}

ESPModule.Enums = {
    GUI = "GUI",
    DRAWING = "DRAWING",
}

-- Default style
ESPModule.DefaultStyle = {
    Color = Color3.fromRGB(255, 0, 0),
    Thickness = 2,
    Filled = false,
    InterpolateColor = false,
    InterpolateTime = 5,
    Transparency = 0.5,
}

ESPModule.Targets = {} -- [Instance] = ESPObject

-- ESPObject class
local ESPObject = {}
ESPObject.__index = ESPObject

function ESPObject.new(target, type, style)
    local self = setmetatable({}, ESPObject)
    self.Target = target
    self.Type = type
    self.Style = style or ESPModule.DefaultStyle
    self.Visual = self:CreateVisual()
    return self
end

function ESPObject:CreateVisual()
    if self.Type == ESPModule.Enums.DRAWING then
        local box = Drawing.new("Square")
        box.Color = self.Style.Color
        box.Thickness = self.Style.Thickness
        box.Filled = self.Style.Filled
        box.Visible = false
        return box
    end
end

function ESPObject:Update()
    local topLeft, bottomRight = ESPModule.GetBounds(self.Target)
    if not topLeft or not bottomRight then
        self.Visual.Visible = false
        return
    end

    local size = bottomRight - topLeft
    self.Visual.Position = topLeft
    self.Visual.Size = size
    self.Visual.Visible = true

    if self.Style.InterpolateColor then
        local hue = (tick() % self.Style.InterpolateTime) / self.Style.InterpolateTime
        self.Visual.Color = Color3.fromHSV(hue, 1, 1)
    end
end

function ESPObject:Destroy()
    if self.Visual and self.Visual.Remove then
        self.Visual:Remove()
    end
end

-- Bounding box utility
function ESPModule.GetBounds(object)
    local camera = workspace.CurrentCamera
    if not camera or not object or not object.Parent then return end

    local cf, size
    if object:IsA("Model") then
        cf, size = object:GetBoundingBox()
    elseif object:IsA("BasePart") then
        cf = object.CFrame
        size = object.Size
    else
        return
    end

    local half = size / 2
    local corners = {
        cf.Position + cf:VectorToWorldSpace(Vector3.new(-half.X, -half.Y, -half.Z)),
        cf.Position + cf:VectorToWorldSpace(Vector3.new(half.X, half.Y, half.Z)),
    }

    local screenPoints = {}
    for _, pos in ipairs(corners) do
        local screen, onScreen = camera:WorldToViewportPoint(pos)
        if not onScreen then return end
        table.insert(screenPoints, screen)
    end

    local minX = math.min(screenPoints[1].X, screenPoints[2].X)
    local minY = math.min(screenPoints[1].Y, screenPoints[2].Y)
    local maxX = math.max(screenPoints[1].X, screenPoints[2].X)
    local maxY = math.max(screenPoints[1].Y, screenPoints[2].Y)

    return Vector2.new(minX, minY), Vector2.new(maxX, maxY)
end

-- Public API
function ESPModule.TrackTarget(target, type, style)
    if ESPModule.Targets[target] then return end
    ESPModule.Targets[target] = ESPObject.new(target, type, style)
end

function ESPModule.UntrackTarget(target)
    local obj = ESPModule.Targets[target]
    if obj then
        obj:Destroy()
        ESPModule.Targets[target] = nil
    end
end

function ESPModule.TrackPlayer(player, style)
    local function onCharacter(char)
        ESPModule.TrackTarget(char, ESPModule.Enums.DRAWING, style)
    end

    player.CharacterAdded:Connect(onCharacter)
    if player.Character then onCharacter(player.Character) end

    player.CharacterRemoving:Connect(function(char)
        ESPModule.UntrackTarget(char)
    end)
end

function ESPModule.UpdateAll()
    for _, obj in pairs(ESPModule.Targets) do
        obj:Update()
    end
end

RunService.RenderStepped:Connect(ESPModule.UpdateAll)

return ESPModule


]]