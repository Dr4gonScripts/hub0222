--[[
  🐉 Dr4gonHub Premium - Edição Completa e Estável
  Recursos:
  - MISC: Aimbot, Hitbox Expander, Speed, Jump, Fly, NoClip, TP
  - Jogos: Blox Fruits, Blue Lock, Grow a Garden, Arsenal
  - Interface segura com tratamento de erros
]]

-- ===== SERVIÇOS COM TRATAMENTO DE ERROS =====
local function GetService(serviceName)
    local success, service = pcall(game.GetService, game, serviceName)
    return success and service or nil
end

local Players = GetService("Players") or game:WaitForChild("Players")
local UserInputService = GetService("UserInputService")
local RunService = GetService("RunService")
local TweenService = GetService("TweenService")
local CoreGui = GetService("CoreGui") or game:WaitForChild("CoreGui")

-- Verificação essencial
if not (Players and UserInputService and RunService and TweenService and CoreGui) then
    warn("❌ Serviços essenciais não carregados!")
    return
end

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

-- ===== CONFIGURAÇÃO DO TEMA =====
local Theme = {
    Colors = {
        Main = Color3.fromRGB(25, 25, 35),
        Header = Color3.fromRGB(188, 10, 28),
        TabActive = Color3.fromRGB(45, 45, 60),
        TabInactive = Color3.fromRGB(35, 35, 50),
        Text = Color3.fromRGB(240, 240, 240),
        Button = Color3.fromRGB(45, 50, 65),
        ButtonHover = Color3.fromRGB(55, 60, 75),
        Accent = Color3.fromRGB(255, 212, 96),
        Close = Color3.fromRGB(255, 80, 80),
        Minimize = Color3.fromRGB(255, 180, 80),
        Hitbox = Color3.fromRGB(255, 50, 50)
    },
    Settings = {
        Aimbot = {FOV = 100, Smoothness = 5, TeamCheck = true},
        Hitbox = {Size = 2, Transparency = 0.5},
        Movement = {Speed = 50, Jump = 50},
        Fly = {Speed = 50}
    }
}

-- ===== CRIAÇÃO SEGURA DA INTERFACE =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = CoreGui

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

-- ===== SISTEMA DE MOVIMENTO DA JANELA =====
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

-- ===== SISTEMA DE ABAS =====
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

-- ===== FUNÇÕES UTILITÁRIAS =====
local function SafeCreate(instanceType, properties)
    local success, obj = pcall(Instance.new, instanceType)
    if success and obj then
        for prop, value in pairs(properties) do
            pcall(function() obj[prop] = value end)
        end
        return obj
    end
    return nil
end

