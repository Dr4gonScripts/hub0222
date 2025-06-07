--[[
  🐉 Dr4gonHub Premium - Versão Modificada
  Modificações:
    - Fundo transparente com imagem do Aizen
    - Bola minimizada substituída por Astolfo Chibi (redonda)
    - Bola arrastável
    - Interface completa com 4 abas funcionais
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DA UI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Configuração do tema baseado na imagem do Aizen
local Theme = {
    Background = Color3.fromRGB(10, 10, 20),
    Primary = Color3.fromRGB(0, 74, 173),  -- Azul do Aizen
    Secondary = Color3.fromRGB(188, 10, 28), -- Vermelho do Aizen
    Accent = Color3.fromRGB(200, 200, 255),
    Text = Color3.fromRGB(240, 240, 255)
}

-- Frame principal com imagem de fundo do Aizen
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.45, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
MainFrame.BackgroundTransparency = 1 -- Fundo totalmente transparente
MainFrame.Parent = ScreenGui

-- Imagem de fundo do Aizen
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "AizenBackground"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.Image = "https://i.pinimg.com/736x/89/cb/fc/89cbfcef22a93b1fd10dd5abb28735e2.jpg"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Parent = MainFrame

-- Overlay escuro para melhor legibilidade (mais transparente)
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.Position = UDim2.new(0, 0, 0, 0)
Overlay.BackgroundColor3 = Theme.Background
Overlay.BackgroundTransparency = 0.85
Overlay.BorderSizePixel = 0
Overlay.Parent = MainFrame

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Theme.Secondary
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "DR4GONHUB PREMIUM"
Title.TextColor3 = Theme.Text
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
CloseButton.TextColor3 = Theme.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "_"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundColor3 = Theme.Primary
MinimizeButton.TextColor3 = Theme.Text
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TitleBar

-- Barra de abas
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

-- Configuração das abas
local function CreateTab(name, position)
    local tab = Instance.new("TextButton")
    tab.Text = name
    tab.Size = UDim2.new(0.25, 0, 1, 0)
    tab.Position = position
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tab.TextColor3 = Theme.Text
    tab.Font = Enum.Font.Gotham
    tab.TextSize = 12
    tab.Parent = TabBar
    
    tab.MouseEnter:Connect(function()
        if tab.BackgroundColor3 ~= Theme.Primary then
            tab.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        end
    end)
    
    tab.MouseLeave:Connect(function()
        if tab.BackgroundColor3 ~= Theme.Primary then
            tab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
    end)
    
    return tab
end

local MainTab = CreateTab("Main", UDim2.new(0, 0, 0, 0))
local ScriptsTab = CreateTab("Scripts", UDim2.new(0.25, 0, 0, 0))
local FunTab = CreateTab("Fun", UDim2.new(0.5, 0, 0, 0))
local ExecutorsTab = CreateTab("Executors", UDim2.new(0.75, 0, 0, 0))

-- Áreas de conteúdo
local function CreateContentFrame(name)
    local frame = Instance.new("ScrollingFrame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, -65)
    frame.Position = UDim2.new(0, 0, 0, 65)
    frame.BackgroundTransparency = 1
    frame.ScrollBarThickness = 5
    frame.ScrollBarImageColor3 = Theme.Primary
    frame.Visible = false
    frame.Parent = MainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = frame
    
    return frame
end

local MainContent = CreateContentFrame("MainContent")
MainContent.CanvasSize = UDim2.new(0, 0, 0, 700)
MainContent.Visible = true

local ScriptsContent = CreateContentFrame("ScriptsContent")
ScriptsContent.CanvasSize = UDim2.new(0, 0, 0, 1200)

local FunContent = CreateContentFrame("FunContent")
FunContent.CanvasSize = UDim2.new(0, 0, 0, 700)

local ExecutorsContent = CreateContentFrame("ExecutorsContent")
ExecutorsContent.CanvasSize = UDim2.new(0, 0, 0, 300)

-- ===== FUNÇÕES AUXILIARES =====
local function CreateButton(name, callback, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    button.TextColor3 = Theme.Text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.BorderColor3 = Theme.Primary
    button.BorderSizePixel = 1
    button.Parent = parent
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    end)
    
    local isActive = false
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    
    button.MouseButton1Click:Connect(function()
        isActive = not isActive
        button.BackgroundColor3 = isActive and Theme.Primary or Color3.fromRGB(30, 30, 40)
        pcall(callback, isActive)
    end)
    
    return button, function(state)
        isActive = state
        button.BackgroundColor3 = isActive and Theme.Primary or Color3.fromRGB(30, 30, 40)
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
    label.TextColor3 = Theme.Text
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Text = tostring(default)
    textBox.Size = UDim2.new(1, 0, 0, 30)
    textBox.Position = UDim2.new(0, 0, 0, 25)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    textBox.TextColor3 = Theme.Text
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.BorderColor3 = Theme.Primary
    textBox.BorderSizePixel = 1
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

local function CreateDivider(text, parent)
    local divider = Instance.new("TextLabel")
    divider.Text = " "..text.." "
    divider.TextColor3 = Theme.Primary
    divider.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    divider.Size = UDim2.new(0.9, 0, 0, 25)
    divider.Position = UDim2.new(0.05, 0, 0, 0)
    divider.Font = Enum.Font.GothamBold
    divider.TextSize = 14
    divider.TextXAlignment = Enum.TextXAlignment.Center
    divider.BorderSizePixel = 1
    divider.BorderColor3 = Theme.Primary
    divider.Parent = parent
    
    return divider
end

local function CreateScriptButton(name, script, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.TextColor3 = Theme.Text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.BorderColor3 = Theme.Primary
    button.BorderSizePixel = 1
    button.Parent = parent
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end)
    
    button.MouseButton1Click:Connect(function()
        loadstring(script)()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dr4gonHub",
            Text = name .. " carregado!",
            Duration = 3,
            Icon = "rbxassetid://0"
        })
    end)
end

local function CreateLinkButton(name, url, parent)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.TextColor3 = Theme.Text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.BorderColor3 = Theme.Primary
    button.BorderSizePixel = 1
    button.Parent = parent
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end)
    
    button.MouseButton1Click:Connect(function()
        setclipboard(url)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dr4gonHub",
            Text = "Link copiado para a área de transferência!",
            Duration = 3,
            Icon = "rbxassetid://0"
        })
    end)
