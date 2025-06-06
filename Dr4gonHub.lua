--[[
  🐉 Dr4gonHub Premium - Edição Completa
  Jogos: Blox Fruits, Blue Lock Rivals, Grow a Garden, Arsenal
  MISC: Aimbot, Hitbox Expander, Speed, Jump, Fly, NoClip, Teleport
]]

-- Serviços
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Configuração do Tema
local Theme = {
    Colors = {
        Main = Color3.fromRGB(25, 25, 35),
        Header = Color3.fromRGB(188, 10, 28), -- Vermelho Dr4gon
        TabActive = Color3.fromRGB(45, 45, 60),
        TabInactive = Color3.fromRGB(35, 35, 50),
        Text = Color3.fromRGB(240, 240, 240),
        Button = Color3.fromRGB(45, 50, 65),
        ButtonHover = Color3.fromRGB(55, 60, 75),
        Accent = Color3.fromRGB(255, 212, 96), -- Dourado
        Close = Color3.fromRGB(255, 80, 80),
        Minimize = Color3.fromRGB(255, 180, 80)
    }
}

-- Criação da Interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.65, 0)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.BackgroundColor3 = Theme.Colors.Main
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Cabeçalho
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Theme.Colors.Header
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "DR4GONHUB PREMIUM"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.15, 0, 0, 0)
Title.TextColor3 = Theme.Colors.Text
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 14
Title.Parent = Header

-- Botões de Controle
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Theme.Colors.Close
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = Header

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundColor3 = Theme.Colors.Minimize
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = Header

-- Barra de Abas
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, 0, 0, 40)
TabContainer.Position = UDim2.new(0, 0, 0, 30)
TabContainer.BackgroundColor3 = Theme.Colors.Main
TabContainer.Parent = MainFrame

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 2)
TabList.Parent = TabContainer

-- Área de Conteúdo
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -10, 1, -80)
ContentFrame.Position = UDim2.new(0, 5, 0, 75)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 8
ContentFrame.ScrollBarImageColor3 = Theme.Colors.Accent
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.Parent = ContentFrame

-- Sistema de Movimento da Janela
local dragging, dragInput, dragStart, startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- Sistema de Abas
local tabs = {}
local currentTab = nil

local function CreateTab(tabName)
    local tabButton = Instance.new("TextButton")
    tabButton.Text = tabName
    tabButton.Size = UDim2.new(0.2, 0, 1, 0)
    tabButton.BackgroundColor3 = Theme.Colors.TabInactive
    tabButton.TextColor3 = Theme.Colors.Text
    tabButton.Font = Enum.Font.GothamMedium
    tabButton.TextSize = 13
    tabButton.Parent = TabContainer
    
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 0, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.AutomaticSize = Enum.AutomaticSize.Y
    tabContent.Visible = false
    tabContent.Parent = ContentFrame
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 10)
    tabLayout.Parent = tabContent
    
    local tab = {
        button = tabButton,
        content = tabContent,
        Show = function()
            if currentTab then
                currentTab.content.Visible = false
                currentTab.button.BackgroundColor3 = Theme.Colors.TabInactive
            end
            currentTab = tab
            tab.content.Visible = true
            tab.button.BackgroundColor3 = Theme.Colors.TabActive
            ContentFrame.CanvasPosition = Vector2.new(0, 0)
        end
    }
    
    tabButton.MouseButton1Click:Connect(tab.Show)
    table.insert(tabs, tab)
    return tab
end

