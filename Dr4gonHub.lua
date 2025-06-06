--[[
  🐉 Dr4gonHub Premium - Edição Definitiva
  Tema Escuro + 15+ Jogos + Sistema Completo
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DO TEMA =====
local Theme = {
    Colors = {
        Primary = Color3.fromRGB(20, 20, 20),       -- Preto fosco
        Secondary = Color3.fromRGB(40, 40, 40),     -- Cinza escuro
        Background = Color3.fromRGB(10, 10, 10),     -- Preto puro
        Text = Color3.fromRGB(240, 240, 240),       -- Branco suave
        Button = Color3.fromRGB(30, 30, 30),        -- Botões escuros
        Highlight = Color3.fromRGB(0, 180, 255),    -- Azul vibrante
        Stroke = Color3.fromRGB(70, 70, 70),        -- Bordas
        Watermark = Color3.fromRGB(255, 255, 255)   -- Marca d'água
    },
    Images = {
        WheelIcon = "rbxassetid://14874046572",     -- Ícone de engrenagem
        Background = "rbxassetid://14903411254",    -- Fundo anime/manga
        Logo = "rbxassetid://14903454321"           -- Logo do script
    }
}

-- ===== CRIAÇÃO DA INTERFACE =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubPremium"
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame principal com fundo de anime
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.7, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Theme.Colors.Background
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Fundo de anime com transparência
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Image = Theme.Images.Background
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.ImageTransparency = 0.9  -- 90% transparente
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.Parent = MainFrame

-- Overlay escuro para melhor legibilidade
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.7
Overlay.Parent = MainFrame

-- Borda estilizada
local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Theme.Colors.Highlight
FrameStroke.Thickness = 2
FrameStroke.Parent = MainFrame

-- ===== BARRA DE ABAS SUPERIOR =====
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.BackgroundColor3 = Theme.Colors.Primary
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 2
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 0)
TabListLayout.Parent = TabBar

-- ===== CONTAINER DE CONTEÚDO COM SCROLL =====
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -10, 1, -100)
ContentFrame.Position = UDim2.new(0, 5, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 8
ContentFrame.ScrollBarImageColor3 = Theme.Colors.Highlight
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.ZIndex = 2
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 12)
ContentLayout.Parent = ContentFrame

-- Atualizar tamanho do conteúdo automaticamente
ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 30)
end)

-- ===== RODA DE NAVEGAÇÃO =====
local WheelContainer = Instance.new("Frame")
WheelContainer.Size = UDim2.new(1, 0, 0, 60)
WheelContainer.Position = UDim2.new(0, 0, 1, -60)
WheelContainer.BackgroundTransparency = 1
WheelContainer.ZIndex = 2
WheelContainer.Parent = MainFrame

local NavWheel = Instance.new("ImageButton")
NavWheel.Image = Theme.Images.WheelIcon
NavWheel.Size = UDim2.new(0, 45, 0, 45)
NavWheel.Position = UDim2.new(0.5, -22.5, 0.5, -22.5)
NavWheel.BackgroundTransparency = 1
NavWheel.ImageColor3 = Theme.Colors.Highlight
NavWheel.ZIndex = 3
NavWheel.Parent = WheelContainer

-- Efeito 3D na roda
local WheelStroke = Instance.new("UIStroke")
WheelStroke.Color = Theme.Colors.Highlight
WheelStroke.Thickness = 2
WheelStroke.Parent = NavWheel

-- ===== MARCA D'ÁGUA =====
local Watermark = Instance.new("TextLabel")
Watermark.Text = "Dr4gonHub Premium"
Watermark.Size = UDim2.new(0, 200, 0, 30)
Watermark.Position = UDim2.new(1, -210, 1, -35)
Watermark.TextColor3 = Theme.Colors.Watermark
Watermark.BackgroundTransparency = 1
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 14
Watermark.TextTransparency = 0.7
Watermark.TextXAlignment = Enum.TextXAlignment.Right
Watermark.ZIndex = 2
Watermark.Parent = MainFrame

-- Logo do script
local Logo = Instance.new("ImageLabel")
Logo.Image = Theme.Images.Logo
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Position = UDim2.new(1, -40, 1, -35)
Logo.BackgroundTransparency = 1
Logo.ImageTransparency = 0.7
Logo.ZIndex = 2
Logo.Parent = MainFrame

-- ===== SISTEMA DE ABAS =====
local currentTab = nil
local tabs = {}
local tabIndex = 1

