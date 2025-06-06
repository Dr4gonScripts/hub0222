--[[
  🐉 Dr4gonHub Premium - Versão Retangular Aprimorada
  Recursos: Hitbox Expander com transparência ajustável, Aimbot, Controles de Janela
  Formato: Retangular | Estável | Xeno Executor
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DA UI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.25, 0, 0.35, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(188, 10, 28)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "DR4GONHUB PREMIUM"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.15, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Parent = TitleBar

-- Botões de controle da janela
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "_"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TitleBar

-- Área de conteúdo
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 5
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 650) -- Ajustado para mais conteúdo
ContentFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ContentFrame

-- ===== FUNÇÕES DE CONTROLE =====
local function CreateButton(name, callback)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = ContentFrame
    
    button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    
    return button
end

local function CreateSlider(name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0.9, 0, 0, 60)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = ContentFrame
    
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
    textBox.TextColor3 = Color3.new(1, 1, 1)
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

-- ===== CONTROLES DE JANELA =====
local minimized = false
local originalSize = MainFrame.Size

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0.25, 0, 0, 30)
        ContentFrame.Visible = false
    else
        MainFrame.Size = originalSize
        ContentFrame.Visible = true
    end
end)

-- ===== HITBOX EXPANDER =====
local hitboxEnabled = false
local hitboxSize = 2
local hitboxTransparency = 0.5 -- Novo: Controle de transparência
local hitboxParts = {}

local hitboxSlider = CreateSlider("Hitbox Size (1-5)", 1, 5, 2, function(value)
    hitboxSize = value
    UpdateHitboxes()
end)

-- Novo: Slider para transparência da hitbox
local transparencySlider = CreateSlider("Hitbox Transparency (0-1)", 0, 1, 0.5, function(value)
    hitboxTransparency = value
    UpdateHitboxes()
end)

local function UpdateHitboxes()
    -- Limpar hitboxes antigas
    for _, part in pairs(hitboxParts) do
        if part:IsA("BasePart") then
            part:Destroy()
        end
    end
    hitboxParts = {}

    if not hitboxEnabled then return end

    -- Criar novas hitboxes
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= Player and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local hitbox = Instance.new("BoxHandleAdornment")
                    hitbox.Size = part.Size * hitboxSize
                    hitbox.Transparency = hitboxTransparency -- Usando a variável de transparência
                    hitbox.Color3 = Color3.fromRGB(255, 0, 0)
                    hitbox.Adornee = part
                    hitbox.AlwaysOnTop = true
                    hitbox.ZIndex = 10
                    hitbox.Parent = part
                    table.insert(hitboxParts, hitbox)
                end
            end
        end
    end
end

CreateButton("Toggle Hitbox", function()
    hitboxEnabled = not hitboxEnabled
    UpdateHitboxes()
end)

-- ===== AIMBOT =====
local aimbotEnabled = false
local aimbotFOV = 100
local aimbotTeamCheck = true

local aimbotFOVSlider = CreateSlider("Aimbot FOV (10-200)", 10, 200, 100, function(value)
    aimbotFOV = value
end)

CreateButton("Toggle Aimbot", function()
    aimbotEnabled = not aimbotEnabled
end)

CreateButton("Toggle Team Check", function()
    aimbotTeamCheck = not aimbotTeamCheck
end)

-- Função principal do aimbot
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local closestPlayer = nil
        local closestDistance = aimbotFOV
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= Player and player.Character then
                -- Verificação de time
                if aimbotTeamCheck then
                    if Player.Team and player.Team and Player.Team == player.Team then
                        continue
                    end
                end
                
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local screenPoint = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
                    local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
        
        if closestPlayer and closestPlayer.Character then
            local target = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if target then
                workspace.CurrentCamera.CFrame = CFrame.lookAt(
                    workspace.CurrentCamera.CFrame.Position,
                    target.Position
                )
            end
        end
    end
end)

-- ===== FUNÇÕES BÁSICAS =====
-- WalkSpeed
local walkSpeed = 16
local walkSpeedSlider = CreateSlider("WalkSpeed (0-500)", 0, 500, 16, function(value)
    walkSpeed = value
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = value
    end
end)

-- JumpPower
local jumpPower = 50
local jumpPowerSlider = CreateSlider("JumpPower (0-500)", 0, 500, 50, function(value)
    jumpPower = value
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.JumpPower = value
    end
end)

-- Fly
local flying = false
local flySpeed = 50
local flySpeedSlider = CreateSlider("Fly Speed (1-100)", 1, 100, 50, function(value)
    flySpeed = value
end)

CreateButton("Fly (Toggle - F)", function()
    flying = not flying
    local torso = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not torso then return end
    
    if flying then
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = torso.CFrame
        bodyGyro.Parent = torso
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.velocity = Vector3.new(0, 0, 0)
        bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = torso
        
        local function fly()
            if not flying or not Player.Character then return end
            
            local c = workspace.CurrentCamera.CFrame
            local v = Vector3.new()
            
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                v = v + c.LookVector * flySpeed
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                v = v - c.LookVector * flySpeed
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                v = v - c.RightVector * flySpeed
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                v = v + c.RightVector * flySpeed
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                v = v + Vector3.new(0, flySpeed, 0)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                v = v - Vector3.new(0, flySpeed, 0)
            end
            
            torso.Velocity = v
            bodyGyro.cframe = workspace.CurrentCamera.CFrame
        end
        
        game:GetService("RunService").Heartbeat:Connect(fly)
    else
        for _, v in pairs(torso:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                v:Destroy()
            end
        end
    end
end)

-- Teleport
CreateButton("TP to Mouse (T)", function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
    end
end)

-- Noclip
local noclip = false
CreateButton("Noclip (Toggle)", function()
    noclip = not noclip
    
    if Player.Character then
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclip
            end
        end
    end
    
    if noclip then
        local noclipConnection
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if not noclip then
                noclipConnection:Disconnect()
                return
            end
            
            if Player.Character then
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- Anti-AFK
CreateButton("Anti-AFK", function()
    local vu = game:GetService("VirtualUser")
    Player.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Atualizar ao respawn
Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    task.wait(0.5)
    walkSpeedSlider.SetValue(walkSpeed)
    jumpPowerSlider.SetValue(jumpPower)
    
    -- Restaurar noclip se estiver ativado
    if noclip then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("🐉 Dr4gonHub Premium - Versão Aprimorada carregada com sucesso!")
