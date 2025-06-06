-- Carregar OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

-- Criar janela principal
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHub"
})

-- Criar aba 'Misc'
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Adicionar seção
MiscTab:AddSection({
    Name = "Funções Diversas"
})

-- Botão de velocidade
MiscTab:AddButton({
    Name = "Aumentar Velocidade",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
})

-- Botão de pulo
MiscTab:AddButton({
    Name = "Aumentar Pulo",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
    end
})

-- Botão de resetar status
MiscTab:AddButton({
    Name = "Resetar Status",
    Callback = function()
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
})

-- Botão Anti-AFK
MiscTab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game.Players.LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
})

-- Inicializar a interface
OrionLib:Init()
