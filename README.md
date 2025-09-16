# Suji 🕹️ Roblox Utility Scripts Hub

A collection of Roblox Lua utilities to make scripting easier.  
Includes service loaders, player utilities, and more.

---

## ✨ Features
- 🎮 Easy access to common Roblox services
- 👥 Player utility functions
- ⚡ Load directly from GitHub with `HttpGet`

---

## 🚀 Getting Started

**Load services from GitHub:**

```lua
local Owner = "Jinn0x0"
local Project = "Suji"

local HttpService = game:GetService("HttpService")

local url = ("https://raw.githubusercontent.com/%s/%s/main/%s"):format(Owner,Project,"Import.lua")
local okSrc, src = pcall(HttpService.GetAsync, HttpService, url)
local chunk, compileErr = loadstring(src)
local okRun, Import = pcall(chunk)

local Test = Import.import("Bin.Test")
Test.run()
