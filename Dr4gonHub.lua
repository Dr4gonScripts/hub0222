-- Carrega a OrionLib antiga
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

local Player = game.Players.LocalPlayer

-- Cria a janela principal
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHub"
})

-- TAB: Misc
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MiscTab:AddSection({
    Name = "Utilitários"
})

-- Botão: Anti-AFK
MiscTab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK",
            Content = "Anti-AFK ativado com sucesso!",
            Time = 5
        })
    end
})

-- Botão: Resetar Status
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

-- Botão: Aumentar velocidade
MiscTab:AddButton({
    Name = "WalkSpeed 100",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 100
        end
    end
})

-- Botão: Aumentar pulo
MiscTab:AddButton({
    Name = "JumpPower 100",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.JumpPower = 100
        end
    end
})

-- TAB: Blox Fruits
local BFruitsTab = Window:MakeTab({
    Name = "🍎 Blox Fruits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

BFruitsTab:AddSection({
    Name = "Hubs e Scripts"
})

-- Botão: Speed Hub X
BFruitsTab:AddButton({
    Name = "Speed Hub X",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

-- Inicializa a UI
OrionLib:Init()
