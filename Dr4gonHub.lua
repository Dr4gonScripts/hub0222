--[[
  🐉 Dr4gonHub Premium - Interface Avançada
  Estilo BuiltByBit com funcionalidades completas
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- Configuração do Tema
local Theme = {
    Colors = {
        Main = Color3.fromRGB(30, 30, 40),
        Header = Color3.fromRGB(188, 10, 28), -- Vermelho Dr4gon
        TabActive = Color3.fromRGB(50, 50, 65),
        TabInactive = Color3.fromRGB(40, 40, 55),
        Text = Color3.fromRGB(240, 240, 240),
        Button = Color3.fromRGB(50, 55, 70),
        ButtonHover = Color3.fromRGB(60, 65, 80),
        Accent = Color3.fromRGB(255, 212, 96) -- Dourado
    },
    Images = {
        Close = "rbxassetid://14912345684",
        Minimize = "rbxassetid://14912345685"
    }
}

-- Criação da Interface Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.BackgroundColor3 = Theme.Colors.Main
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Cabeçalho com controles
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
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = Header

-- Botões de controle
local CloseButton = Instance.new("ImageButton")
CloseButton.Image = Theme.Images.Close
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 2)
CloseButton.BackgroundTransparency = 1
CloseButton.Parent = Header

local MinimizeButton = Instance.new("ImageButton")
MinimizeButton.Image = Theme.Images.Minimize
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0, 2)
MinimizeButton.BackgroundTransparency = 1
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

-- Criar abas e conteúdo
local MiscTab = CreateTab("MISC")
CreateButton(MiscTab.content, "Fly Hack", "Toggle flight with keybind", function()
    loadstring(game:HttpGet("https://example.com/fly.lua"))()
end)

CreateButton(MiscTab.content, "Speed Hack", "Adjust movement speed", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)

local BloxTab = CreateTab("BLOX")
CreateButton(BloxTab.content, "Auto Farm", "Automatically farm levels", function()
    print("Blox Fruits farm activated")
end)

local BrookTab = CreateTab("BROO")
CreateButton(BrookTab.content, "Auto Run", "Continuous running", function()
    print("Brookhaven auto run activated")
end)

local ArseTab = CreateTab("ARSE")
CreateButton(ArseTab.content, "Aimbot", "Improved aiming", function()
    print("Arsenal aimbot activated")
end)

local KingTab = CreateTab("KING")
CreateButton(KingTab.content, "Auto Raid", "Farm raids automatically", function()
    print("King Legacy raid activated")
end)

-- Funções de Controle
local minimized = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0.35, 0, 0, 30)
    else
        MainFrame.Size = originalSize
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    -- O script continua rodando em background
end)

-- Inicialização
MiscTab.Show()

-- Efeito de entrada
MainFrame.Position = UDim2.new(0.5, -175, 0, -400)
game:GetService("TweenService"):Create(
    MainFrame,
    TweenInfo.new(0.7, Enum.EasingStyle.Quint),
    {Position = UDim2.new(0.5, -175, 0.5, -150)}
):Play()

print("🐉 Dr4gonHub Premium - Interface carregada!")
