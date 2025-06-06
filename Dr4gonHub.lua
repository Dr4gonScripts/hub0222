-- Carrega a biblioteca Orion
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

-- Garante acesso ao player
local player = game.Players.LocalPlayer

-- Cria a janela principal
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest",
    IntroEnabled = true,
    IntroText = "Dr4gonHub",
    IntroIcon = "rbxassetid://4483345998",
    Icon = "rbxassetid://4483345998"
})

-- Aba Misc
local Tab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddSection({ Name = "Funções Diversas" })

-- Notificação inicial
OrionLib:MakeNotification({
    Name = "Inicializando...",
    Content = "Bem-vindo ao Dr4gonHub!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Botão de velocidade
Tab:AddButton({
    Name = "Speed (150)",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 150
        end
    end
})

-- Botão de pulo
Tab:AddButton({
    Name = "JumpPower (100)",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = 100
        end
    end
})

-- Ajuste de iluminação
Tab:AddButton({
    Name = "Ajustar Iluminação",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.new(0.2, 0.2, 0.2)
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    end
})

-- FX3 simulado
Tab:AddButton({
    Name = "FX3 (Simulado)",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "FX3",
            Content = "Habilidade FX3 ativada!",
            Time = 3
        })
        print("FX3 ativada!")
    end
})

-- Teleporte
Tab:AddButton({
    Name = "Teletransportar",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(Vector3.new(0, 50, 0))
        end
    end
})

-- Anti AFK
Tab:AddButton({
    Name = "Ativar Anti AFK",
    Callback = function()
        local VirtualUser = game:service("VirtualUser")
        game:service("Players").LocalPlayer.Idled:connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)

        OrionLib:MakeNotification({
            Name = "Anti AFK",
            Content = "Anti AFK ativado com sucesso!",
            Time = 5
        })
    end
})

-- Resetar Status
Tab:AddButton({
    Name = "Resetar Status",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
        OrionLib:MakeNotification({
            Name = "Status Resetado",
            Content = "Velocidade e Pulo voltaram ao normal!",
            Time = 4
        })
    end
})

-- Fechar o hub
Tab:AddButton({
    Name = "Fechar Hub",
    Callback = function()
        OrionLib:Destroy()
    end
})

-- Segunda aba: Grow a Garden
local GardenTab = Window:MakeTab({
    Name = "Grow a garden",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

GardenTab:AddSection({ Name = "Scripts Externos" })

GardenTab:AddButton({
    Name = "Speed X hub",
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

-- Inicia o Hub
OrionLib:Init()
