local HttpService = game:GetService("HttpService")

local Import = {
    repo = "Jinn0x0/Suji",  -- <USER>/<REPO>
    ref  = "main", 
    cache = {},
    timeout = 10,           -- seconds (optional, GetAsync obeys HttpService settings)
}

-- Configure once (optional)
function Import.setup(opts)
    for k,v in pairs(opts or {}) do
        Import[k] = v
    end
end

local function baseUrl()
    return ("https://raw.githubusercontent.com/%s/%s/"):format(Import.repo, Import.ref)
end

local function normalize(name)
    -- "pkg.sub.module" -> "pkg/sub/module.lua"
    return (name:gsub("%.", "/")) .. ".lua"
end

local function fetchModule(path)
    local url = baseUrl() .. path
    local ok, src = pcall(HttpService.GetAsync, HttpService, url)
    if not ok then
        error(("Import: failed to fetch %s\n%s"):format(url, tostring(src)))
    end
    local ok2, modOrErr = pcall(loadstring(src))
    if not ok2 then
        error(("Import: load error for %s\n%s"):format(url, tostring(modOrErr)))
    end
    local mod = modOrErr()
    if type(mod) ~= "table" then
        error(("Import: module %s must return a table"):format(path))
    end
    return mod
end

-- Python: import pkg.sub as alias  ->  local alias = Import.import("pkg.sub")
function Import.import(dottedName)
    local path = normalize(dottedName)
    local cached = Import.cache[path]
    if cached then return cached end
    local mod = fetchModule(path)
    Import.cache[path] = mod
    return mod
end

-- Python: from pkg.sub import a, b  ->  local {a,b} = Import.from("pkg.sub", {"a","b"})
-- (Lua can’t destructure; we return a table you can unpack)
function Import.from(dottedName, keys)
    local mod = Import.import(dottedName)
    local out = {}
    for _,k in ipairs(keys) do
        out[k] = mod[k]
        if out[k] == nil then
            error(("Import: key '%s' not found in %s"):format(k, dottedName))
        end
    end
    return out
end

-- Optional convenience: alias into cache with a different name
function Import.alias(dottedName, as)
    local mod = Import.import(dottedName)
    Import.cache[normalize(as)] = mod
    return mod
end

return Import
