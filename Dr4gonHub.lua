local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/UltraStuff/scripts2/main/orionfixed.lua"))()

local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHubConfig",
    IntroEnabled = false
})

local player = game.Players.LocalPlayer

-- Tab: Misc
local miscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

miscTab:AddSection({ Name = "Section" })

-- Botões
miscTab:AddButton({
    Name = "Speed",
    Callback = function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 100
        end
    end
})

miscTab:AddButton({
    Name = "Jump",
    Callback = function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 100
        end
    end
})

miscTab:AddButton({
    Name = "Ajustar Iluminação",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    end
})

miscTab:AddButton({
    Name = "FX3",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.Name = "FX3 Tool"
        tool.RequiresHandle = false
        tool.Parent = player.Backpack

        local scriptFx = Instance.new("LocalScript")
        scriptFx.Source = [[
            local tool = script.Parent
            tool.Activated:Connect(function()
                print("FX3 ativada!")
                -- ação da FX3 aqui
            end)
        ]]
        scriptFx.Parent = tool
    end
})

miscTab:AddButton({
    Name = "Teletransportar",
    Callback = function()
        local dest = Vector3.new(0, 50, 0)
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(dest)
        end
    end
})

miscTab:AddButton({
    Name = "Resetar Status",
    Callback = function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
            char.Humanoid.JumpPower = 50
        end
    end
})

miscTab:AddButton({
    Name = "Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK Ativado",
            Content = "Você não será desconectado por inatividade.",
            Time = 5
        })
    end
})

-- Tab: Grow a garden
local gardenTab = Window:MakeTab({
    Name = "Grow a garden",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

gardenTab:AddSection({ Name = "Seção Grow a Garden" })

gardenTab:AddButton({
    Name = "Speed X hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
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
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Inicializar
OrionLib:Init()
