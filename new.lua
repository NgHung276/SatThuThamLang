--// SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

--// LOAD UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// WINDOW
local Window = Rayfield:CreateWindow({
    Name = "Vortex Hub by real_NgHung [Premium]",
    LoadingTitle = "Vortex Hub",
    LoadingSubtitle = "Sát Thủ Thầm Lặng [Premium] - By real_NgHung",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

--// GLOBALS
_G.AutoRound = false
_G.KillAura = false
_G.AuraRange = 20
_G.ESPEnabled = false
_G.ESPColor = Color3.fromRGB(255, 50, 50)
_G.WalkSpeed = 16
_G.JumpPower = 50
_G.AutoEquip = false
_G.InMatch = false
_G.LastUIScan = 0

--// TABS
local CombatTab = Window:CreateTab("⚔️ Combat")
local VisualTab = Window:CreateTab("👁️ Visuals")
local MoveTab = Window:CreateTab("🏃 Movement")
local InfoTab = Window:CreateTab("⚙️ Info")

--// COMBAT
CombatTab:CreateToggle({
    Name = "Auto Round (Sát Thủ Auto)",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoRound = v
        _G.InMatch = false
    end
})

CombatTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Callback = function(v)
        _G.KillAura = v
    end
})

CombatTab:CreateSlider({
    Name = "Aura Range",
    Range = {10, 500},
    Increment = 1,
    CurrentValue = 20,
    Callback = function(v)
        _G.AuraRange = v
    end
})

--// VISUAL
VisualTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(v)
        _G.ESPEnabled = v
    end
})

VisualTab:CreateColorPicker({
    Name = "ESP Color",
    Color = Color3.fromRGB(255,50,50),
    Callback = function(v)
        _G.ESPColor = v
    end
})

--// MOVEMENT
MoveTab:CreateToggle({
    Name = "Auto Equip",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoEquip = v
    end
})

MoveTab:CreateSlider({
    Name = "Speed",
    Range = {16,200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        _G.WalkSpeed = v
    end
})

MoveTab:CreateSlider({
    Name = "Jump",
    Range = {50,300},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(v)
        _G.JumpPower = v
    end
})

--// INFO
InfoTab:CreateLabel("Vortex Hub [Premium]")

--// ===== SYSTEM =====

local function KillTarget(target, dist)
    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool")
    if not tool then return end

    local args = {
        [1] = "AttemptWeaponHit",
        [2] = {damage = 999999999, hitboxSize = Vector3.new(120,120,120)},
        [3] = {}
    }

    ReplicatedStorage.Events.GameRemoteFunction:InvokeServer(unpack(args))
end

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = _G.WalkSpeed
        char.Humanoid.JumpPower = _G.JumpPower
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if _G.KillAura then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, enemy in pairs(Players:GetPlayers()) do
                    if enemy ~= LocalPlayer and enemy.Character then
                        local root = enemy.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            local dist = (char.HumanoidRootPart.Position - root.Position).Magnitude
                            if dist <= _G.AuraRange then
                                KillTarget(enemy.Character, dist)
                            end
                        end
                    end
                end
            end
        end
    end
end)