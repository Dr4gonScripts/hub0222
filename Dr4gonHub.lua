--[[
  Dr4gonHub Premium - Versão Estável
  Compatível com Xeno Executor
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO SEGURA DA UI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.25, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "DR4GONHUB"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- ===== FUNÇÕES DE CONTROLE =====
local function CreateButton(name, callback)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = MainFrame
    
    button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

local function CreateSlider(name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0.9, 0, 0, 60)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = MainFrame
    
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(1, 0, 0, 20)
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Text = tostring(default)
    textBox.Size = UDim2.new(1, 0, 0, 30)
    textBox.Position = UDim2.new(0, 0, 0, 25)
    textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.Parent = sliderFrame
    
    local function updateValue(value)
        local num = tonumber(value) or default
        num = math.clamp(num, min, max)
        textBox.Text = tostring(num)
        pcall(callback, num)
    end
    
    textBox.FocusLost:Connect(function()
        updateValue(textBox.Text)
    end)
    
    return {
        SetValue = function(value)
            updateValue(value)
        end
    }
end

-- ===== CONTROLES DE MOVIMENTO =====
local walkSpeed = 16
local walkSpeedSlider = CreateSlider("WalkSpeed (0-500)", 0, 500, 16, function(value)
    walkSpeed = value
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = value
    end
end)

local jumpPower = 50
local jumpPowerSlider = CreateSlider("JumpPower (0-500)", 0, 500, 50, function(value)
    jumpPower = value
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.JumpPower = value
    end
end)

-- ===== SISTEMA DE VOO =====
local flying = false
local flyBodyVelocity

CreateButton("Fly (Toggle - F)", function()
    flying = not flying
    
    if flying then
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.MaxForce = Vector3.new(0, 9e9, 0)
        flyBodyVelocity.Parent = Player.Character:WaitForChild("HumanoidRootPart")
        
        local flyConnection
        flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not flying or not Player.Character then
                flyConnection:Disconnect()
                return
            end
            
            local root = Player.Character.HumanoidRootPart
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                root.CFrame = root.CFrame * CFrame.new(0, 1, 0)
            elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                root.CFrame = root.CFrame * CFrame.new(0, -1, 0)
            end
        end)
    elseif flyBodyVelocity then
        flyBodyVelocity:Destroy()
    end
end)

-- ===== TELEPORTE =====
CreateButton("TP to Mouse (T)", function()
    local inputConn
    inputConn = game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.T then
            pcall(function()
                Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
            end)
        end
    end)
end)

-- ===== NOCLIP =====
local noclip = false
CreateButton("Noclip (Toggle)", function()
    noclip = not noclip
    
    if noclip then
        local noclipConn
        noclipConn = game:GetService("RunService").Stepped:Connect(function()
            if not noclip or not Player.Character then
                noclipConn:Disconnect()
                return
            end
            
            for _, part in pairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

-- ===== ANTI-AFK =====
CreateButton("Anti-AFK", function()
    local vu = game:GetService("VirtualUser")
    Player.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end)

-- ===== ATUALIZAÇÃO AO RESPAWN =====
Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    task.wait(0.5)
    walkSpeedSlider.SetValue(walkSpeed)
    jumpPowerSlider.SetValue(jumpPower)
end)

print("Dr4gonHub carregado com sucesso!")
