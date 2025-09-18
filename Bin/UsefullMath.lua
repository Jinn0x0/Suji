local MathModule = {}

-- Object related
function MathModule.getDistance(object_one, object_two)
  return (object_one.Position - object_two.Position).Magnitude
end

-- Number related
function MathModule.round(num, place)
  local mult = 10 ^ place
  return math.floor(num * mult + 0.5) / mult
end

function MathModule.sign(num)
  if num == 0 then
    return 0
  elseif num > 0 then
    return 1
  else
    return -1
  end
end

return MathModule