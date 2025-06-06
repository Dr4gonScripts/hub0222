-- Carrega a OrionLib modificada de jensonhirst
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

-- Referência ao jogador local
local player = game.Players.LocalPlayer

-- Cria a janela principal
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHubConfig"
})

-- Cria a aba Misc
local Tab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddSection({
    Name = "Utilitários"
})

-- Notificação de boas-vindas
OrionLib:MakeNotification({
    Name = "Inicializando...",
    Content = "Bem-vindo ao Dr4gonHub!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Anti-AFK
Tab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK",
            Content = "Anti-AFK ativado com sucesso!",
            Time = 5
        })
    end
})

-- Resetar status
Tab:AddButton({
    Name = "Resetar WalkSpeed e JumpPower",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
    end
})

-- WalkSpeed 100
Tab:AddButton({
    Name = "WalkSpeed 100",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 100
        end
    end
})

-- JumpPower 100
Tab:AddButton({
    Name = "JumpPower 100",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = 100
        end
    end
})

-- Abre a UI
OrionLib:Init()
