function Tween(obj, props, time)
    local tween = TweenService:Create(obj, time, props)
    tween:Play()
end


--[[

Quick Tween:

local TweenModule = -- IMPORT

TweenModule.Tween(Player, {Position = Vector3(0, 0, 0)}, 5)

]]
