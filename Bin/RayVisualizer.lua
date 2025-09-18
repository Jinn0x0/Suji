local TweenService = game:GetService("TweenService")

local RayVisualizer = {}

export type Options = {
	Color: Color3?,
	HitColor: Color3?,
	MissColor: Color3?,
	Width0: number?,
	Width1: number?,
	Transparency: number?,
	Lifetime: number?, -- seconds before auto-destroy
	Parent: Instance?,
	RaycastParams: RaycastParams?
}

-- helper to make invisible anchor parts
local function makePart(name: string, parent: Instance): Part
	local p = Instance.new("Part")
	p.Name = name
	p.Size = Vector3.new(0.2, 0.2, 0.2)
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.Transparency = 1
	p.Parent = parent
	return p
end

--- Visualize a ray between origin and origin+direction
function RayVisualizer.Visualize(origin: Vector3, direction: Vector3, opts: Options?): (Folder, RaycastResult?)
	opts = opts or {}
	local parent = opts.Parent or workspace

	-- Perform raycast
	local raycastResult = workspace:Raycast(origin, direction, opts.RaycastParams)
	local hitPos = raycastResult and raycastResult.Position or (origin + direction)

	-- Make container
	local folder = Instance.new("Folder")
	folder.Name = "RayVisualizer"
	folder.Parent = parent

	-- Parts + Attachments
	local p0 = makePart("Start", folder)
	local p1 = makePart("End", folder)
	p0.CFrame = CFrame.new(origin)
	p1.CFrame = CFrame.new(hitPos)

	local a0 = Instance.new("Attachment")
	a0.Parent = p0
	local a1 = Instance.new("Attachment")
	a1.Parent = p1

	-- Beam setup
	local beam = Instance.new("Beam")
	beam.Attachment0 = a0
	beam.Attachment1 = a1
	beam.FaceCamera = true
	beam.Width0 = opts.Width0 or 0.1
	beam.Width1 = opts.Width1 or beam.Width0
	beam.Transparency = NumberSequence.new(opts.Transparency or 0)
	beam.LightEmission = 1
	beam.Color = ColorSequence.new(
		opts.Color or (raycastResult and (opts.HitColor or Color3.fromRGB(0,255,0)) or (opts.MissColor or Color3.fromRGB(255,0,0)))
	)
	beam.Parent = folder

	-- Auto-destroy (with fade out)
	if opts.Lifetime and opts.Lifetime > 0 then
		task.delay(opts.Lifetime, function()
			if folder.Parent then
				-- Tween transparency manually
				local fade = Instance.new("NumberValue")
				fade.Value = 0
				local tween = TweenService:Create(fade, TweenInfo.new(0.25), {Value = 1})

				fade.Changed:Connect(function(val)
					beam.Transparency = NumberSequence.new(val)
				end)

				tween:Play()
				tween.Completed:Wait()
				folder:Destroy()
			end
		end)
	end

	return folder, raycastResult
end

return RayVisualizer
