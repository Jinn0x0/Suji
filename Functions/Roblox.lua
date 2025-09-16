local HttpService = game:GetService("HttpService")
loadstring(HttpService:GetAsync("https://raw.githubusercontent.com/Jinn0x0/Suji/main/Bin/GetService.lua"))() -- Load all services

local M = {}

----------------------------------------------------------------------
-- 1) Linear prediction: constant-velocity motion
--    Predicts where a target at p0 with velocity v will be after time t.
--    Optional maxDist clamps how far from p0 the result can be.

--    M.predictLinear(target.HumanoidRootPart.Position, target.HumanoidRootPart.AssemblyLinearVelocity, 0.5)
--    aim at `future`
----------------------------------------------------------------------
function M.predictLinear(p0: Vector3, v: Vector3, t: number, maxDist: number?): Vector3
    local predicted = p0 + v * t
    if maxDist then
        local offset = predicted - p0
        local d = offset.Magnitude
        if d > maxDist and d > 0 then
            predicted = p0 + offset.Unit * maxDist
        end
    end
    return predicted
end

----------------------------------------------------------------------
-- 2) Intercept prediction (constant target velocity, constant projectile speed)
--    Given:
--      shooterPos  = your position (Vector3)
--      projectileSpeed = your bullet/beam speed (studs/sec)
--      targetPos   = target current position (Vector3)
--      targetVel   = target current velocity (Vector3)
--    Returns:
--      predicted target position at intercept time (or nil if no solution)
--[[
local shooterPos = myGun.Muzzle.WorldPosition
local projectileSpeed = 500 -- studs/sec (set this to your projectile)
local targetPos = target.HumanoidRootPart.Position
local targetVel = target.HumanoidRootPart.AssemblyLinearVelocity

local aimPoint, timeToHit = M.predictInterceptConstantSpeed(shooterPos, projectileSpeed, targetPos, targetVel)
if aimPoint then
    -- cast/launch toward aimPoint
else
    -- fallback: shoot at current position or use linear prediction
end

]]
----------------------------------------------------------------------
function M.predictInterceptConstantSpeed(shooterPos: Vector3, projectileSpeed: number, targetPos: Vector3, targetVel: Vector3): (Vector3?, number?)
    local d = targetPos - shooterPos
    local v = targetVel
    local s = projectileSpeed

    -- Solve ||d + v*t|| = s*t
    -- => (v·v - s^2) t^2 + 2(d·v) t + (d·d) = 0
    local vv = v:Dot(v)
    local dv = d:Dot(v)
    local dd = d:Dot(d)
    local a = vv - (s * s)
    local b = 2 * dv
    local c = dd

    local t
    if math.abs(a) < 1e-6 then
        -- Degenerate to linear: a ~ 0 -> s ≈ |v|
        -- Then equation reduces to b t + c = 0  =>  t = -c / b
        if math.abs(b) < 1e-6 then
            -- No movement difference; fall back: shoot directly (instant or no solution)
            return nil, nil
        end
        local t_lin = -c / b
        if t_lin <= 0 then return nil, nil end
        t = t_lin
    else
        local disc = b*b - 4*a*c
        if disc < 0 then
            -- No real intercept time: target too fast or moving away
            return nil, nil
        end
        local sqrtDisc = math.sqrt(disc)
        local t1 = (-b - sqrtDisc) / (2*a)
        local t2 = (-b + sqrtDisc) / (2*a)

        -- We want the smallest positive time
        local best
        if t1 > 1e-5 then best = t1 end
        if t2 > 1e-5 and (not best or t2 < best) then best = t2 end
        if not best then return nil, nil end
        t = best
    end

    local predicted = targetPos + v * t
    return predicted, t
end



return M
