local HttpService = game:GetService("HttpService")

local Import = {
    repo  = "Jinn0x0/Suji",
    ref   = "main",
    cache = {},
}

local function baseUrl()
    return ("https://raw.githubusercontent.com/%s/refs/heads/%s/"):format(Import.repo, Import.ref)
end

local function normalize(name)
    return (name:gsub("%.", "/")) .. ".lua"
end

local function fetchSource(url)
    if HttpService and HttpService.GetAsync then
        local ok, result = pcall(HttpService.GetAsync, HttpService, url)
        if ok then
            return result
        end
    end
    local ok2, result2 = pcall(function()
        return game:HttpGet(url)
    end)
    if ok2 then
        return result2
    else
        error(("Import: failed to fetch %s\n%s"):format(url, tostring(result2)))
    end
end

local function fetchModule(path)
    local url = baseUrl() .. path
    local src = fetchSource(url)

    if type(loadstring) ~= "function" then
        error("Import: loadstring is disabled. Enable LoadStringEnabled or run in LocalScript.")
    end

    local chunk, compileErr = loadstring(src)
    if not chunk then
        error(("Import: compile error for %s\n%s"):format(url, tostring(compileErr)))
    end

    local ok, mod = pcall(chunk)
    if not ok then
        error(("Import: run error for %s\n%s"):format(url, tostring(mod)))
    end
    if type(mod) ~= "table" and type(mod) ~= "function" then
        print("A ")
        error(("Import: module %s must return a table or function"):format(path))
    end
    return mod
end

function Import.import(dottedName)
    local path = normalize(dottedName)
    if Import.cache[path] then
        return Import.cache[path]
    end
    local mod = fetchModule(path)
    Import.cache[path] = mod
    return mod
end

function Import.from(dottedName, keys)
    local mod = Import.import(dottedName)
    local out = {}
    for _, k in ipairs(keys) do
        out[k] = mod[k]
        if out[k] == nil then
            error(("Import: key '%s' not found in %s"):format(k, dottedName))
        end
    end
    return out
end

return Import