end

-- ===== CONTROLES DE JANELA =====
local minimized = false
local originalSize = MainFrame.Size
local originalPosition = MainFrame.Position

-- Botão de bola quando minimizado (Astolfo Chibi)
local BallButton = Instance.new("ImageButton")
BallButton.Image = "https://i.pinimg.com/736x/a9/c7/dc/a9c7dcff56ecc0106ab3d02daa67873f.jpg"
BallButton.Size = UDim2.new(0, 50, 0, 50)
BallButton.Position = originalPosition
BallButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BallButton.BorderSizePixel = 0
BallButton.Visible = false
BallButton.ZIndex = 10
BallButton.Parent = ScreenGui

-- Tornar a imagem redonda
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = BallButton

-- Arrastar a janela principal
local dragging = false
local dragInput, dragStart, startPos

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function UpdateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
    BallButton.Position = MainFrame.Position
end

TitleBar.InputBegan:Connect(function(input)
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

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging and not minimized then
        UpdateInput(input)
    end
end)

-- Arrastar a bola minimizada
local draggingBall = false
local dragInputBall, dragStartBall, startPosBall

local function UpdateBallInput(input)
    local delta = input.Position - dragStartBall
    BallButton.Position = UDim2.new(
        startPosBall.X.Scale, 
        startPosBall.X.Offset + delta.X, 
        startPosBall.Y.Scale, 
        startPosBall.Y.Offset + delta.Y
    )
end

BallButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingBall = true
        dragStartBall = input.Position
        startPosBall = BallButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingBall = false
            end
        end)
    end
end)

BallButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInputBall = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInputBall and draggingBall then
        UpdateBallInput(input)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Visible = false
        BallButton.Visible = true
        BallButton.Position = MainFrame.Position
    else
        MainFrame.Visible = true
        BallButton.Visible = false
    end
end)

BallButton.MouseButton1Click:Connect(function()
    minimized = false
    MainFrame.Visible = true
    BallButton.Visible = false
end)

-- Controle de abas
local function SwitchTab(selectedTab)
    MainTab.BackgroundColor3 = (selectedTab == MainTab) and Theme.Primary or Color3.fromRGB(40, 40, 50)
    ScriptsTab.BackgroundColor3 = (selectedTab == ScriptsTab) and Theme.Primary or Color3.fromRGB(40, 40, 50)
    FunTab.BackgroundColor3 = (selectedTab == FunTab) and Theme.Primary or Color3.fromRGB(40, 40, 50)
    ExecutorsTab.BackgroundColor3 = (selectedTab == ExecutorsTab) and Theme.Primary or Color3.fromRGB(40, 40, 50)
    
    MainContent.Visible = (selectedTab == MainTab)
    ScriptsContent.Visible = (selectedTab == ScriptsTab)
    FunContent.Visible = (selectedTab == FunTab)
    ExecutorsContent.Visible = (selectedTab == ExecutorsTab)
end

MainTab.MouseButton1Click:Connect(function() SwitchTab(MainTab) end)
ScriptsTab.MouseButton1Click:Connect(function() SwitchTab(ScriptsTab) end)
FunTab.MouseButton1Click:Connect(function() SwitchTab(FunTab) end)
ExecutorsTab.MouseButton1Click:Connect(function() SwitchTab(ExecutorsTab) end)

-- ===== MAIN TAB CONTENT =====
-- Hitbox Expander
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
                    hitbox.Color3 = Theme.Secondary
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

-- Aimbot
local aimbotEnabled = false
local aimbotFOV = 100
local aimbotTeamCheck = true
local currentTarget = nil
local targetView = nil

local function CreateTargetView()
    if targetView then targetView:Destroy() end
    
    targetView = Instance.new("TextLabel")
    targetView.Name = "TargetView"
    targetView.Text = "Target: None"
    targetView.TextColor3 = Theme.Text
    targetView.Font = Enum.Font.GothamBold
    targetView.TextSize = 16
    targetView.Size = UDim2.new(0, 200, 0, 30)
    targetView.Position = UDim2.new(0.5, -100, 0, 50)
    targetView.BackgroundColor3 = Theme.Background
    targetView.BackgroundTransparency = 0.5
    targetView.BorderSizePixel = 0
    targetView.Visible = false
    targetView.ZIndex = 100
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
setTeamCheckState(true)

-- Aimbot Logic
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
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

-- Basic Functions
local walkSpeed = 16
local walkSpeedSlider = CreateSlider("WalkSpeed (0-500)", 0, 500, 16, function(value)
    walkSpeed = value
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = value
    end
end, MainContent)

local jumpPower = 50
local jumpPowerSlider = CreateSlider("JumpPower (0-500)", 0, 500, 50, function(value)
    jumpPower = value
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.JumpPower = value
    end
end, MainContent)