-- Função para criar botões
local function CreateButton(parent, text, description, callback)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, -10, 0, 60)
    buttonFrame.BackgroundColor3 = Theme.Colors.Button
    buttonFrame.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(1, 0, 0.6, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.BackgroundTransparency = 1
    button.TextColor3 = Theme.Colors.Text
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = buttonFrame
    
    local desc = Instance.new("TextLabel")
    desc.Text = description
    desc.Size = UDim2.new(1, -10, 0.4, 0)
    desc.Position = UDim2.new(0, 10, 0.6, 0)
    desc.TextColor3 = Color3.fromRGB(180, 180, 180)
    desc.BackgroundTransparency = 1
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = buttonFrame
    
    button.MouseEnter:Connect(function()
        buttonFrame.BackgroundColor3 = Theme.Colors.ButtonHover
    end)
    
    button.MouseLeave:Connect(function()
        buttonFrame.BackgroundColor3 = Theme.Colors.Button
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    return buttonFrame
end

-- Função para criar slider
local function CreateSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 70)
    frame.BackgroundColor3 = Theme.Colors.Button
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.TextColor3 = Theme.Colors.Text
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.9, 0, 0, 15)
    slider.Position = UDim2.new(0.05, 0, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    slider.Parent = frame
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.Colors.Accent
    fill.Parent = slider
    
    local value = Instance.new("TextLabel")
    value.Text = tostring(default)
    value.Size = UDim2.new(0.2, 0, 0.4, 0)
    value.Position = UDim2.new(0.8, 0, 0.6, 0)
    value.TextColor3 = Theme.Colors.Text
    value.BackgroundTransparency = 1
    value.Font = Enum.Font.Gotham
    value.TextSize = 12
    value.Parent = frame
    
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local connection
            connection = RunService.RenderStepped:Connect(function()
                local pos = UserInputService:GetMouseLocation().X - slider.AbsolutePosition.X
                local ratio = math.clamp(pos / slider.AbsoluteSize.X, 0, 1)
                local val = min + (max - min) * ratio
                fill.Size = UDim2.new(ratio, 0, 1, 0)
                value.Text = string.format("%.1f", val)
                callback(val)
            end)
            
            local function disconnect()
                connection:Disconnect()
                slider.InputEnded:Disconnect(disconnect)
            end
            slider.InputEnded:Connect(disconnect)
        end
    end)
    
    return frame
end

-- ===== MISC FUNCTIONS =====
local MiscTab = CreateTab("MISC")

-- Aimbot
local aimbot = {
    Enabled = false,
    TeamCheck = true,
    Smoothness = 5,
    FOV = 100,
    Connection = nil
}

local function IsEnemy(player)
    if not aimbot.TeamCheck then return true end
    if LocalPlayer.Team and player.Team then
        return LocalPlayer.Team ~= player.Team
    end
    return player ~= LocalPlayer
end

local function FindClosestTarget()
    local closest = nil
    local closestDist = aimbot.FOV
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart and IsEnemy(player) then
                local screenPoint = workspace.CurrentCamera:WorldToViewportPoint(humanoidRootPart.Position)
                if screenPoint.Z > 0 then
                    local mousePos = UserInputService:GetMouseLocation()
                    local dist = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(mousePos.X, mousePos.Y)
                    dist = dist.Magnitude
                    
                    if dist < closestDist then
                        closestDist = dist
                        closest = humanoidRootPart
                    end
                end
            end
        end
    end
    
    return closest
end

local function AimbotFunction()
    if aimbot.Enabled then
        local target = FindClosestTarget()
        if target then
            local camera = workspace.CurrentCamera
            local current = camera.CFrame.Position
            local targetPos = target.Position + Vector3.new(0, 1.5, 0)
            local direction = (targetPos - current).Unit
            local smoothFactor = math.clamp(aimbot.Smoothness, 1, 10)
            local newLook = current + direction * (smoothFactor * 0.1)
            camera.CFrame = CFrame.lookAt(current, newLook)
        end
    end
end

CreateButton(MiscTab.content, "Toggle Aimbot", "Lock onto enemies", function()
    aimbot.Enabled = not aimbot.Enabled
    if aimbot.Enabled and not aimbot.Connection then
        aimbot.Connection = RunService.RenderStepped:Connect(AimbotFunction)
    elseif not aimbot.Enabled and aimbot.Connection then
        aimbot.Connection:Disconnect()
        aimbot.Connection = nil
    end
end)

CreateButton(MiscTab.content, "Toggle Team Check", "Ignore teammates", function()
    aimbot.TeamCheck = not aimbot.TeamCheck
end)

CreateSlider(MiscTab.content, "Aimbot Smoothness", 1, 10, 5, function(val)
    aimbot.Smoothness = val
end)

CreateSlider(MiscTab.content, "Aimbot FOV", 10, 200, 100, function(val)
    aimbot.FOV = val
end)

