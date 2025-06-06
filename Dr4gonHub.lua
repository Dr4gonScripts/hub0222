local player = game.Players.LocalPlayer

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest"
})

local Tab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({ Name = "Section" })

OrionLib:MakeNotification({
    Name = "Inicializando...",
    Content = "Bem vindo ao Dr4gonHub!!!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Botão de velocidade
Tab:AddButton({
    Name = "Speed",
    Callback = function()
        local character = player.Character or player.CharacterAdded:Wait()
        character:WaitForChild("Humanoid").WalkSpeed = 500
    end
})

-- Botão de pulo
Tab:AddButton({
    Name = "Jump",
    Callback = function()
        local character = player.Character or player.CharacterAdded:Wait()
        character:WaitForChild("Humanoid").JumpPower = 50
    end
})

-- Ajuste de iluminação
Tab:AddButton({
    Name = "Ajustar Iluminação",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 1.5
        Lighting.OutdoorAmbient = Color3.new(0.2, 0.2, 0.2)
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    end
})

-- Função FX3
local function giveFX3ToPlayer(player)
    local playerData = Instance.new("BoolValue")
    playerData.Name = "HasFX3"
    playerData.Parent = player

    local tool = Instance.new("Tool")
    tool.Name = "FX3 Tool"
    tool.RequiresHandle = false
    tool.Parent = player.Backpack

    local toolScript = Instance.new("LocalScript")
    toolScript.Source = [[
        local tool = script.Parent
        local player = game.Players.LocalPlayer

        tool.Activated:Connect(function()
            print("FX3 ativada!")
            -- Coloque aqui o efeito da habilidade
        end)
    ]]
    toolScript.Parent = tool
end

-- Botão FX3
Tab:AddButton({
    Name = "FX3",
    Callback = function()
        giveFX3ToPlayer(player)
    end
})

-- Função de teleporte
local function teleportPlayer(player, position)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(position)
    else
        warn("HumanoidRootPart não encontrado")
    end
end

local destinationPosition = Vector3.new(0, 50, 0)

-- Botão de teleporte
Tab:AddButton({
    Name = "Teletransportar",
    Callback = function()
        teleportPlayer(player, destinationPosition)
    end
})

-- Tab do jogo Grow a Garden
local Tab2 = Window:MakeTab({
    Name = "Grow a garden",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab2:AddSection({ Name = "Section" })

-- Botão Speed X hub
Tab2:AddButton({
    Name = "Speed X hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
    end
})

-- Botão Seed Spawner
Tab2:AddButton({
    Name = "Seed Spawner",
    Callback = function()
        loadstring(game:HttpGet("https://codeberg.org/twentys2/Scripts/raw/branch/main/Grow-A-Garden"))()
    end
})

-- Inicializar a UI
OrionLib:Init()
