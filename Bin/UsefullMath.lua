local MathModule = {}

-- Addition
function MathModule.Add(a: number, b: number): number
  return a + b
end

-- Subtraction
function MathModule.Sub(a: number, b: number): number
  return a - b
end

-- Multiplication
function MathModule.Mul(a: number, b: number): number
  return a * b
end

-- Division
function MathModule.Div(a: number, b: number): number
  return a / b
end

-- Module
function MathModule.Mod(a: number, b: number): number
  return a % b
end

-- Power
function MathModule.Pow(a: number, b: number): number
  return a ^ b
end

-- Root
function MathModule.Root(x: number, n: number): number
    return x ^ (1/n)
end

-- Exponential
function MathModule.Exp(x) 
  return math.exp(x) 
end

-- Natural Logarithm
function MathModule.Ln(x) 
  return math.log(x) 
end

-- Logarithm
function MathModule.Log(x, base) 
  local base = base or 10
  return math.log(x) / math.log(base) 
end

-- Magnitude
function MathModule.Magnitude(vec: Vector3)
    return (vec.X^2 + vec.Y^2 + vec.Z^2) ^ 0.5
end

-- Lerp Vector2
function MathModule.LerpVector2(a: Vector2, b: Vector2, t: number): Vector2
    return a + (b - a) * t
end

-- Lerp Vector3
function MathModule.LerpVector3(a: Vector3, b: Vector3, t: number): Vector3
    return a:Lerp(b, t)
end


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