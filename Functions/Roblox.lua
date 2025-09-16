local HttpService = game:GetService("HttpService")
loadstring(HttpService:GetAsync("https://raw.githubusercontent.com/Jinn0x0/Suji/main/Bin/GetService.lua"))() -- Load all services

local M = {}

function M.predictWithAngularVelocity(p0, v, rot0, angVel, t, maxDist)
	local linearPos = p0 + v * t;
	local futureYaw = rot0 + angVel.Y * t;
	local dir2D = Vector3.new(math.cos(futureYaw), 0, math.sin(futureYaw));
	local predicted = linearPos + dir2D;
	local dist = (predicted - p0).Magnitude;
	if dist > maxDist then
		predicted = p0 + ((predicted - p0)).Unit * maxDist;
	end;
	return predicted;
end

return M
