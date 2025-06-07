--[[
  🐉 Dr4gonHub Premium - Versão Retangular Aprimorada
  Recursos: 
    - Abas para organização
    - Hitbox Expander com transparência ajustável
    - Aimbot com visualização de nick
    - Controles de Janela
    - Seção para scripts externos
  Formato: Retangular | Estável | Xeno Executor
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DA UI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
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

-- Barra de abas
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local MainTab = Instance.new("TextButton")
MainTab.Text = "Main"
MainTab.Size = UDim2.new(0.33, 0, 1, 0)
MainTab.Position = UDim2.new(0, 0, 0, 0)
MainTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
MainTab.TextColor3 = Color3.new(1, 1, 1)
MainTab.Font = Enum.Font.Gotham
MainTab.TextSize = 14
MainTab.Parent = TabBar

local ScriptsTab = Instance.new("TextButton")
ScriptsTab.Text = "Scripts"
ScriptsTab.Size = UDim2.new(0.34, 0, 1, 0)
ScriptsTab.Position = UDim2.new(0.33, 0, 0, 0)
ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ScriptsTab.TextColor3 = Color3.new(1, 1, 1)
ScriptsTab.Font = Enum.Font.Gotham
ScriptsTab.TextSize = 14
ScriptsTab.Parent = TabBar

local FunTab = Instance.new("TextButton")
FunTab.Text = "Fun"
FunTab.Size = UDim2.new(0.33, 0, 1, 0)
FunTab.Position = UDim2.new(0.67, 0, 0, 0)
FunTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
FunTab.TextColor3 = Color3.new(1, 1, 1)
FunTab.Font = Enum.Font.Gotham
FunTab.TextSize = 14
FunTab.Parent = TabBar

-- Área de conteúdo
local MainContent = Instance.new("ScrollingFrame")
MainContent.Name = "MainContent"
MainContent.Size = UDim2.new(1, 0, 1, -65)
MainContent.Position = UDim2.new(0, 0, 0, 65)
MainContent.BackgroundTransparency = 1
MainContent.ScrollBarThickness = 5
MainContent.CanvasSize = UDim2.new(0, 0, 0, 650)
MainContent.Visible = true
MainContent.Parent = MainFrame

local ScriptsContent = Instance.new("ScrollingFrame")
ScriptsContent.Name = "ScriptsContent"
ScriptsContent.Size = UDim2.new(1, 0, 1, -65)
ScriptsContent.Position = UDim2.new(0, 0, 0, 65)
ScriptsContent.BackgroundTransparency = 1
ScriptsContent.ScrollBarThickness = 5
ScriptsContent.CanvasSize = UDim2.new(0, 0, 0, 650)
ScriptsContent.Visible = false
ScriptsContent.Parent = MainFrame

local FunContent = Instance.new("ScrollingFrame")
FunContent.Name = "FunContent"
FunContent.Size = UDim2.new(1, 0, 1, -65)
FunContent.Position = UDim2.new(0, 0, 0, 65)
FunContent.BackgroundTransparency = 1
FunContent.ScrollBarThickness = 5
FunContent.CanvasSize = UDim2.new(0, 0, 0, 650)
FunContent.Visible = false
FunContent.Parent = MainFrame

local UIListLayoutMain = Instance.new("UIListLayout")
UIListLayoutMain.Padding = UDim.new(0, 5)
UIListLayoutMain.Parent = MainContent

local UIListLayoutScripts = Instance.new("UIListLayout")
UIListLayoutScripts.Padding = UDim.new(0, 5)
UIListLayoutScripts.Parent = ScriptsContent

local UIListLayoutFun = Instance.new("UIListLayout")
UIListLayoutFun.Padding = UDim.new(0, 5)
UIListLayoutFun.Parent = FunContent

-- ===== FUNÇÕES DE CONTROLE =====
local function CreateButton(name, callback, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = parent
    
    -- Variável de estado e cor inicial (OFF)
    local isActive = false
    button.BackgroundColor3 = Color3.fromRGB(20, 50, 90) -- Azul escuro quando desligado
    
    button.MouseButton1Click:Connect(function()
        isActive = not isActive
        if isActive then
            button.BackgroundColor3 = Color3.fromRGB(50, 150, 255) -- Azul claro quando ligado
        else
            button.BackgroundColor3 = Color3.fromRGB(20, 50, 90) -- Azul escuro quando desligado
        end
        pcall(callback, isActive)
    end)
    
    return button, function(state)
        isActive = state
        if isActive then
            button.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        else
            button.BackgroundColor3 = Color3.fromRGB(20, 50, 90)
        end
    end
end

local function CreateSlider(name, min, max, default, callback, parent)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0.9, 0, 0, 60)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parent
    
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
        MainFrame.Size = UDim2.new(0.3, 0, 0, 30)
        TabBar.Visible = false
        MainContent.Visible = false
        ScriptsContent.Visible = false
        FunContent.Visible = false
    else
        MainFrame.Size = originalSize
        TabBar.Visible = true
        -- Restaurar a aba visível
        if MainTab.BackgroundColor3 == Color3.fromRGB(50, 50, 70) then
            MainContent.Visible = true
        elseif ScriptsTab.BackgroundColor3 == Color3.fromRGB(50, 50, 70) then
            ScriptsContent.Visible = true
        else
            FunContent.Visible = true
        end
    end
end)

-- Controle de abas
MainTab.MouseButton1Click:Connect(function()
    MainTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    FunTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    
    MainContent.Visible = true
    ScriptsContent.Visible = false
    FunContent.Visible = false
end)

ScriptsTab.MouseButton1Click:Connect(function()
    MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ScriptsTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    FunTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    
    MainContent.Visible = false
    ScriptsContent.Visible = true
    FunContent.Visible = false
end)

FunTab.MouseButton1Click:Connect(function()
    MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    FunTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    
    MainContent.Visible = false
    ScriptsContent.Visible = false
    FunContent.Visible = true
end)

-- ===== HITBOX EXPANDER (Main Tab) =====
local hitboxEnabled = false
local hitboxSize = 2
local hitboxTransparency = 0.5
local hitboxParts = {}

local hitboxSlider = CreateSlider("Hitbox Size (1-5)", 1, 5, 2, function(value)
    hitboxSize = value
    UpdateHitboxes()
end, MainContent)

local transparencySlider = CreateSlider("Hitbox Transparency (0-1)", 0, 1, 0.5, function(value)
    hitboxTransparency = value
    UpdateHitboxes()
end, MainContent)

local function UpdateHitboxes()
    for _, part in pairs(hitboxParts) do
        if part:IsA("BasePart") then
            part:Destroy()
        end
    end
    hitboxParts = {}

    if not hitboxEnabled then return end

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

local hitboxButton, setHitboxState = CreateButton("Hitbox Expander", function(state)
    hitboxEnabled = state
    UpdateHitboxes()
end, MainContent)

-- ===== AIMBOT (Main Tab) =====
local aimbotEnabled = false
local aimbotFOV = 100
local aimbotTeamCheck = true
local currentTarget = nil
local targetView = nil

-- Criação do texto para visualização do alvo
local function CreateTargetView()
    if targetView then targetView:Destroy() end
    
    targetView = Instance.new("TextLabel")
    targetView.Name = "TargetView"
    targetView.Text = "Target: None"
    targetView.TextColor3 = Color3.new(1, 1, 1)
    targetView.Font = Enum.Font.GothamBold
    targetView.TextSize = 16
    targetView.Size = UDim2.new(0, 200, 0, 30)
    targetView.Position = UDim2.new(0.5, -100, 0, 50)
    targetView.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    targetView.BackgroundTransparency = 0.5
    targetView.BorderSizePixel = 0
    targetView.Visible = false
    targetView.Parent = ScreenGui
    
    return targetView
end

CreateTargetView()

local aimbotFOVSlider = CreateSlider("Aimbot FOV (10-200)", 10, 200, 100, function(value)
    aimbotFOV = value
end, MainContent)

local aimbotButton, setAimbotState = CreateButton("Aimbot", function(state)
    aimbotEnabled = state
    targetView.Visible = state
    if not state then
        currentTarget = nil
        targetView.Text = "Target: None"
    end
end, MainContent)

local teamCheckButton, setTeamCheckState = CreateButton("Team Check", function(state)
    aimbotTeamCheck = state
end, MainContent)
setTeamCheckState(true) -- Inicialmente ligado

-- Função principal do aimbot
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local closestPlayer = nil
        local closestDistance = aimbotFOV
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= Player and player.Character then
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
                currentTarget = closestPlayer
                targetView.Text = "Target: " .. closestPlayer.Name
                workspace.CurrentCamera.CFrame = CFrame.lookAt(
                    workspace.CurrentCamera.CFrame.Position,
                    target.Position
                )
            end
        else
            currentTarget = nil
            targetView.Text = "Target: None"
        end
    end
end)

