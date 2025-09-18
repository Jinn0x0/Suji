-- Base64.lua (Luau/Lua ModuleScript)
local Base64 = {}

Base64.STANDARD_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- validate that alphabet is 64 unique characters
local function validateAlphabet(alphabet: string)
    if type(alphabet) ~= "string" or #alphabet ~= 64 then
        error("Base64 alphabet must be a 64-character string", 2)
    end
    local seen = {}
    for i = 1, 64 do
        local ch = alphabet:sub(i, i)
        if seen[ch] then
            error("Base64 alphabet contains duplicate character: " .. ch, 2)
        end
        seen[ch] = true
    end
end

-- create lookup table for decoding
local function makeReverseMap(alphabet: string)
    local rev = {}
    for i = 1, 64 do
        rev[alphabet:sub(i, i)] = i - 1
    end
    return rev
end

--- Encode
function Base64.encode(input: string, alphabet: string?): string
    alphabet = alphabet or Base64.STANDARD_ALPHABET
    validateAlphabet(alphabet)

    local bytes = {string.byte(input, 1, #input)}
    local out = table.create(math.ceil(#bytes / 3) * 4)

    local i, o = 1, 1
    while i <= #bytes do
        local b1 = bytes[i] or 0
        local b2 = bytes[i + 1] or 0
        local b3 = bytes[i + 2] or 0

        local n = b1 << 16 | b2 << 8 | b3

        local c1 = (n >> 18) & 0x3F
        local c2 = (n >> 12) & 0x3F
        local c3 = (n >> 6)  & 0x3F
        local c4 =  n        & 0x3F

        out[o]     = alphabet:sub(c1 + 1, c1 + 1)
        out[o + 1] = alphabet:sub(c2 + 1, c2 + 1)

        if i + 1 <= #bytes then
            out[o + 2] = alphabet:sub(c3 + 1, c3 + 1)
        else
            out[o + 2] = "="
        end

        if i + 2 <= #bytes then
            out[o + 3] = alphabet:sub(c4 + 1, c4 + 1)
        else
            out[o + 3] = "="
        end

        i = i + 3
        o = o + 4
    end

    return table.concat(out)
end

--- Decode
function Base64.decode(b64: string, alphabet: string?): string
    alphabet = alphabet or Base64.STANDARD_ALPHABET
    validateAlphabet(alphabet)
    local rev = makeReverseMap(alphabet)

    b64 = b64:gsub("%s+", "")
    if (#b64 % 4) ~= 0 then
        error("Invalid Base64: length must be multiple of 4", 2)
    end

    local out = table.create(math.floor(#b64 / 4) * 3)
    local o = 1
    local i = 1
    while i <= #b64 do
        local a = b64:sub(i, i)
        local b = b64:sub(i + 1, i + 1)
        local c = b64:sub(i + 2, i + 2)
        local d = b64:sub(i + 3, i + 3)

        local v1 = rev[a]
        local v2 = rev[b]
        local v3 = c ~= "=" and rev[c] or nil
        local v4 = d ~= "=" and rev[d] or nil

        if v1 == nil or v2 == nil or (c ~= "=" and v3 == nil) or (d ~= "=" and v4 == nil) then
            error("Invalid Base64: character not in alphabet", 2)
        end

        local n = (v1 << 18) | (v2 << 12) | ((v3 or 0) << 6) | (v4 or 0)

        local b1 = (n >> 16) & 0xFF
        local b2 = (n >> 8)  & 0xFF
        local b3 =  n        & 0xFF

        out[o] = string.char(b1)
        if c ~= "=" then out[o + 1] = string.char(b2) end
        if d ~= "=" then out[o + 2] = string.char(b3) end

        o = o + (d ~= "=" and 3 or (c ~= "=" and 2 or 1))
        i = i + 4
    end

    return table.concat(out)
end

--- XOR a string with a key
function Base64.xorWithKey(input: string, key: string): string
    local out = table.create(#input)
    local klen = #key
    for i = 1, #input do
        local sb = string.byte(input, i)
        local kb = string.byte(key, ((i - 1) % klen) + 1)
        out[i] = string.char(bit32.bxor(sb, kb))
    end
    return table.concat(out)
end

return Base64
