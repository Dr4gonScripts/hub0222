local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Configuração da Janela Principal
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHubConfig",
    IntroEnabled = true,
    IntroText = "Dr4gonHub Premium",
    IntroIcon = "rbxassetid://0",
    Icon = "rbxassetid://0"
})

-- =============== UTILITÁRIOS ===============
local UtilityTab = Window:MakeTab({
    Name = "⚙️ Utilitários",
    Icon = "rbxassetid://0",
    PremiumOnly = false
})

-- Controles de Movimento
UtilityTab:AddSection({Name = "Controles de Movimento"})

local WS = UtilityTab:AddSlider({
    Name = "Velocidade (WalkSpeed)",
    Min = 16,
    Max = 200,
    Default = 16,
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    ValueName = "velocidade",
    Callback = function(Value)
        pcall(function()
            Player.Character.Humanoid.WalkSpeed = Value
        end)
    end    
})

local JP = UtilityTab:AddSlider({
    Name = "Pulo (JumpPower)",
    Min = 50,
    Max = 200,
    Default = 50,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "força",
    Callback = function(Value)
        pcall(function()
            Player.Character.Humanoid.JumpPower = Value
        end)
    end    
})

-- Sistema de Voo
local flying = false
local bp, bg
UtilityTab:AddToggle({
    Name = "Voo (Tecla F)",
    Default = false,
    Callback = function(Value)
        flying = Value
        if flying then
            local char = Player.Character or Player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            
            bp = Instance.new("BodyPosition", hrp)
            bp.D = 1000
            bp.MaxForce = Vector3.new(100000, 100000, 100000)
            bp.Position = hrp.Position

            bg = Instance.new("BodyGyro", hrp)
            bg.D = 1000
            bg.MaxTorque = Vector3.new(100000, 100000, 100000)
            bg.CFrame = hrp.CFrame
            
            local speed = 50
            game:GetService("RunService").Heartbeat:Connect(function()
                if not flying then return end
                bp.Position = bp.Position + (workspace.CurrentCamera.CFrame.LookVector * speed * 0.1)
                bg.CFrame = workspace.CurrentCamera.CFrame
            end)
        else
            if bp then bp:Destroy() end
            if bg then bg:Destroy() end
        end
    end
})

-- Anti-AFK
UtilityTab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
})

-- =============== BLOX FRUITS ===============
local BloxTab = Window:MakeTab({
    Name = "🍩 Blox Fruits",
    Icon = "rbxassetid://0",
    PremiumOnly = false
})

-- Auto Farm
BloxTab:AddSection({Name = "Auto Farm"})
BloxTab:AddToggle({
    Name = "Auto Farm Nível",
    Default = false,
    Callback = function(Value)
        getgenv().autofarm = Value
        while autofarm do
            -- Implementação do auto farm
            wait(0.1)
        end
    end
})

-- Teleportes
BloxTab:AddSection({Name = "Teleportes"})
BloxTab:AddDropdown({
    Name = "Ilhas",
    Options = {"Primeira", "Segunda", "Terceira"},
    Default = "Primeira",
    Callback = function(Value)
        -- Implementação de teleporte
    end    
})

-- =============== BROOKHAVEN ===============
local BrookhavenTab = Window:MakeTab({
    Name = "🏠 Brookhaven",
    Icon = "rbxassetid://0",
    PremiumOnly = false
})

-- Dinheiro
BrookhavenTab:AddSection({Name = "Dinheiro"})
BrookhavenTab:AddButton({
    Name = "Obter $1,000,000",
    Callback = function()
        -- Implementação de money hack
    end
})

-- =============== DOORS ===============
local DoorsTab = Window:MakeTab({
    Name = "🚪 Doors",
    Icon = "rbxassetid://0",
    PremiumOnly = false
})

-- Helpers
DoorsTab:AddSection({Name = "Helpers"})
DoorsTab:AddToggle({
    Name = "God Mode",
    Default = false,
    Callback = function(Value)
        -- Implementação de god mode
    end
})

-- =============== ARSENAL ===============
local ArsenalTab = Window:MakeTab({
    Name = "🔫 Arsenal",
    Icon = "rbxassetid://0",
    PremiumOnly = false
})

-- Aimbot
ArsenalTab:AddSection({Name = "Aimbot"})
ArsenalTab:AddToggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(Value)
        -- Implementação de silent aim
    end
})

-- =============== ADOPT ME ===============
local AdoptMeTab = Window:MakeTab({
    Name = "🐶 Adopt Me",
    Icon = "rbxassetid://0",
    PremiumOnly = false
})

-- Auto Farms
AdoptMeTab:AddSection({Name = "Auto Farms"})
AdoptMeTab:AddToggle({
    Name = "Auto Coletar Dinheiro",
    Default = false,
    Callback = function(Value)
        -- Implementação de auto money
    end
})

-- Inicializar UI
OrionLib:Init()

-- Atualizar WalkSpeed/JumpPower quando o personagem spawnar
Player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    WS:Set(Player.Character.Humanoid.WalkSpeed)
    JP:Set(Player.Character.Humanoid.JumpPower)
end)
