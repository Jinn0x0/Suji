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

function MathModule.vectorLerp(a, b, t)
    return a + (b - a) * t
end

function MathModule.angleBetween(a, b)
    return math.acos(math.clamp(a:Dot(b) / (a.Magnitude * b.Magnitude), -1, 1))
end

function MathModule.reflect(v, normal)
    return v - 2 * v:Dot(normal) * normal
end

function MathModule.midpoint(a, b)
    return (a + b) / 2
end

function MathModule.project(a, b)
    return (a:Dot(b) / b:Dot(b)) * b
end


return MathModule