-- Fly
local flyButton, setFlyState = CreateButton("Fly (Universal)", function(state)
    if state then
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
        setFlyState(true)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dr4gonHub",
            Text = "Use o comando do script de fly para desativar",
            Duration = 5,
            Icon = "rbxassetid://0"
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

-- Respawn Handling
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

-- ===== SCRIPTS TAB CONTENT =====
-- UTILITIES
CreateDivider("UTILIDADES", ScriptsContent)

CreateScriptButton("View Script", 
    [[loadstring(game:HttpGetAsync('https://pastefy.app/mJ8vapGJ/raw'))()execute("https://scriptprotector-d6fe7-default-rtdb.firebaseio.com/", "B4SraukVMMsjcGG2rAzqm2m0AkO5mY4bt3PkeNoo", "Script9")]], 
    ScriptsContent)

CreateScriptButton("Keyboard Script", 
    [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt", true))()]], 
    ScriptsContent)

CreateScriptButton("ESP Script", 
    [[loadstring(game:HttpGet("https://pastebin.com/9Xs09T4Z"))()]], 
    ScriptsContent)

CreateScriptButton("FPS Booster", 
    [[_G.Settings = {
        Players = {
            ["Ignore Me"] = true,
            ["Ignore Others"] = true
        },
        Meshes = {
            Destroy = false,
            LowDetail = true
        },
        Images = {
            Invisible = true,
            LowDetail = false,
            Destroy = false,
        },
        ["No Particles"] = true,
        ["No Camera Effects"] = true,
        ["No Explosions"] = true,
        ["No Clothes"] = true,
        ["Low Water Graphics"] = true,
        ["No Shadows"] = true,
        ["Low Rendering"] = true,
        ["Low Quality Parts"] = true
    }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()]], 
    ScriptsContent)

-- GROW A GARDEN
CreateDivider("GROW A GARDEN", ScriptsContent)

CreateScriptButton("Garden Dupe V2", 
    [[loadstring(game:HttpGet("https://gist.githubusercontent.com/NefariousScript/e79b2a8b4511938a6f236fca3a3803bf/raw/35b0daaf472754431bb18f2f3bd82c902a43f2e3/Dupe-SpawnV2"))()]], 
    ScriptsContent)

CreateScriptButton("Garden Script 2", 
    [[loadstring(game:HttpGet("https://paste.ee/r/6JTPRNMa"))()]], 
    ScriptsContent)

CreateScriptButton("No Lag Hub", 
    [[loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()]], 
    ScriptsContent)

-- BLOX FRUITS
CreateDivider("BLOX FRUITS", ScriptsContent)

CreateScriptButton("W Azure", 
    [[loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()]], 
    ScriptsContent)

-- MUSCLES LEGENDS
CreateDivider("MUSCLES LEGENDS", ScriptsContent)

CreateScriptButton("Speed Hub X (ML)", 
    [[loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()]], 
    ScriptsContent)

CreateScriptButton("Muscles Legends Script", 
    [[loadstring(game:HttpGet("https://raw.githubusercontent.com/TryharderKid/LurnaiNewUpdate/refs/heads/main/Script/Loader.lua"))()]], 
    ScriptsContent)

-- BLUE LOCK RIVALS
CreateDivider("BLUE LOCK RIVALS", ScriptsContent)

CreateScriptButton("Blue Lock Rivals", 
    [[loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()]], 
    ScriptsContent)

-- GENERAL SCRIPTS
CreateDivider("GERAL", ScriptsContent)

CreateScriptButton("Speed Hub X (Geral)", 
    [[loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()]], 
    ScriptsContent)

-- ===== FUN TAB CONTENT =====
CreateDivider("DIVERSÃO", FunContent)

CreateScriptButton("Ragdoll Troll Script", 
    [[loadstring(game:HttpGet("https://raw.githubusercontent.com/blackheartedcurse/punkz-Scripts/main/SolaraVersionRagdoll.lua"))()]], 
    FunContent)

-- ===== EXECUTORS TAB CONTENT =====
CreateDivider("EXECUTORES", ExecutorsContent)

CreateLinkButton("Delta Executor", "https://deltaexploits.gg/android_dl", ExecutorsContent)

CreateLinkButton("Krnl Executor", "https://www.mediafire.com/file/6fclnd4npho1ll1/krnl_release_2.675.715_2025.6.2_29.apk/file", ExecutorsContent)

print("🐉 Dr4gonHub Premium - Versão Modificada carregada com sucesso!")