-- Hitbox Expander
local hitbox = {
    Enabled = false,
    Size = 2,
    Transparency = 0.5,
    Parts = {}
}

local function UpdateHitboxes()
    for _, part in ipairs(hitbox.Parts) do
        if part:IsA("BasePart") then
            part:Destroy()
        end
    end
    hitbox.Parts = {}

    if not hitbox.Enabled then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local hitboxPart = Instance.new("BoxHandleAdornment")
                    hitboxPart.Size = part.Size * hitbox.Size
                    hitboxPart.Transparency = hitbox.Transparency
                    hitboxPart.Color3 = Color3.new(1, 0, 0)
                    hitboxPart.Adornee = part
                    hitboxPart.AlwaysOnTop = true
                    hitboxPart.ZIndex = 10
                    hitboxPart.Parent = part
                    table.insert(hitbox.Parts, hitboxPart)
                end
            end
        end
    end
end

CreateButton(MiscTab.content, "Toggle Hitbox", "Expand enemy hitboxes", function()
    hitbox.Enabled = not hitbox.Enabled
    UpdateHitboxes()
end)

CreateSlider(MiscTab.content, "Hitbox Size", 1, 5, 2, function(val)
    hitbox.Size = val
    UpdateHitboxes()
end)

CreateSlider(MiscTab.content, "Hitbox Transparency", 0, 1, 0.5, function(val)
    hitbox.Transparency = val
    UpdateHitboxes()
end)

-- Speed Hack
local speedHack = {
    Enabled = false,
    Speed = 50
}