local function CreateTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Text = icon .. " " .. string.sub(name, 1, 4)
    tabButton.Size = UDim2.new(0, 70, 1, 0)
    tabButton.BackgroundColor3 = Theme.Colors.Primary
    tabButton.TextColor3 = Theme.Colors.Text
    tabButton.Font = Enum.Font.GothamMedium
    tabButton.TextSize = 12
    tabButton.ZIndex = 3
    tabButton.Parent = TabBar
    
    -- Tooltip para nome completo
    local tooltip = Instance.new("TextLabel")
    tooltip.Text = name
    tooltip.Size = UDim2.new(0, 0, 0, 20)
    tooltip.Position = UDim2.new(0, 0, -1, 0)
    tooltip.BackgroundColor3 = Theme.Colors.Secondary
    tooltip.TextColor3 = Theme.Colors.Text
    tooltip.Font = Enum.Font.Gotham
    tooltip.TextSize = 11
    tooltip.Visible = false
    tooltip.ZIndex = 5
    tooltip.Parent = tabButton
    
    tabButton.MouseEnter:Connect(function()
        tooltip.Size = UDim2.new(0, string.len(name)*7 + 10, 0, 20)
        tooltip.Position = UDim2.new(0, 0, -1, 0)
        tooltip.Visible = true
        
        -- Efeito hover
        game:GetService("TweenService"):Create(
            tabButton,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Theme.Colors.Secondary}
        ):Play()
    end)
    
    tabButton.MouseLeave:Connect(function()
        tooltip.Visible = false
        if currentTab and currentTab.button ~= tabButton then
            game:GetService("TweenService"):Create(
                tabButton,
                TweenInfo.new(0.2),
                {BackgroundColor3 = Theme.Colors.Primary}
            ):Play()
        end
    end)
    
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 0, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.AutomaticSize = Enum.AutomaticSize.Y
    tabContent.ZIndex = 2
    tabContent.Parent = ContentFrame
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 12)
    tabLayout.Parent = tabContent
    
    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.Size = UDim2.new(1, 0, 0, tabLayout.AbsoluteContentSize.Y)
    end)
    
    local tab = {
        button = tabButton,
        content = tabContent,
        Show = function()
            if currentTab then
                currentTab.content.Visible = false
                game:GetService("TweenService"):Create(
                    currentTab.button,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = Theme.Colors.Primary}
                ):Play()
            end
            
            currentTab = tab
            tab.content.Visible = true
            game:GetService("TweenService"):Create(
                tab.button,
                TweenInfo.new(0.2),
                {BackgroundColor3 = Theme.Colors.Highlight}
            ):Play()
            
            ContentFrame.CanvasPosition = Vector2.new(0, 0)
        end
    }
    
    tabButton.MouseButton1Click:Connect(function()
        for i, t in ipairs(tabs) do
            if t == tab then
                tabIndex = i
                break
            end
        end
        tab.Show()
    end)
    
    table.insert(tabs, tab)
    return tab
end

-- ===== BOTÕES ESTILIZADOS =====
local function CreateButton(parent, text, description)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, -10, 0, 60)
    buttonFrame.BackgroundColor3 = Theme.Colors.Button
    buttonFrame.ZIndex = 2
    buttonFrame.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = buttonFrame
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Theme.Colors.Stroke
    buttonStroke.Thickness = 1
    buttonStroke.Parent = buttonFrame
    
    local button = Instance.new("TextButton")
    button.Text = "• " .. text
    button.Size = UDim2.new(1, -15, 0.6, 0)
    button.Position = UDim2.new(0, 15, 0, 5)
    button.BackgroundTransparency = 1
    button.TextColor3 = Theme.Colors.Text
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.ZIndex = 3
    button.Parent = buttonFrame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Text = description
    descLabel.Size = UDim2.new(1, -20, 0.4, 0)
    descLabel.Position = UDim2.new(0, 20, 0.6, 0)
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLabel.BackgroundTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 12
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.ZIndex = 3
    descLabel.Parent = buttonFrame
    
    -- Efeitos de interação
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(
            buttonFrame,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Theme.Colors.Secondary}
        ):Play()
        game:GetService("TweenService"):Create(
            buttonStroke,
            TweenInfo.new(0.2),
            {Color = Theme.Colors.Highlight}
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(
            buttonFrame,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Theme.Colors.Button}
        ):Play()
        game:GetService("TweenService"):Create(
            buttonStroke,
            TweenInfo.new(0.2),
            {Color = Theme.Colors.Stroke}
        ):Play()
    end)
    
    return button
end

