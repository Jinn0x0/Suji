local MathModule = {}

-- Get Distance
function MathModule.getDistance(a: Vector3, b: Vector3): number
	return (a - b).Magnitude
end

-- Round
function MathModule.round(num, place)
  local mult = 10 ^ place
  return math.floor(num * mult + 0.5) / mult
end

-- Sign
function MathModule.sign(num)
  if num == 0 then
    return 0
  elseif num > 0 then
    return 1
  else
    return -1
  end
end

-- Angle Between
function MathModule.angleBetween(a, b)
    return math.acos(math.clamp(a:Dot(b) / (a.Magnitude * b.Magnitude), -1, 1))
end

-- Reflect
function MathModule.reflect(v, normal)
    return v - 2 * v:Dot(normal) * normal
end

-- Mid Point
function MathModule.midpoint(a, b)
    return (a + b) / 2
end

-- Project
function MathModule.project(a, b)
    return (a:Dot(b) / b:Dot(b)) * b
end

-- Get Direction
function MathModule.GetDirection(a: Position, b: Position): Vector3
    return (a - b).Unit
end


return MathModule