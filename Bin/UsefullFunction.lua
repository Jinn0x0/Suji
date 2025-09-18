local M = {}

function M.getDistance(object_one, object_two)
  return (object_one.Position - object_two.Position).Magnitude
end

function M.sign(num)
  if num == 0 then
    return 0
  elseif num > 0 then
    return 1
  else
    return -1
  end
end

function M.round(num, place)
  local mult = 10 ^ place
  return math.floor(num * mult + 0.5) / mult
end

return M