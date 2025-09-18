local MathModule = {}

-- Get Distance
function MathModule.GetDistance(a: Vector3, b: Vector3): number
	return (a - b).Magnitude
end

-- Get Direction
function MathModule.GetDirection(a: Position, b: Position): Vector3
    return (a - b).Unit
end

-- Round
function MathModule.Round(num, place)
  local mult = 10 ^ place
  return math.floor(num * mult + 0.5) / mult
end

-- Sign
function MathModule.Sign(num)
  if num == 0 then
    return 0
  elseif num > 0 then
    return 1
  else
    return -1
  end
end

-- Angle Between
function MathModule.AngleBetween(a, b)
    return math.acos(math.clamp(a:Dot(b) / (a.Magnitude * b.Magnitude), -1, 1))
end

-- Reflect
function MathModule.Reflect(v, normal)
    return v - 2 * v:Dot(normal) * normal
end

-- Mid Point
function MathModule.Midpoint(a, b)
    return (a + b) / 2
end

-- Project
function MathModule.Project(a, b)
    return (a:Dot(b) / b:Dot(b)) * b
end

-- Vector Clamp
function MathModule.ClampMagnitude(v: Vector3, maxLength: number): Vector3
    if v.Magnitude > maxLength then
        return v.Unit * maxLength
    end
    return v
end

-- Rotate Around Axis
function MathModule.RotateAroundAxis(v: Vector3, axis: Vector3, angle: number): Vector3
    local cosTheta = math.cos(angle)
    local sinTheta = math.sin(angle)
    return v * cosTheta + axis:Cross(v) * sinTheta + axis * (axis:Dot(v)) * (1 - cosTheta)
end



return MathModule