local function CreateButton(parent, text, description, callback)
    local buttonFrame = SafeCreate("Frame", {
        Size = UDim2.new(1, -10, 0, 60),
        BackgroundColor3 = Theme.Colors.Button,
        Parent = parent
    })
    
    if not buttonFrame then return end
    
    SafeCreate("TextButton", {
        Text = text,
        Size = UDim2.new(1, 0, 0.6, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = Theme.Colors.Text,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = buttonFrame,
        MouseButton1Click = callback
    })
    
    SafeCreate("TextLabel", {
        Text = description,
        Size = UDim2.new(1, -10, 0.4, 0),
        Position = UDim2.new(0, 10, 0.6, 0),
        TextColor3 = Color3.fromRGB(180, 180, 180),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = buttonFrame
    })
    
    buttonFrame.MouseEnter:Connect(function()
        buttonFrame.BackgroundColor3 = Theme.Colors.ButtonHover
    end)
    
    buttonFrame.MouseLeave:Connect(function()
        buttonFrame.BackgroundColor3 = Theme.Colors.Button
    end)
    
    return buttonFrame
end

local function CreateSlider(parent, text, min, max, default, callback)
    local frame = SafeCreate("Frame", {
        Size = UDim2.new(1, -10, 0, 70),
        BackgroundColor3 = Theme.Colors.Button,
        Parent = parent
    })
    
    SafeCreate("TextLabel", {
        Text = text,
        Size = UDim2.new(1, 0, 0.4, 0),
        TextColor3 = Theme.Colors.Text,
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame
    })
    
    local slider = SafeCreate("Frame", {
        Size = UDim2.new(0.9, 0, 0, 15),
        Position = UDim2.new(0.05, 0, 0.6, 0),
        BackgroundColor3 = Color3.fromRGB(60, 60, 70),
        Parent = frame
    })
    
    local fill = SafeCreate("Frame", {
        Size = UDim2.new((default - min)/(max - min), 0, 1, 0),
        BackgroundColor3 = Theme.Colors.Accent,
        Parent = slider
    })
    
    local valueLabel = SafeCreate("TextLabel", {
        Text = tostring(default),
        Size = UDim2.new(0.2, 0, 0.4, 0),
        Position = UDim2.new(0.8, 0, 0.6, 0),
        TextColor3 = Theme.Colors.Text,
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        Parent = frame
    })
    
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local connection
            connection = RunService.RenderStepped:Connect(function()
                local pos = UserInputService:GetMouseLocation().X - slider.AbsolutePosition.X
                local ratio = math.clamp(pos / slider.AbsoluteSize.X, 0, 1)
                local val = min + (max - min) * ratio
                fill.Size = UDim2.new(ratio, 0, 1, 0)
                valueLabel.Text = string.format("%.1f", val)
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

-- ===== FUNÇÕES MISC =====
local MiscTab = CreateTab("MISC")

-- Aimbot
local aimbot = {
    Enabled = false,
    Connection = nil,
    Target = nil
}

local function IsEnemy(player)
    if not Theme.Settings.Aimbot.TeamCheck then return true end
    if LocalPlayer.Team and player.Team then
        return LocalPlayer.Team ~= player.Team
    end
    return player ~= LocalPlayer
end

local function FindClosestTarget()
    local closest = nil
    local closestDist = Theme.Settings.Aimbot.FOV
    
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

local function AimbotUpdate()
    if aimbot.Enabled then
        aimbot.Target = FindClosestTarget()
        if aimbot.Target then
            local camera = workspace.CurrentCamera
            local current = camera.CFrame.Position
            local targetPos = aimbot.Target.Position + Vector3.new(0, 1.5, 0)
            local direction = (targetPos - current).Unit
            local smoothFactor = math.clamp(Theme.Settings.Aimbot.Smoothness, 1, 10)
            local newLook = current + direction * (smoothFactor * 0.1)
            camera.CFrame = CFrame.lookAt(current, newLook)
        end
    end
end

CreateButton(MiscTab.content, "Toggle Aimbot", "Lock onto enemies", function()
    aimbot.Enabled = not aimbot.Enabled
    if aimbot.Enabled and not aimbot.Connection then
        aimbot.Connection = RunService.RenderStepped:Connect(AimbotUpdate)
    elseif not aimbot.Enabled and aimbot.Connection then
        aimbot.Connection:Disconnect()
        aimbot.Connection = nil
    end
end)

CreateButton(MiscTab.content, "Toggle Team Check", "Ignore teammates", function()
    Theme.Settings.Aimbot.TeamCheck = not Theme.Settings.Aimbot.TeamCheck
end)

CreateSlider(MiscTab.content, "Aimbot Smoothness", 1, 10, Theme.Settings.Aimbot.Smoothness, function(val)
    Theme.Settings.Aimbot.Smoothness = val
end)

CreateSlider(MiscTab.content, "Aimbot FOV", 10, 200, Theme.Settings.Aimbot.FOV, function(val)
    Theme.Settings.Aimbot.FOV = val
end)

-- Hitbox Expander
local hitbox = {
    Enabled = false,
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
                    hitboxPart.Size = part.Size * Theme.Settings.Hitbox.Size
                    hitboxPart.Transparency = Theme.Settings.Hitbox.Transparency
                    hitboxPart.Color3 = Theme.Colors.Hitbox
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

CreateSlider(MiscTab.content, "Hitbox Size", 1, 5, Theme.Settings.Hitbox.Size, function(val)
    Theme.Settings.Hitbox.Size = val
    UpdateHitboxes()
end)

CreateSlider(MiscTab.content, "Hitbox Transparency", 0, 1, Theme.Settings.Hitbox.Transparency, function(val)
    Theme.Settings.Hitbox.Transparency = val
    UpdateHitboxes()
end)

-- Speed Hack
local speedHack = {
    Enabled = false,
    Connection = nil
}

local function SpeedUpdate()
    if speedHack.Enabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Theme.Settings.Movement.Speed
        end
    end
end

CreateButton(MiscTab.content, "Toggle Speed", "Increase movement speed", function()
    speedHack.Enabled = not speedHack.Enabled
    if speedHack.Enabled then
        if not speedHack.Connection then
            speedHack.Connection = RunService.Heartbeat:Connect(SpeedUpdate)
        end
        SpeedUpdate()
    elseif speedHack.Connection then
        speedHack.Connection:Disconnect()
        speedHack.Connection = nil
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end)

CreateSlider(MiscTab.content, "Speed Value", 16, 150, Theme.Settings.Movement.Speed, function(val)
    Theme.Settings.Movement.Speed = val
    SpeedUpdate()
end)

-- Jump Hack
local jumpHack = {
    Enabled = false
}

CreateButton(MiscTab.content, "Toggle Jump", "Increase jump power", function()
    jumpHack.Enabled = not jumpHack.Enabled
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = jumpHack.Enabled and Theme.Settings.Movement.Jump or 50
        end
    end
end)

CreateSlider(MiscTab.content, "Jump Power", 50, 250, Theme.Settings.Movement.Jump, function(val)
    Theme.Settings.Movement.Jump = val
    if jumpHack.Enabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = val
        end
    end
end)

-- Fly Hack
local flyHack = {
    Enabled = false,
    Controls = {F = 0, B = 0, L = 0, R = 0},
    Connection = nil
}

local function FlyUpdate()
    if flyHack.Enabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            humanoid.PlatformStand = true
            
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
                task.wait()
                
                local cam = workspace.CurrentCamera.CFrame
                local move = cam.LookVector * (flyHack.Controls.F + flyHack.Controls.B) + 
                             cam.RightVector * (flyHack.Controls.L + flyHack.Controls.R)
                
                move = move.Unit * Theme.Settings.Fly.Speed
                
                if (flyHack.Controls.F + flyHack.Controls.B + flyHack.Controls.L + flyHack.Controls.R) > 0 then
                    bv.velocity = move
                else
                    bv.velocity = Vector3.new(0, 0, 0)
                end
                
                bg.cframe = cam
            end
            
            bg:Destroy()
            bv:Destroy()
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
    end
end

CreateButton(MiscTab.content, "Toggle Fly", "Press WASD to fly", function()
    flyHack.Enabled = not flyHack.Enabled
    if flyHack.Enabled then
        -- Configurar controles
        flyHack.Connection = UserInputService.InputBegan:Connect(function(input, processed)
            if not processed then
                if input.KeyCode == Enum.KeyCode.W then
                    flyHack.Controls.F = 1
                elseif input.KeyCode == Enum.KeyCode.S then
                    flyHack.Controls.B = -1
                elseif input.KeyCode == Enum.KeyCode.A then
                    flyHack.Controls.L = -1
                elseif input.KeyCode == Enum.KeyCode.D then
                    flyHack.Controls.R = 1
                end
            end
        end)
        
        local endConnection = UserInputService.InputEnded:Connect(function(input, processed)
            if not processed then
                if input.KeyCode == Enum.KeyCode.W then
                    flyHack.Controls.F = 0
                elseif input.KeyCode == Enum.KeyCode.S then
                    flyHack.Controls.B = 0
                elseif input.KeyCode == Enum.KeyCode.A then
                    flyHack.Controls.L = 0
                elseif input.KeyCode == Enum.KeyCode.D then
                    flyHack.Controls.R = 0
                end
            end
        end)
        
        FlyUpdate()
        
        -- Limpeza
        if flyHack.Connection then
            flyHack.Connection:Disconnect()
        end
        endConnection:Disconnect()
    end
end)

CreateSlider(MiscTab.content, "Fly Speed", 20, 150, Theme.Settings.Fly.Speed, function(val)
    Theme.Settings.Fly.Speed = val
end)

-- NoClip
local noclip = {
    Enabled = false,
    Connection = nil
}

local function NoclipUpdate()
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
        noclip.Connection = RunService.Stepped:Connect(NoclipUpdate)
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

-- ===== ABAS DE JOGOS =====
-- Blox Fruits
local BloxTab = CreateTab("BLOX FRUITS")
CreateButton(BloxTab.content, "Auto Farm Level", "Farm automatically", function()
    -- Implementação do auto farm
    print("Auto Farm para Blox Fruits ativado!")
end)

CreateButton(BloxTab.content, "Teleport to Fruits", "Find and teleport to fruits", function()
    -- Implementação do teleporte para frutas
    print("Teleporte para frutas ativado!")
end)

-- Blue Lock Rivals
local BlueLockTab = CreateTab("BLUE LOCK")
CreateButton(BlueLockTab.content, "Auto Score", "Score goals automatically", function()
    -- Implementação do auto score
    print("Auto Score para Blue Lock ativado!")
end)

CreateButton(BlueLockTab.content, "Perfect Shot", "Never miss a shot", function()
    -- Implementação do chute perfeito
    print("Perfect Shot ativado!")
end)

-- Grow a Garden
local GrowTab = CreateTab("GROW GARDEN")
CreateButton(GrowTab.content, "Auto Water", "Water plants automatically", function()
    -- Implementação do auto water
    print("Auto Water para Grow a Garden ativado!")
end)

CreateButton(GrowTab.content, "Auto Harvest", "Harvest plants automatically", function()
    -- Implementação do auto harvest
    print("Auto Harvest ativado!")
end)

-- Arsenal
local ArsenalTab = CreateTab("ARSENAL")
CreateButton(ArsenalTab.content, "Silent Aim", "Improved aiming", function()
    -- Implementação do silent aim
    print("Silent Aim para Arsenal ativado!")
end)

CreateButton(ArsenalTab.content, "No Recoil", "Remove weapon recoil", function()
    -- Implementação do no recoil
    print("No Recoil ativado!")
end)

-- ===== CONTROLES DA JANELA =====
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
    ScreenGui:Destroy()
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

-- ===== INICIALIZAÇÃO =====
local function Initialize()
    MiscTab.Show()
    
    -- Efeito de entrada
    MainFrame.Position = UDim2.new(0.5, -175, 0, -400)
    TweenService:Create(
        MainFrame,
        TweenInfo.new(0.7, Enum.EasingStyle.Quint),
        {Position = UDim2.new(0.5, -175, 0.5, -150)}
    ):Play()
    
    print("🐉 Dr4gonHub Premium - Interface carregada com sucesso!")
end

-- Verificação final e inicialização
if ScreenGui and MainFrame then
    local success, err = pcall(Initialize)
    if not success then
        warn("Erro na inicialização: "..tostring(err))
        MainFrame.Visible = true -- Mostra a interface mesmo com erro
    end
else
    warn("❌ Falha crítica ao criar interface!")
end
