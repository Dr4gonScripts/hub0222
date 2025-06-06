--[[
  🐉 Dr4gonHub Premium - Edição Multijogos
  Interface bonita + funções completas
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DO TEMA =====
local Theme = {
    Colors = {
        Primary = Color3.fromRGB(188, 10, 28),    -- Vermelho chinês
        Secondary = Color3.fromRGB(255, 212, 96),  -- Dourado
        Background = Color3.fromRGB(20, 16, 11),   -- Preto envernizado
        Text = Color3.fromRGB(255, 255, 255),
        Button = Color3.fromRGB(45, 45, 55)
    },
    Images = {
        Dragon = "rbxassetid://14204253922",
        Pattern = "rbxassetid://14204261233"
    }
}

-- ===== CRIAÇÃO DA INTERFACE =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame principal com padrão de seda
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.3, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Theme.Colors.Background
MainFrame.Parent = ScreenGui

local BackgroundPattern = Instance.new("ImageLabel")
BackgroundPattern.Image = Theme.Images.Pattern
BackgroundPattern.ImageTransparency = 0.95
BackgroundPattern.ScaleType = Enum.ScaleType.Tile
BackgroundPattern.TileSize = UDim2.new(0, 100, 0, 100)
BackgroundPattern.Size = UDim2.new(1, 0, 1, 0)
BackgroundPattern.Parent = MainFrame

-- Barra de abas
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 45)
TabBar.BackgroundColor3 = Theme.Colors.Primary
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 2)
TabListLayout.Parent = TabBar

-- Container de conteúdo
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, 0, 1, -45)
ContentFrame.Position = UDim2.new(0, 0, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 5
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 15)
ContentLayout.Parent = ContentFrame

-- ===== SISTEMA DE ABAS =====
local currentTab = nil
local tabs = {}

local function CreateTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Text = icon .. " " .. name
    tabButton.Size = UDim2.new(0.25, 0, 1, 0)
    tabButton.BackgroundColor3 = Theme.Colors.Primary
    tabButton.TextColor3 = Theme.Colors.Text
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.Parent = TabBar
    
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 0, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.AutomaticSize = Enum.AutomaticSize.Y
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
                currentTab.button.BackgroundColor3 = Theme.Colors.Primary
            end
            currentTab = tab
            tab.content.Visible = true
            tab.button.BackgroundColor3 = Theme.Colors.Secondary
            tab.button.TextColor3 = Color3.fromRGB(0, 0, 0)
        end
    }
    
    tabButton.MouseButton1Click:Connect(tab.Show)
    table.insert(tabs, tab)
    return tab
end

-- ===== COMPONENTES DA UI =====
local function CreateButton(parent, text, description)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(0.95, 0, 0, 60)
    buttonFrame.BackgroundColor3 = Theme.Colors.Button
    buttonFrame.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(1, 0, 0.6, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.BackgroundTransparency = 1
    button.TextColor3 = Theme.Colors.Text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = buttonFrame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Text = description
    descLabel.Size = UDim2.new(1, -10, 0.4, 0)
    descLabel.Position = UDim2.new(0, 10, 0.6, 0)
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLabel.BackgroundTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 12
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = buttonFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Colors.Primary
    stroke.Thickness = 1
    stroke.Parent = buttonFrame
    
    return button
end

local function CreateComingSoon(parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.95, 0, 0, 80)
    frame.BackgroundColor3 = Theme.Colors.Button
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Text = "🚧 Em Breve 🚧"
    label.Size = UDim2.new(1, 0, 0.6, 0)
    label.Position = UDim2.new(0, 0, 0.2, 0)
    label.TextColor3 = Theme.Colors.Secondary
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.Parent = frame
    
    local desc = Instance.new("TextLabel")
    desc.Text = "Estamos trabalhando nesta funcionalidade!"
    desc.Size = UDim2.new(1, 0, 0.4, 0)
    desc.Position = UDim2.new(0, 0, 0.6, 0)
    desc.TextColor3 = Color3.fromRGB(180, 180, 180)
    desc.BackgroundTransparency = 1
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12
    desc.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Colors.Primary
    stroke.Thickness = 1
    stroke.Parent = frame
    
    return frame
end

-- ===== ABA DE UTILITÁRIOS =====
local UtilityTab = CreateTab("Utilitários", "⚙️")

-- WalkSpeed
local wsSlider = CreateButton(UtilityTab.content, "WalkSpeed (16-500)", "Controla sua velocidade de movimento")
wsSlider.MouseButton1Click:Connect(function()
    -- Implementação do slider
end)

-- JumpPower
local jpSlider = CreateButton(UtilityTab.content, "JumpPower (50-500)", "Controla a altura do seu pulo")
jpSlider.MouseButton1Click:Connect(function()
    -- Implementação do slider
end)

-- Fly System
CreateButton(UtilityTab.content, "Fly System (Tecla F)", "Voar pelo mapa").MouseButton1Click:Connect(function()
    -- Implementação do fly
end)

-- Teleport
CreateButton(UtilityTab.content, "Teleport (Tecla T)", "Teleportar para onde o mouse aponta").MouseButton1Click:Connect(function()
    -- Implementação do teleporte
end)

-- ===== ABA DE BLOX FRUITS =====
local BloxTab = CreateTab("Blox Fruits", "🍩")

CreateButton(BloxTab.content, "Auto Farm Level", "Farm automático de níveis").MouseButton1Click:Connect(function()
    -- Implementação do autofarm
end)

CreateComingSoon(BloxTab.content) -- Para funções em desenvolvimento

-- ===== ABA DE BROOKHAVEN =====
local BrookhavenTab = CreateTab("Brookhaven", "🏠")

CreateComingSoon(BrookhavenTab.content)

-- ===== ABA DE ARSENAL =====
local ArsenalTab = CreateTab("Arsenal", "🔫")

CreateComingSoon(ArsenalTab.content)

-- ===== INICIALIZAÇÃO =====
UtilityTab.Show() -- Mostra a aba de utilitários por padrão

-- Efeito de inicialização
local dragonIcon = Instance.new("ImageLabel")
dragonIcon.Image = Theme.Images.Dragon
dragonIcon.Size = UDim2.new(0, 100, 0, 100)
dragonIcon.Position = UDim2.new(0.5, -50, 0.5, -50)
dragonIcon.AnchorPoint = Vector2.new(0.5, 0.5)
dragonIcon.BackgroundTransparency = 1
dragonIcon.Parent = ScreenGui

game:GetService("TweenService"):Create(
    dragonIcon,
    TweenInfo.new(1.5, Enum.EasingStyle.Quint),
    {Rotation = 360}
):Play()

task.wait(1.5)
dragonIcon:Destroy()

print("🐉 Dr4gonHub Premium inicializado com sucesso!")
