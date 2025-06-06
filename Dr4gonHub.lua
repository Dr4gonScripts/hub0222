--[[
  🐉 Dr4gonHub Premium - Edição Multijogos
  Versão Modificada: Tema Escuro + Roda de Navegação
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DO TEMA ATUALIZADO =====
local Theme = {
    Colors = {
        Primary = Color3.fromRGB(50, 50, 50),       -- Cinza escuro
        Secondary = Color3.fromRGB(80, 80, 80),      -- Cinza médio
        Background = Color3.fromRGB(10, 10, 10),     -- Preto puro
        Text = Color3.fromRGB(220, 220, 220),       -- Cinza claro
        Button = Color3.fromRGB(30, 30, 30),        -- Preto acinzentado
        Highlight = Color3.fromRGB(0, 120, 215)     -- Azul para destaques
    },
    Images = {
        Dragon = "rbxassetid://14204253922",
        Pattern = "rbxassetid://14204261233",
        WheelIcon = "rbxassetid://14307954021"  -- Ícone para a roda de navegação
    }
}

-- ===== CRIAÇÃO DA INTERFACE ATUALIZADA =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame principal com tema escuro
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.3, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Theme.Colors.Background
MainFrame.Parent = ScreenGui

-- Barra de abas estilizada
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)  -- Mais compacta
TabBar.BackgroundColor3 = Theme.Colors.Primary
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 1)  -- Menos espaçamento
TabListLayout.Parent = TabBar

-- Container de conteúdo com rolagem
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, 0, 1, -90)  -- Espaço para a roda
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 5
ContentFrame.ScrollBarImageColor3 = Theme.Colors.Highlight
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.Parent = ContentFrame

-- ===== RODA DE NAVEGAÇÃO =====
local WheelContainer = Instance.new("Frame")
WheelContainer.Size = UDim2.new(1, 0, 0, 50)
WheelContainer.Position = UDim2.new(0, 0, 1, -50)
WheelContainer.BackgroundTransparency = 1
WheelContainer.Parent = MainFrame

local NavWheel = Instance.new("ImageButton")
NavWheel.Image = Theme.Images.WheelIcon
NavWheel.Size = UDim2.new(0, 40, 0, 40)
NavWheel.Position = UDim2.new(0.5, -20, 0.5, -20)
NavWheel.BackgroundTransparency = 1
NavWheel.Parent = WheelContainer

-- Animação da roda
local wheelRotation = 0
NavWheel.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        NavWheel,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
        {Rotation = 360}
    ):Play()
    task.wait(0.5)
    NavWheel.Rotation = 0
end)

-- Função para navegar entre abas
local tabIndex = 1
NavWheel.MouseButton1Click:Connect(function()
    tabIndex = tabIndex + 1
    if tabIndex > #tabs then tabIndex = 1 end
    tabs[tabIndex].Show()
end)

-- ===== SISTEMA DE ABAS ATUALIZADO =====
local currentTab = nil
local tabs = {}

local function CreateTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Text = icon .. " " .. name
    tabButton.Size = UDim2.new(0.25, 0, 1, 0)
    tabButton.BackgroundColor3 = Theme.Colors.Primary
    tabButton.TextColor3 = Theme.Colors.Text
    tabButton.Font = Enum.Font.GothamMedium  -- Fonte mais limpa
    tabButton.TextSize = 12  -- Tamanho menor
    tabButton.Parent = TabBar
    
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 0, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.AutomaticSize = Enum.AutomaticSize.Y
    tabContent.Parent = ContentFrame
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 8)  -- Espaçamento menor
    tabLayout.Parent = tabContent
    
    local tab = {
        button = tabButton,
        content = tabContent,
        Show = function()
            if currentTab then
                currentTab.content.Visible = false
                currentTab.button.BackgroundColor3 = Theme.Colors.Primary
                currentTab.button.TextColor3 = Theme.Colors.Text
            end
            currentTab = tab
            tab.content.Visible = true
            tab.button.BackgroundColor3 = Theme.Colors.Highlight
            tab.button.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    }
    
    tabButton.MouseButton1Click:Connect(tab.Show)
    table.insert(tabs, tab)
    return tab
end

