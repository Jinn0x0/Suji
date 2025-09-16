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
local HttpService = game:GetService("HttpService")
local url = "https://raw.githubusercontent.com/YourUsername/YourRepo/main/Services.lua"
local Services = loadstring(HttpService:GetAsync(url))()

print(Services.Players.LocalPlayer)