-- Carrega a biblioteca Orion
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
local player = game.Players.LocalPlayer

-- Cria a janela
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHubConfig",
    IntroEnabled = true,
    IntroText = "Dr4gonHub",
    IntroIcon = "rbxassetid://4483345998",
    Icon = "rbxassetid://4483345998"
})

-- 🧩 Aba Misc
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Seção 1
MiscTab:AddSection({ Name = "Movimentação" })

MiscTab:AddButton({
    Name = "Speed (150)",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.WalkSpeed = 150 end
    end
})

MiscTab:AddButton({
    Name = "JumpPower (100)",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.JumpPower = 100 end
    end
})

MiscTab:AddButton({
    Name = "Resetar Status",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
        OrionLib:MakeNotification({
            Name = "Status Resetado",
            Content = "Voltou ao normal!",
            Time = 4
        })
    end
})

-- Seção 2
MiscTab:AddSection({ Name = "Utilitários" })

MiscTab:AddButton({
    Name = "Ajustar Iluminação",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.new(0.2, 0.2, 0.2)
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    end
})

MiscTab:AddButton({
    Name = "Anti AFK",
    Callback = function()
        local vu = game:service("VirtualUser")
        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)

        OrionLib:MakeNotification({
            Name = "Anti AFK",
            Content = "Anti AFK ativado!",
            Time = 5
        })
    end
})

MiscTab:AddButton({
    Name = "Teletransportar para (0, 50, 0)",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(Vector3.new(0, 50, 0))
        end
    end
})

MiscTab:AddButton({
    Name = "Fechar Hub",
    Callback = function()
        OrionLib:Destroy()
    end
})

-- Seção 3
MiscTab:AddSection({ Name = "FX3 Simulada" })

MiscTab:AddButton({
    Name = "FX3",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "FX3",
            Content = "FX3 ativada!",
            Time = 3
        })
        print("FX3 ativada!")
    end
})

-- 🌱 Aba Grow a Garden
local GardenTab = Window:MakeTab({
    Name = "🌱Grow a Garden",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

GardenTab:AddSection({ Name = "Scripts Externos" })

GardenTab:AddButton({
    Name = "Speed X Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
    end
})

GardenTab:AddButton({
    Name = "Seed Spawner",
    Callback = function()
        loadstring(game:HttpGet("https://codeberg.org/twentys2/Scripts/raw/branch/main/Grow-A-Garden"))()
    end
})

-- Inicia a interface
OrionLib:Init()

-- Notificação de entrada
OrionLib:MakeNotification({
    Name = "Bem-vindo!",
    Content = "Dr4gonHub foi iniciado com sucesso!",
    Image = "rbxassetid://4483345998",
    Time = 5
})
