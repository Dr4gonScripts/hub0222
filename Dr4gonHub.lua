--[[
  Dr4gonHub Premium - Versão Estável
  Funções: Fly, TP, Speed, Jump, Noclip, Anti-AFK
]]

-- ========== CONFIGURAÇÃO INICIAL ==========
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- Carregamento seguro da biblioteca
local OrionLib
local function LoadLibrary()
    local urls = {
        "https://raw.githubusercontent.com/shlexware/Orion/main/source",
        "https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"
    }
    
    for _, url in ipairs(urls) do
        local success, lib = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if success then
            return lib
        end
    end
    return nil
end

OrionLib = LoadLibrary()
if not OrionLib then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Erro",
        Text = "Falha ao carregar a biblioteca",
        Duration = 10
    })
    return
end

-- ========== INTERFACE PRINCIPAL ==========
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHubConfig",
    IntroEnabled = true,
    IntroText = "Dr4gonHub Carregado",
    Icon = "rbxassetid://0"
})

-- ========== FUNÇÕES PRINCIPAIS ==========
local UtilityTab = Window:MakeTab({
    Name = "Utilitários",
    Icon = "rbxassetid://0"
})

-- Seção de Movimento
UtilityTab:AddSection({Name = "Movimento"})

-- Controle de Velocidade
UtilityTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 16,
    Callback = function(Value)
        pcall(function()
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = Value
            end
        end)
    end
})

-- Controle de Pulo
UtilityTab:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 500,
    Default = 50,
    Callback = function(Value)
        pcall(function()
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = Value
            end
        end)
    end
})

-- Sistema de Voo
local flyEnabled = false
local flyConn
UtilityTab:AddToggle({
    Name = "Fly (Tecla F)",
    Default = false,
    Callback = function(Value)
        flyEnabled = Value
        if flyEnabled then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = Player.Character:WaitForChild("HumanoidRootPart")
            
            flyConn = game:GetService("RunService").Heartbeat:Connect(function()
                if not flyEnabled or not Player.Character then
                    if flyConn then flyConn:Disconnect() end
                    return
                end
                
                local root = Player.Character.HumanoidRootPart
                local cam = workspace.CurrentCamera.CFrame
                
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                    root.CFrame = root.CFrame + cam.LookVector
                elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                    root.CFrame = root.CFrame - cam.LookVector
                end
                
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                    root.CFrame = root.CFrame * CFrame.new(0, 1, 0)
                elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                    root.CFrame = root.CFrame * CFrame.new(0, -1, 0)
                end
            end)
        elseif flyConn then
            flyConn:Disconnect()
            for _, v in pairs(Player.Character.HumanoidRootPart:GetChildren()) do
                if v:IsA("BodyVelocity") then
                    v:Destroy()
                end
            end
        end
    end
})

-- Teleporte por Clique
UtilityTab:AddButton({
    Name = "TP to Mouse (Tecla T)",
    Callback = function()
        local conn
        conn = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == Enum.KeyCode.T then
                pcall(function()
                    Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
                end)
            end
        end)
    end
})

-- Noclip
local noclipEnabled = false
local noclipConn
UtilityTab:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(Value)
        noclipEnabled = Value
        if noclipEnabled then
            noclipConn = game:GetService("RunService").Stepped:Connect(function()
                if not Player.Character then return end
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        elseif noclipConn then
            noclipConn:Disconnect()
        end
    end
})

-- Anti-AFK
UtilityTab:AddButton({
    Name = "Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
})

-- ========== INICIALIZAÇÃO ==========
OrionLib:Init()

-- Atualizar ao respawnar
Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    -- Reaplicar configurações se necessário
end)

print("Dr4gonHub Iniciado com Sucesso!")
