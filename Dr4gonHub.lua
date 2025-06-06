-- Carregar a versão atual da OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
local Player = game.Players.LocalPlayer

-- Criar a janela principal
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHub",
    IntroEnabled = true,
    IntroText = "Bem-vindo ao Dr4gonHub!",
    Icon = "https://www.istockphoto.com/photos/dragon"
})

---------------------------------------------------------------------
-- ABA: Misc
---------------------------------------------------------------------
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MiscTab:AddSection({Name = "Utilitários"})

-- Anti-AFK
MiscTab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK",
            Content = "Você está protegido contra kick por inatividade.",
            Time = 5
        })
    end
})

-- Reset WalkSpeed e JumpPower
MiscTab:AddButton({
    Name = "Resetar WalkSpeed e JumpPower",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
    end
})

-- WalkSpeed 100
MiscTab:AddButton({
    Name = "WalkSpeed 100",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.WalkSpeed = 100 end
    end
})

-- JumpPower 100
MiscTab:AddButton({
    Name = "JumpPower 100",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.JumpPower = 100 end
    end
})

---------------------------------------------------------------------
-- ABA: Blox Fruits
---------------------------------------------------------------------
local BFTab = Window:MakeTab({
    Name = "Blox Fruits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

BFTab:AddSection({Name = "Hubs externos"})

BFTab:AddButton({
    Name = "Speed X Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
    end
})

BFTab:AddButton({
    Name = "Ro Hub",
    Callback = function()
        _G.settings = {autoLoadConfig = false, joinTeam = "Pirates"}
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RO-HUB-CODEX/RO-HUB/refs/heads/main/bloxfruits.lua"))()
    end
})

BFTab:AddButton({
    Name = "W Azure",
    Callback = function()
        getgenv().Team = "Marines"
        getgenv().AutoLoad = false
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
    end
})

BFTab:AddButton({
    Name = "Tsou Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
    end
})

BFTab:AddButton({
    Name = "Banana Free",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kimprobloxdz/Banana-Free/refs/heads/main/Protected_5609200582002947.lua.txt"))()
    end
})

---------------------------------------------------------------------
-- ABA: Grow a Garden
---------------------------------------------------------------------
local GardenTab = Window:MakeTab({
    Name = "🌱 Grow a Garden",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

GardenTab:AddSection({Name = "Scripts - AutoFarm & Dupe"})

GardenTab:AddButton({
    Name = "Speed X Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
    end
})

GardenTab:AddButton({
    Name = "No-Lag Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
    end
})

GardenTab:AddButton({
    Name = "OFF (placeholder)",
    Callback = function()
        print("Botão OFF clicado.")
    end
})

---------------------------------------------------------------------
-- Inicializar interface
---------------------------------------------------------------------
OrionLib:Init()