-- ===== FUNÇÕES BÁSICAS (Main Tab) =====
-- WalkSpeed
local walkSpeed = 16
local walkSpeedSlider = CreateSlider("WalkSpeed (0-500)", 0, 500, 16, function(value)
    walkSpeed = value
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = value
    end
end, MainContent)

-- JumpPower
local jumpPower = 50
local jumpPowerSlider = CreateSlider("JumpPower (0-500)", 0, 500, 50, function(value)
    jumpPower = value
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.JumpPower = value
    end
end, MainContent)

-- Fly (usando o script universal)
local flyButton, setFlyState = CreateButton("Fly (Universal)", function(state)
    if state then
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
        -- Não podemos desligar o fly externo, então mantemos o botão ativado
        setFlyState(true)
    else
        -- Aviso que não podemos desativar o fly do script externo
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dr4gonHub",
            Text = "Use o comando do script de fly para desativar",
            Duration = 5
        })
    end
end, MainContent)

-- Noclip
local noclip = false
local noclipButton, setNoclipState = CreateButton("Noclip", function(state)
    noclip = state
    
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
end, MainContent)

-- Anti-AFK
local antiAFKButton, setAntiAFKState = CreateButton("Anti-AFK", function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
end, MainContent)

-- Atualizar ao respawn
Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    task.wait(0.5)
    walkSpeedSlider.SetValue(walkSpeed)
    jumpPowerSlider.SetValue(jumpPower)
    
    if noclip then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- ===== SCRIPTS EXTERNOS (Scripts Tab) =====
