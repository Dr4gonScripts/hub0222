--[[
  龙王 Dr4gonHub Premium - 完整版
  Complete Chinese-themed hub with all features
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== SAFE LIBRARY LOAD =====
local OrionLib
local loadAttempts = 0

repeat
    local success
    success, OrionLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
    end)
    
    if not success and loadAttempts < 2 then
        loadAttempts += 1
        OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    end
until OrionLib or loadAttempts >= 2

if not OrionLib then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "加载错误",
        Text = "无法加载UI库",
        Duration = 10
    })
    return
end

-- ===== CHINESE THEME =====
local Theme = {
    Colors = {
        Primary = Color3.fromRGB(188, 10, 28),   -- Red
        Secondary = Color3.fromRGB(255, 212, 96), -- Gold
        Background = Color3.fromRGB(25, 20, 15)   -- Dark
    },
    Symbols = {
        Dragon = "🐉",
        Lantern = "🏮",
        Sword = "⚔️",
        YinYang = "☯"
    }
}

-- ===== MAIN WINDOW =====
local Window = OrionLib:MakeWindow({
    Name = "龙王 Hub",  -- Dragon King Hub
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHubConfig",
    IntroEnabled = true,
    IntroText = "欢迎使用 Dr4gonHub",  -- Welcome to Dr4gonHub
    IntroIcon = "rbxassetid://14204253922"
})

-- ===== UTILITIES TAB =====
local UtilityTab = Window:MakeTab({
    Name = Theme.Symbols.Sword .. " 实用工具",  -- Utilities
    Icon = "rbxassetid://0"
})

-- Movement Section
UtilityTab:AddSection({Name = Theme.Symbols.YinYang .. " 移动控制"})  -- Movement Controls

-- WalkSpeed
UtilityTab:AddSlider({
    Name = "移动速度 速度",  -- WalkSpeed
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Theme.Colors.Primary,
    Callback = function(Value)
        pcall(function()
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = Value
            end
        end)
    end
})

-- JumpPower
UtilityTab:AddSlider({
    Name = "跳跃力量 跳跃",  -- JumpPower
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Theme.Colors.Secondary,
    Callback = function(Value)
        pcall(function()
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = Value
            end
        end)
    end
})

-- Fly System
local flyEnabled = false
local flyConnection
UtilityTab:AddToggle({
    Name = "飞行模式 (F)",  -- Fly Mode
    Default = false,
    Callback = function(Value)
        flyEnabled = Value
        if flyEnabled then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = Player.Character.HumanoidRootPart
            
            flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not flyEnabled or not Player.Character then
                    if flyConnection then flyConnection:Disconnect() end
                    return
                end
                
                local root = Player.Character.HumanoidRootPart
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                    root.CFrame = root.CFrame * CFrame.new(0, 1, 0)
                elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                    root.CFrame = root.CFrame * CFrame.new(0, -1, 0)
                end
                root.Velocity = Vector3.new(0, 0, 0)
            end)
        elseif flyConnection then
            flyConnection:Disconnect()
            for _, v in pairs(Player.Character.HumanoidRootPart:GetChildren()) do
                if v:IsA("BodyVelocity") then
                    v:Destroy()
                end
            end
        end
    end
})

-- Teleport
UtilityTab:AddButton({
    Name = "传送至光标 (T)",  -- Teleport to Cursor
    Callback = function()
        local inputConn
        inputConn = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == Enum.KeyCode.T then
                pcall(function()
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
                end)
            end
        end)
    end
})

-- Noclip
local noclipEnabled = false
local noclipConnection
UtilityTab:AddToggle({
    Name = "穿墙模式",  -- Noclip
    Default = false,
    Callback = function(Value)
        noclipEnabled = Value
        if noclipEnabled then
            noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                if not Player.Character then return end
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        elseif noclipConnection then
            noclipConnection:Disconnect()
        end
    end
})

-- Anti-AFK
UtilityTab:AddButton({
    Name = "防挂机",  -- Anti-AFK
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
})

-- ===== INITIALIZATION =====
OrionLib:Init()

-- Auto-update on respawn
Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    -- Reapply settings if needed
end)

print([[
  龙王 Hub 已激活!
  ▄︻デ══━✧ 龙的力量 ✧━══デ︻▄
]])
