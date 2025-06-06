--[[
  🐉 Dr4gonHub Premium - Versão Aprimorada
  Recursos: Hitbox Expander, Aimbot, Fly, Teleport, Noclip
  Controles: Toggles visuais, teclas configuráveis
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
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ContentFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ContentFrame

-- ===== FUNÇÕES DE CONTROLE =====
local function CreateToggleButton(name, defaultState, callback)
    local button = Instance.new("TextButton")
    button.Text = name .. (defaultState and " [ON]" or " [OFF]")
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = defaultState and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = ContentFrame
    
    local state = defaultState
    
    button.MouseButton1Click:Connect(function()
        state = not state
        button.Text = name .. (state and " [ON]" or " [OFF]")
        button.BackgroundColor3 = state and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
        pcall(callback, state)
    end)
    
    return {
        SetState = function(newState)
            state = newState
            button.Text = name .. (state and " [ON]" or " [OFF]")
            button.BackgroundColor3 = state and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
        end,
        GetState = function()
            return state
        end
    }
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
local hitboxSize = 2
local hitboxTransparency = 0.5
local hitboxParts = {}

local hitboxSlider = CreateSlider("Hitbox Size (1-5)", 1, 5, 2, function(value)
    hitboxSize = value
    UpdateHitboxes()
end)

local transparencySlider = CreateSlider("Hitbox Transparency (0-1)", 0, 1, 0.5, function(value)
    hitboxTransparency = value
    UpdateHitboxes()
end)

local hitboxToggle = CreateToggleButton("Hitbox", false, function(state)
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

    if not hitboxToggle.GetState() then return end

    -- Criar novas hitboxes
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= Player and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local hitbox = Instance.new("BoxHandleAdornment")
                    hitbox.Size = part.Size * hitboxSize
                    hitbox.Transparency = hitboxTransparency
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

-- ===== AIMBOT =====
local aimbotFOV = 100
local aimbotTeamCheck = true

local aimbotFOVSlider = CreateSlider("Aimbot FOV (10-200)", 10, 200, 100, function(value)
    aimbotFOV = value
end)

local aimbotToggle = CreateToggleButton("Aimbot", false, function(state)
    -- O estado é armazenado automaticamente
end)

local teamCheckToggle = CreateToggleButton("Team Check", true, function(state)
    aimbotTeamCheck = state
end)

-- Função principal do aimbot
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotToggle.GetState() and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local closestPlayer = nil
        local closestDistance = aimbotFOV
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= Player and player.Character then
                if aimbotTeamCheck and Player.Team and player.Team and Player.Team == player.Team then
                    continue
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
local flySpeed = 50
local flySpeedSlider = CreateSlider("Fly Speed (1-100)", 1, 100, 50, function(value)
    flySpeed = value
end)

local flyToggle = CreateToggleButton("Fly (F)", false, function(state)
    if state then
        -- Ativar fly
        local torso = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if not torso then return end
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = torso.CFrame
        bodyGyro.Parent = torso
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.velocity = Vector3.new(0, 0, 0)
        bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = torso
        
        local flyConnection
        flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not flyToggle.GetState() or not Player.Character then
                flyConnection:Disconnect()
                return
            end
            
            local torso = Player.Character:FindFirstChild("HumanoidRootPart")
            if not torso then return end
            
            local c = workspace.CurrentCamera.CFrame
            local v = Vector3.new()
            
            local controls = {
                [Enum.KeyCode.W] = c.LookVector,
                [Enum.KeyCode.S] = -c.LookVector,
                [Enum.KeyCode.A] = -c.RightVector,
                [Enum.KeyCode.D] = c.RightVector,
                [Enum.KeyCode.Space] = Vector3.new(0, 1, 0),
                [Enum.KeyCode.LeftShift] = Vector3.new(0, -1, 0)
            }
            
            for key, direction in pairs(controls) do
                if game:GetService("UserInputService"):IsKeyDown(key) then
                    v = v + direction * flySpeed
                end
            end
            
            torso.Velocity = v
            if bodyGyro then
                bodyGyro.cframe = workspace.CurrentCamera.CFrame
            end
        end)
    else
        -- Desativar fly
        if Player.Character then
            local torso = Player.Character:FindFirstChild("HumanoidRootPart")
            if torso then
                for _, v in pairs(torso:GetChildren()) do
                    if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                        v:Destroy()
                    end
                end
            end
        end
    end
end)

-- Teleport
local teleportToggle = CreateToggleButton("Teleport (T/Click)", false, function(state)
    -- O estado é armazenado automaticamente
end)

local teleportConnection
teleportConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if teleportToggle.GetState() and (input.KeyCode == Enum.KeyCode.T or input.UserInputType == Enum.UserInputType.MouseButton1) then
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPos
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                -- Teleportar para onde o mouse clicou
                local ray = workspace:ScreenPointToRay(Mouse.X, Mouse.Y)
                local part, position = workspace:FindPartOnRay(ray, Player.Character)
                targetPos = position
            else
                -- Teleportar para onde o mouse está apontando
                targetPos = Mouse.Hit.Position
            end
            
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
        end
    end
end)

-- Noclip
local noclipToggle = CreateToggleButton("Noclip", false, function(state)
    if Player.Character then
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
            end
        end
    end
    
    if state then
        local noclipConnection
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if not noclipToggle.GetState() then
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
local antiAfkToggle = CreateToggleButton("Anti-AFK", false, function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

-- Atualizar ao respawn
Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    task.wait(0.5)
    
    -- Restaurar configurações
    walkSpeedSlider.SetValue(walkSpeed)
    jumpPowerSlider.SetValue(jumpPower)
    
    -- Restaurar estados
    if flyToggle.GetState() then
        flyToggle.SetState(false)
        flyToggle.SetState(true)
    end
    
    if noclipToggle.GetState() then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("🐉 Dr4gonHub Premium - Versão Aprimorada carregada com sucesso!")