-- ===== FUNCIONALIDADE DA RODA =====
NavWheel.MouseButton1Click:Connect(function()
    tabIndex = (tabIndex % #tabs) + 1
    tabs[tabIndex].Show()
    
    -- Animação de rotação suave
    game:GetService("TweenService"):Create(
        NavWheel,
        TweenInfo.new(0.4, Enum.EasingStyle.Quad),
        {Rotation = NavWheel.Rotation + 180}
    ):Play()
end)

-- ===== ABAS DE JOGOS =====
-- Aba Utilitários (MISC)
local UtilityTab = CreateTab("MISC", "⚙️")

-- Seção de Movimento
local movementHeader = Instance.new("TextLabel")
movementHeader.Text = "CONTROLES GERAIS"
movementHeader.Size = UDim2.new(1, -10, 0, 25)
movementHeader.Position = UDim2.new(0, 15, 0, 0)
movementHeader.TextColor3 = Theme.Colors.Highlight
movementHeader.BackgroundTransparency = 1
movementHeader.Font = Enum.Font.GothamBold
movementHeader.TextSize = 13
movementHeader.TextXAlignment = Enum.TextXAlignment.Left
movementHeader.ZIndex = 3
movementHeader.Parent = UtilityTab.content

CreateButton(UtilityTab.content, "WalkSpeed", "16-500 (Shift + Scroll)").MouseButton1Click:Connect(function()
    print("WalkSpeed ativado")
end)

CreateButton(UtilityTab.content, "JumpPower", "50-500 (Ctrl + Scroll)").MouseButton1Click:Connect(function()
    print("JumpPower ativado")
end)

CreateButton(UtilityTab.content, "Sistema de Voo", "Tecla F para alternar").MouseButton1Click:Connect(function()
    print("Voo ativado")
end)

-- Seção Visual
local visualHeader = Instance.new("TextLabel")
visualHeader.Text = "VISUAL"
visualHeader.Size = UDim2.new(1, -10, 0, 25)
visualHeader.Position = UDim2.new(0, 15, 0, 0)
visualHeader.TextColor3 = Theme.Colors.Highlight
visualHeader.BackgroundTransparency = 1
visualHeader.Font = Enum.Font.GothamBold
visualHeader.TextSize = 13
visualHeader.TextXAlignment = Enum.TextXAlignment.Left
visualHeader.ZIndex = 3
visualHeader.Parent = UtilityTab.content

CreateButton(UtilityTab.content, "FullBright", "Iluminação total").MouseButton1Click:Connect(function()
    print("FullBright ativado")
end)

CreateButton(UtilityTab.content, "No Fog", "Remove névoa do jogo").MouseButton1Click:Connect(function()
    print("No Fog ativado")
end)

-- Abas de Jogos (15+ jogos)
local BloxTab = CreateTab("BLOX", "🍩") -- Blox Fruits
CreateButton(BloxTab.content, "Auto Farm", "Farm automático de níveis").MouseButton1Click:Connect(function()
    print("Farm Blox Fruits ativado")
end)

local BrookhavenTab = CreateTab("BROOK", "🏠") -- Brookhaven
CreateButton(BrookhavenTab.content, "Auto Corrida", "Corre automaticamente").MouseButton1Click:Connect(function()
    print("Auto Corrida ativado")
end)

local ArsenalTab = CreateTab("ARSE", "🔫") -- Arsenal
CreateButton(ArsenalTab.content, "Silent Aim", "Melhora sua mira").MouseButton1Click:Connect(function()
    print("Silent Aim ativado")
end)

local KingLegacyTab = CreateTab("KING", "👑") -- King Legacy
CreateButton(KingLegacyTab.content, "Auto Raid", "Farm automático de raids").MouseButton1Click:Connect(function()
    print("Auto Raid ativado")
end)

local GrowAGardenTab = CreateTab("GROW", "🌱") -- Grow a Garden
CreateButton(GrowAGardenTab.content, "Auto Water", "Rega automática").MouseButton1Click:Connect(function()
    print("Auto Water ativado")
end)

local BlueLockTab = CreateTab("BLUE", "⚽") -- Blue Lock Rivals
CreateButton(BlueLockTab.content, "Auto Score", "Gols automáticos").MouseButton1Click:Connect(function()
    print("Auto Score ativado")
end)

-- ... (adicione as outras abas de jogos seguindo o mesmo padrão)

-- ===== INICIALIZAÇÃO =====
UtilityTab.Show()

-- Efeito de inicialização premium
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadingFrame.ZIndex = 100
loadingFrame.Parent = ScreenGui

local loadingText = Instance.new("TextLabel")
loadingText.Text = "DR4GONHUB PREMIUM"
loadingText.Size = UDim2.new(1, 0, 0, 40)
loadingText.Position = UDim2.new(0, 0, 0.5, -20)
loadingText.TextColor3 = Theme.Colors.Highlight
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 20
loadingText.ZIndex = 101
loadingText.Parent = loadingFrame

local loadingLogo = Instance.new("ImageLabel")
loadingLogo.Image = Theme.Images.Logo
loadingLogo.Size = UDim2.new(0, 80, 0, 80)
loadingLogo.Position = UDim2.new(0.5, -40, 0.5, -100)
loadingLogo.BackgroundTransparency = 1
loadingLogo.ZIndex = 101
loadingLogo.Parent = loadingFrame

-- Animação de carregamento
game:GetService("TweenService"):Create(
    loadingText,
    TweenInfo.new(1.5, Enum.EasingStyle.Quint),
    {TextTransparency = 1}
):Play()

game:GetService("TweenService"):Create(
    loadingLogo,
    TweenInfo.new(1.5, Enum.EasingStyle.Quint),
    {ImageTransparency = 1}
):Play()

task.wait(1.5)
loadingFrame:Destroy()

print("🐉 Dr4gonHub Premium (Edição Definitiva) carregado com sucesso!")