CreateButton(MiscTab.content, "Toggle Speed", "Increase movement speed", function()
    speedHack.Enabled = not speedHack.Enabled
    if speedHack.Enabled then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedHack.Speed
    else
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

CreateSlider(MiscTab.content, "Speed Value", 16, 150, 50, function(val)
    speedHack.Speed = val
    if speedHack.Enabled then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

-- Jump Hack
local jumpHack = {
    Enabled = false,
    Power = 50
}

CreateButton(MiscTab.content, "Toggle Jump", "Increase jump power", function()
    jumpHack.Enabled = not jumpHack.Enabled
    if jumpHack.Enabled then
        LocalPlayer.Character.Humanoid.JumpPower = jumpHack.Power
    else
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

CreateSlider(MiscTab.content, "Jump Power", 50, 250, 50, function(val)
    jumpHack.Power = val
    if jumpHack.Enabled then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

-- Fly Hack
local flyHack = {
    Enabled = false,
    Speed = 50,
    Connection = nil
}

local function Fly()
    if flyHack.Enabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            humanoid.PlatformStand = true
            
            local control = {F = 0, B = 0, L = 0, R = 0}
            local lastControl = {F = 0, B = 0, L = 0, R = 0}
            
            local maxSpeed = flyHack.Speed
            
            UserInputService.InputBegan:Connect(function(input, processed)
                if not processed then
                    if input.KeyCode == Enum.KeyCode.W then
                        control.F = 1
                    elseif input.KeyCode == Enum.KeyCode.S then
                        control.B = -1
                    elseif input.KeyCode == Enum.KeyCode.A then
                        control.L = -1
                    elseif input.KeyCode == Enum.KeyCode.D then
                        control.R = 1
                    end
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input, processed)
                if not processed then
                    if input.KeyCode == Enum.KeyCode.W then
                        control.F = 0
                    elseif input.KeyCode == Enum.KeyCode.S then
                        control.B = 0
                    elseif input.KeyCode == Enum.KeyCode.A then
                        control.L = 0
                    elseif input.KeyCode == Enum.KeyCode.D then
                        control.R = 0
                    end
                end
            end)
            
            local bg = Instance.new("BodyGyro")
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = rootPart.CFrame
            bg.Parent = rootPart
            
            local bv = Instance.new("BodyVelocity")
            bv.velocity = Vector3.new(0, 0, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Parent = rootPart
            
            while flyHack.Enabled and humanoid and rootPart do
                wait()
                
                local cam = workspace.CurrentCamera.CFrame
                local move = cam.LookVector * (control.F + control.B) + 
                             cam.RightVector * (control.L + control.R)
                
                move = move.Unit * maxSpeed
                
                if (control.F + control.B + control.L + control.R) > 0 then
                    bv.velocity = move
                else
                    bv.velocity = Vector3.new(0, 0, 0)
                end
                
                bg.cframe = cam
            end
            
            bg:Destroy()
            bv:Destroy()
            humanoid.PlatformStand = false
        end
    end
end

CreateButton(MiscTab.content, "Toggle Fly", "Press F to fly", function()
    flyHack.Enabled = not flyHack.Enabled
    if flyHack.Enabled then
        Fly()
    end
end)

CreateSlider(MiscTab.content, "Fly Speed", 20, 150, 50, function(val)
    flyHack.Speed = val
end)

-- NoClip
local noclip = {
    Enabled = false,
    Connection = nil
}

local function NoclipLoop()
    if noclip.Enabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

CreateButton(MiscTab.content, "Toggle NoClip", "Walk through walls", function()
    noclip.Enabled = not noclip.Enabled
    if noclip.Enabled and not noclip.Connection then
        noclip.Connection = RunService.Stepped:Connect(NoclipLoop)
    elseif not noclip.Enabled and noclip.Connection then
        noclip.Connection:Disconnect()
        noclip.Connection = nil
    end
end)

-- Teleport
CreateButton(MiscTab.content, "Teleport to Mouse", "Click to teleport", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local ray = workspace:Raycast(
            workspace.CurrentCamera.CFrame.Position,
            Mouse.UnitRay.Direction * 1000,
            {workspace.Terrain, unpack(workspace:GetParts())}
        )
        
        if ray then
            LocalPlayer.Character:MoveTo(ray.Position)
        end
    end
end)

-- ===== GAME TABS =====
-- Blox Fruits
local BloxTab = CreateTab("BLOX FRUITS")
CreateButton(BloxTab.content, "Auto Farm Level", "Farm automatically", function()
    -- Implementação do auto farm
end)

CreateButton(BloxTab.content, "Teleport to Fruits", "Find and teleport to fruits", function()
    -- Implementação do teleporte para frutas
end)

-- Blue Lock Rivals
local BlueLockTab = CreateTab("BLUE LOCK")
CreateButton(BlueLockTab.content, "Auto Score", "Score goals automatically", function()
    -- Implementação do auto score
end)

CreateButton(BlueLockTab.content, "Perfect Shot", "Never miss a shot", function()
    -- Implementação do chute perfeito
end)

-- Grow a Garden
local GrowTab = CreateTab("GROW GARDEN")
CreateButton(GrowTab.content, "Auto Water", "Water plants automatically", function()
    -- Implementação do auto water
end)

CreateButton(GrowTab.content, "Auto Harvest", "Harvest plants automatically", function()
    -- Implementação do auto harvest
end)

-- Arsenal
local ArsenalTab = CreateTab("ARSENAL")
CreateButton(ArsenalTab.content, "Silent Aim", "Improved aiming", function()
    -- Implementação do silent aim
end)

CreateButton(ArsenalTab.content, "No Recoil", "Remove weapon recoil", function()
    -- Implementação do no recoil
end)

-- ===== WINDOW CONTROLS =====
local minimized = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0.35, 0, 0, 30)
        ContentFrame.Visible = false
        TabContainer.Visible = false
    else
        MainFrame.Size = originalSize
        ContentFrame.Visible = true
        TabContainer.Visible = true
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Efeitos visuais nos botões
CloseButton.MouseEnter:Connect(function()
    CloseButton.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.BackgroundColor3 = Theme.Colors.Close
end)

MinimizeButton.MouseEnter:Connect(function()
    MinimizeButton.BackgroundColor3 = Color3.new(1, 0.6, 0.2)
end)

MinimizeButton.MouseLeave:Connect(function()
    MinimizeButton.BackgroundColor3 = Theme.Colors.Minimize
end)

-- Inicialização
MiscTab.Show()

-- Efeito de entrada
MainFrame.Position = UDim2.new(0.5, -175, 0, -400)
TweenService:Create(
    MainFrame,
    TweenInfo.new(0.7, Enum.EasingStyle.Quint),
    {Position = UDim2.new(0.5, -175, 0.5, -150)}
):Play()

print("🐉 Dr4gonHub Premium - Script completo carregado!")