local function CreateScriptButton(name, script, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = parent
    
    button.MouseButton1Click:Connect(function()
        loadstring(script)()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dr4gonHub",
            Text = name .. " carregado!",
            Duration = 3
        })
    end)
end

-- View Script
CreateScriptButton("View Script", 
    [[loadstring(game:HttpGetAsync('https://pastefy.app/mJ8vapGJ/raw'))()execute("https://scriptprotector-d6fe7-default-rtdb.firebaseio.com/", "B4SraukVMMsjcGG2rAzqm2m0AkO5mY4bt3PkeNoo", "Script9")]], 
    ScriptsContent)

-- Keyboard Script
CreateScriptButton("Keyboard Script", 
    [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt", true))()]], 
    ScriptsContent)

-- ESP Script
CreateScriptButton("ESP Script", 
    [[loadstring(game:HttpGet("https://pastebin.com/9Xs09T4Z"))()]], 
    ScriptsContent)

-- ===== SCRIPTS DE DIVERSÃO (Fun Tab) =====
-- Troll Script
CreateScriptButton("Ragdoll Troll Script", 
    [[loadstring(game:HttpGet("https://raw.githubusercontent.com/blackheartedcurse/punkz-Scripts/main/SolaraVersionRagdoll.lua"))()]], 
    FunContent)

-- Outros scripts divertidos podem ser adicionados aqui

print("🐉 Dr4gonHub Premium - Versão Aprimorada carregada com sucesso!")
