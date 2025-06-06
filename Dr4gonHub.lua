-- Garantir que OrionLib seja carregada corretamente
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

-- Obter o jogador
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Criar janela
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "Dr4gonHub"
})

-- Tab: Misc
local miscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

miscTab:AddSection({Name = "Funções Diversas"})

-- Botão: Speed
miscTab:AddButton({
    Name = "Speed (150)",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 150
        end
    end
})

-- Botão: JumpPower
miscTab:AddButton({
    Name = "JumpPower (100)",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = 100
        end
    end
})

-- Botão: Iluminação
miscTab:AddButton({
    Name = "Ajustar Iluminação",
    Callback = function()
        local lighting = game:GetService("Lighting")
        lighting.Brightness = 2
        lighting.OutdoorAmbient = Color3.new(0.4, 0.4, 0.4)
        lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    end
})

-- Botão: FX3 Simulado
miscTab:AddButton({
    Name = "FX3 (simulado)",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.Name = "FX3 Tool"
        tool.RequiresHandle = false
        tool.CanBeDropped = false

        local scriptFX = Instance.new("LocalScript")
        scriptFX.Source = [[
            local tool = script.Parent
            tool.Activated:Connect(function()
                print("FX3 ativada!")
            end)
        ]]
        scriptFX.Parent = tool
        tool.Parent = player.Backpack
    end
})

-- Botão: Teleporte
miscTab:AddButton({
    Name = "Teletransportar",
    Callback = function()
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(0, 50, 0)
        end
    end
})

-- Botão: Resetar Status
miscTab:AddButton({
    Name = "Resetar Status",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
})

-- Anti-AFK
miscTab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK",
            Content = "Ativado com sucesso!",
            Time = 5
        })
    end
})

-- Tab: Grow a Garden
local gardenTab = Window:MakeTab({
    Name = "Grow a garden",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

gardenTab:AddSection({Name = "Scripts Externos"})

gardenTab:AddButton({
    Name = "Speed X Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
    end
})

gardenTab:AddButton({
    Name = "Seed Spawner",
    Callback = function()
        loadstring(game:HttpGet("https://codeberg.org/twentys2/Scripts/raw/branch/main/Grow-A-Garden"))()
    end
})

-- Notificação de Boas-Vindas
OrionLib:MakeNotification({
    Name = "Dr4gonHub",
    Content = "Bem-vindo ao Dr4gonHub!",
    Time = 5
})

-- Inicializar interface
OrionLib:Init()
