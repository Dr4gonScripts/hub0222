--[[
  █▀▀ █▀█ █▀▀ ▀█▀ █▀▀ █▀█ █▀▄ █▀▀
  █▄▄ █▄█ █▄▄ ░█░ ██▄ █▀▄ █▄▀ ██▄
  Dr4gonHub Premium - Edição Oriental
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Configuração do Tema Oriental
local Theme = {
    Colors = {
        Primary = Color3.fromRGB(188, 10, 28),   -- Vermelho chinês
        Secondary = Color3.fromRGB(255, 212, 96) -- Dourado
    },
    Symbols = {
        Dragon = "🐉",
        Lantern = "🏮",
        Sword = "⚔️",
        YinYang = "☯"
    }
}

-- Janela Principal
local Window = OrionLib:MakeWindow({
    Name = "龍王 Hub",  -- "Rei Dragão" em chinês
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHubConfig",
    IntroEnabled = true,
    IntroText = "歡迎使用",  -- "Bem-vindo" em chinês
    IntroIcon = "rbxassetid://14204253922"  -- ID de imagem de dragão
})

-- =============== UTILITÁRIOS ===============
local UtilityTab = Window:MakeTab({
    Name = Theme.Symbols.Sword .. " Utilitários",
    Icon = "rbxassetid://0"
})

-- Seção de Movimento
UtilityTab:AddSection({Name = Theme.Symbols.YinYang .. " Controles"})

UtilityTab:AddSlider({
    Name = "WalkSpeed 速度",  -- "速度" = velocidade
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Theme.Colors.Primary,
    Callback = function(Value)
        pcall(function()
            Player.Character.Humanoid.WalkSpeed = Value
        end)
    end
})

UtilityTab:AddSlider({
    Name = "JumpPower 跳躍",  -- "跳躍" = pulo
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Theme.Colors.Secondary,
    Callback = function(Value)
        pcall(function()
            Player.Character.Humanoid.JumpPower = Value
        end)
    end
})

-- Sistema de Voo
UtilityTab:AddToggle({
    Name = "Fly 飛行 (F)",  -- "飛行" = voar
    Default = false,
    Callback = function(Value)
        -- Implementação do fly
    end
})

-- Teleporte
UtilityTab:AddButton({
    Name = "TP 傳送 (T)",  -- "傳送" = teleporte
    Callback = function()
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.T then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end)
    end
})

-- Iluminação
UtilityTab:AddToggle({
    Name = "Light 光",  -- "光" = luz
    Default = false,
    Callback = function(Value)
        -- Implementação da luz
    end
})

-- Noclip
UtilityTab:AddToggle({
    Name = "Noclip 穿透",  -- "穿透" = atravessar
    Default = false,
    Callback = function(Value)
        -- Implementação do noclip
    end
})

-- Anti-AFK
UtilityTab:AddButton({
    Name = "Anti-AFK 反閒置",  -- "反閒置" = anti-ocioso
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
})

OrionLib:Init()

-- Mensagem no console
print([[

  龍王 Hub 已激活  - 龍王 = "Rei Dragão"
  ▄︻デ══━💥 ヾ(⌐■_■)ノ♪
]])
