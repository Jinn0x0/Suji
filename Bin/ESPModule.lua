-- Object Bounds
local function GetBounds(character)
	if not character then return end

	local Head = character:FindFirstChild("Head")
	local HRP = character:FindFirstChild("HumanoidRootPart")

	if not Head or not HRP then return end

	local camera = workspace.CurrentCamera
	if not camera then return end

    -- World Positions
	local headPosition = Head.Position + Vector3.new(0, Head.Size.Y / 2, 0)
	local feetPosition = HRP.Position - Vector3.new(0, HRP.Size.Y, 0)

    -- Viewport from positions
	local headScreenPosition, headVisible = camera:WorldToViewportPoint(headPosition)
	local feetScreenPosition, feetVisible = camera:WorldToViewportPoint(feetPosition)

	if not headVisible or not feetVisible then return end

    -- Calculate Bounds Size
	local height = feetScreenPosition.Y - headScreenPosition.Y
    if height <= 0 then return end 

	local width = height / 2

    -- Calculate Bounds Position
	local x = headScreenPosition.X - (width / 2)
	local y = headScreenPosition.Y

	return Vector2.new(x, y), Vector2.new(width, height)
end

-- ESPBox class 
local ESPBox = {}
ESPBox.__index = ESPBox

-- Constructor
function ESPBox.new(target, style)
    local self = setmetatable({}, ESPBox)

    self.Target = target
    self.Drawing = Drawing.new("Square")

    self.Drawing.Color = style.Color
	self.Drawing.Thickness = style.Thickness
	self.Drawing.Filled = style.Filled
	self.Drawing.Transparency = style.Transparency
	self.Drawing.Visible = false

    return self
end

-- ESP Update
function ESPBox:Update()
    if not self.Target then 
        self:Destroy() 
        return false
    end

    local position, size = GetBounds(self.Target)

    if position and size then
        self.Drawing.Visible = true
        self.Drawing.Position = position
        self.Drawing.Size = size
    else
        self.Drawing.Visible = false
    end
    return true
end

-- ESP Destroy
function ESPBox:Destroy()
    if self.Drawing then
        self.Drawing:Remove()
        self.Drawing = nil
    end
    self.Target = nil
end

-- Main Library
local ESPModule = {}
ESPModule.ActiveESPs = {}

-- Base Style
ESPModule.DefaultStyle = {
    Color = Color3.fromRGB(255, 0, 0);
    Thickness = 3;
    Filled = false;
    Transparency = 0.5;
}

-- Add ESP to player
function ESPModule:Add(target, customStyle)
    if not target then return end
    if self.ActiveESPs[target] then return end

    local style = nil
    if customStyle then style = customStyle
    else style = ESPModule.DefaultStyle end

    local newESP = ESPBox.new(target, style)
    self.ActiveESPs[target] = newESP
end

-- Remove ESP from player
function ESPModule:Remove(target)
    local ESP = self.ActiveESPs[target]
    if ESP then
        ESP:Destroy()
        self.ActiveESPs[target] = nil
    end
end

-- Update all active ESPs
function ESPModule:UpdateAll()
    for target, ESP in pairs(self.ActiveESPs) do
        local result = ESP:Update()
        if not result then
            self.ActiveESPs[target] = nil
        end
    end
end

return ESPModule