-- ===== COMPONENTES DA UI ATUALIZADOS =====
local function CreateButton(parent, text, description)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(0.95, 0, 0, 50)  -- Mais compacto
    buttonFrame.BackgroundColor3 = Theme.Colors.Button
    buttonFrame.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Text = "• " .. text  -- Marcador visual
    button.Size = UDim2.new(1, 0, 0.7, 0)
    button.Position = UDim2.new(0, 10, 0, 0)  -- Alinhamento à esquerda
    button.BackgroundTransparency = 1
    button.TextColor3 = Theme.Colors.Text
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 13
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = buttonFrame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Text = description
    descLabel.Size = UDim2.new(1, -15, 0.3, 0)
    descLabel.Position = UDim2.new(0, 15, 0.7, 0)
    descLabel.TextColor3 = Color3.fromRGB(150, 150, 150)  -- Texto mais suave
    descLabel.BackgroundTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 11
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = buttonFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Colors.Secondary
    stroke.Thickness = 1
    stroke.Parent = buttonFrame
    
    -- Efeito hover
    button.MouseEnter:Connect(function()
        buttonFrame.BackgroundColor3 = Theme.Colors.Secondary
    end)
    
    button.MouseLeave:Connect(function()
        buttonFrame.BackgroundColor3 = Theme.Colors.Button
    end)
    
    return button
end

-- ===== ABA DE UTILITÁRIOS REORGANIZADA =====
local UtilityTab = CreateTab("MISC", "⚙️")

-- Seção de Movimento
local movementSection = Instance.new("TextLabel")
movementSection.Text = "MOVIMENTO"
movementSection.Size = UDim2.new(0.95, 0, 0, 20)
movementSection.Position = UDim2.new(0, 10, 0, 0)
movementSection.TextColor3 = Theme.Colors.Highlight
movementSection.BackgroundTransparency = 1
movementSection.Font = Enum.Font.GothamBold
movementSection.TextSize = 12
movementSection.TextXAlignment = Enum.TextXAlignment.Left
movementSection.Parent = UtilityTab.content

CreateButton(UtilityTab.content, "WalkSpeed (16-500)", "Ajuste sua velocidade de movimento").MouseButton1Click:Connect(function()
    -- Implementação do slider
end)

CreateButton(UtilityTab.content, "JumpPower (50-500)", "Controle a altura do pulo").MouseButton1Click:Connect(function()
    -- Implementação do slider
end)

CreateButton(UtilityTab.content, "Fly (Tecla F)", "Ativar/desativar voo").MouseButton1Click:Connect(function()
    -- Implementação do fly
end)

-- Seção de Teleporte
local teleportSection = Instance.new("TextLabel")
teleportSection.Text = "TELEPORTE"
teleportSection.Size = UDim2.new(0.95, 0, 0, 20)
teleportSection.Position = UDim2.new(0, 10, 0, 0)
teleportSection.TextColor3 = Theme.Colors.Highlight
teleportSection.BackgroundTransparency = 1
teleportSection.Font = Enum.Font.GothamBold
teleportSection.TextSize = 12
teleportSection.TextXAlignment = Enum.TextXAlignment.Left
teleportSection.Parent = UtilityTab.content

CreateButton(UtilityTab.content, "Teleport (Tecla T)", "Teleporte para onde o mouse aponta").MouseButton1Click:Connect(function()
    -- Implementação do teleporte
end)

CreateButton(UtilityTab.content, "TP para Jogador", "Selecione um jogador para teleportar").MouseButton1Click:Connect(function()
    -- Implementação do TP para jogador
end)

-- ===== ABAS DE JOGOS =====
local BloxTab = CreateTab("Blox Fruits", "🍩")
CreateButton(BloxTab.content, "Auto Farm", "Farm automático de níveis").MouseButton1Click:Connect(function()
    -- Implementação do autofarm
end)

local BrookhavenTab = CreateTab("Brookhaven", "🏠")
CreateButton(BrookhavenTab.content, "Auto Correr", "Corrida automática").MouseButton1Click:Connect(function()
    -- Implementação
end)

local ArsenalTab = CreateTab("Arsenal", "🔫")
CreateButton(ArsenalTab.content, "Aimbot", "Melhora sua mira").MouseButton1Click:Connect(function()
    -- Implementação
end)

-- ===== INICIALIZAÇÃO =====
UtilityTab.Show()  -- Mostra a aba de utilitários por padrão

-- Efeito de inicialização minimalista
local loadingText = Instance.new("TextLabel")
loadingText.Text = "DR4GONHUB PREMIUM"
loadingText.Size = UDim2.new(1, 0, 0, 30)
loadingText.Position = UDim2.new(0, 0, 0.5, -15)
loadingText.TextColor3 = Theme.Colors.Highlight
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 16
loadingText.Parent = ScreenGui

game:GetService("TweenService"):Create(
    loadingText,
    TweenInfo.new(1, Enum.EasingStyle.Quad),
    {TextTransparency = 1}
):Play()

task.wait(1)
loadingText:Destroy()

print("🐉 Dr4gonHub Premium (Dark Edition) inicializado!")
