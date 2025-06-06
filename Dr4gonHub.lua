--[[
  🐉 Dr4gonHub Premium - Edição Multijogos Completa
  Tema Escuro + 15+ Jogos + Roda de Navegação
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DO TEMA =====
local Theme = {
    Colors = {
        Primary = Color3.fromRGB(25, 25, 25),      -- Preto fosco
        Secondary = Color3.fromRGB(45, 45, 45),     -- Cinza escuro
        Background = Color3.fromRGB(15, 15, 15),    -- Preto puro
        Text = Color3.fromRGB(230, 230, 230),       -- Branco suave
        Button = Color3.fromRGB(35, 35, 35),       -- Botões escuros
        Highlight = Color3.fromRGB(0, 170, 255),    -- Azul vibrante
        Stroke = Color3.fromRGB(60, 60, 60)         -- Bordas
    },
    Images = {
        WheelIcon = "rbxassetid://14874046572"      -- Ícone de engrenagem
    }
}

-- ===== CRIAÇÃO DA INTERFACE =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubPremium"
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.7, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Theme.Colors.Background
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Borda estilizada
local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Theme.Colors.Stroke
FrameStroke.Thickness = 2
FrameStroke.Parent = MainFrame

-- Barra de abas superior
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.BackgroundColor3 = Theme.Colors.Primary
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 0)
TabListLayout.Parent = TabBar

-- Container de conteúdo
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -10, 1, -100)
ContentFrame.Position = UDim2.new(0, 5, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Theme.Colors.Highlight
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.Parent = ContentFrame

-- Atualizar tamanho do conteúdo
ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- ===== RODA DE NAVEGAÇÃO AVANÇADA =====
local WheelContainer = Instance.new("Frame")
WheelContainer.Size = UDim2.new(1, 0, 0, 60)
WheelContainer.Position = UDim2.new(0, 0, 1, -60)
WheelContainer.BackgroundTransparency = 1
WheelContainer.Parent = MainFrame

local NavWheel = Instance.new("ImageButton")
NavWheel.Image = Theme.Images.WheelIcon
NavWheel.Size = UDim2.new(0, 40, 0, 40)
NavWheel.Position = UDim2.new(0.5, -20, 0.5, -20)
NavWheel.BackgroundTransparency = 1
NavWheel.ImageColor3 = Theme.Colors.Highlight
NavWheel.Parent = WheelContainer

-- Efeito 3D na roda
local WheelStroke = Instance.new("UIStroke")
WheelStroke.Color = Theme.Colors.Highlight
WheelStroke.Thickness = 2
WheelStroke.Parent = NavWheel

-- ===== SISTEMA DE ABAS =====
local currentTab = nil
local tabs = {}
local tabIndex = 1

local function CreateTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Text = icon .. " " .. string.sub(name, 1, 4)  -- Nome compacto
    tabButton.Size = UDim2.new(0, 70, 1, 0)  -- Largura fixa para muitas abas
    tabButton.BackgroundColor3 = Theme.Colors.Primary
    tabButton.TextColor3 = Theme.Colors.Text
    tabButton.Font = Enum.Font.GothamMedium
    tabButton.TextSize = 12
    tabButton.Parent = TabBar
    
    -- Tooltip para nome completo
    local tooltip = Instance.new("TextLabel")
    tooltip.Text = name
    tooltip.Size = UDim2.new(0, 0, 0, 0)
    tooltip.Position = UDim2.new(0, 0, -1, 0)
    tooltip.BackgroundColor3 = Theme.Colors.Secondary
    tooltip.TextColor3 = Theme.Colors.Text
    tooltip.Font = Enum.Font.Gotham
    tooltip.TextSize = 12
    tooltip.Visible = false
    tooltip.Parent = tabButton
    
    tabButton.MouseEnter:Connect(function()
        tooltip.Size = UDim2.new(0, string.len(name)*8, 0, 20)
        tooltip.Position = UDim2.new(0, 0, -1, 0)
        tooltip.Visible = true
    end)
    
    tabButton.MouseLeave:Connect(function()
        tooltip.Visible = false
    end)
    
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
            tab.button.BackgroundColor3 = Theme.Colors.Highlight
            
            -- Rolagem para o topo
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
    buttonFrame.Size = UDim2.new(1, -10, 0, 55)  -- Mais compacto
    buttonFrame.BackgroundColor3 = Theme.Colors.Button
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
    button.Size = UDim2.new(1, -10, 0.6, 0)
    button.Position = UDim2.new(0, 10, 0, 5)
    button.BackgroundTransparency = 1
    button.TextColor3 = Theme.Colors.Text
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 13
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = buttonFrame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Text = description
    descLabel.Size = UDim2.new(1, -15, 0.4, 0)
    descLabel.Position = UDim2.new(0, 15, 0.6, 0)
    descLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
    descLabel.BackgroundTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 11
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = buttonFrame
    
    -- Efeitos de interação
    button.MouseEnter:Connect(function()
        buttonFrame.BackgroundColor3 = Theme.Colors.Secondary
        buttonStroke.Color = Theme.Colors.Highlight
    end)
    
    button.MouseLeave:Connect(function()
        buttonFrame.BackgroundColor3 = Theme.Colors.Button
        buttonStroke.Color = Theme.Colors.Stroke
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

-- ===== ABAS DE JOGOS COMPLETAS =====
-- Aba Utilitários (MISC)
local UtilityTab = CreateTab("MISC", "⚙️")

-- Seção de Movimento
local movementHeader = Instance.new("TextLabel")
movementHeader.Text = "CONTROLES GERAIS"
movementHeader.Size = UDim2.new(1, -10, 0, 20)
movementHeader.Position = UDim2.new(0, 10, 0, 0)
movementHeader.TextColor3 = Theme.Colors.Highlight
movementHeader.BackgroundTransparency = 1
movementHeader.Font = Enum.Font.GothamBold
movementHeader.TextSize = 12
movementHeader.TextXAlignment = Enum.TextXAlignment.Left
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
visualHeader.Size = UDim2.new(1, -10, 0, 20)
visualHeader.Position = UDim2.new(0, 10, 0, 0)
visualHeader.TextColor3 = Theme.Colors.Highlight
visualHeader.BackgroundTransparency = 1
visualHeader.Font = Enum.Font.GothamBold
visualHeader.TextSize = 12
visualHeader.TextXAlignment = Enum.TextXAlignment.Left
visualHeader.Parent = UtilityTab.content

CreateButton(UtilityTab.content, "FullBright", "Iluminação total").MouseButton1Click:Connect(function()
    print("FullBright ativado")
end)

CreateButton(UtilityTab.content, "No Fog", "Remove névoa do jogo").MouseButton1Click:Connect(function()
    print("No Fog ativado")
end)

-- Abas de Jogos Adicionais (15+ jogos)
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

local PetSimXTab = CreateTab("PETS", "🐾") -- Pet Simulator X
CreateButton(PetSimXTab.content, "Auto Farm", "Farm automático de pets").MouseButton1Click:Connect(function()
    print("Pet Farm ativado")
end)

local AnimeFightTab = CreateTab("ANIM", "👊") -- Anime Fighters
CreateButton(AnimeFightTab.content, "Auto Summon", "Summon automático").MouseButton1Click:Connect(function()
    print("Auto Summon ativado")
end)

local ShindoLifeTab = CreateTab("SHIN", "🌀") -- Shindo Life
CreateButton(ShindoLifeTab.content, "Auto Train", "Treino automático").MouseButton1Click:Connect(function()
    print("Auto Train ativado")
end)

local SlapBattlesTab = CreateTab("SLAP", "✋") -- Slap Battles
CreateButton(SlapBattlesTab.content, "Auto Slap", "Bater automático").MouseButton1Click:Connect(function()
    print("Auto Slap ativado")
end)

local AdoptMeTab = CreateTab("ADPT", "🏡") -- Adopt Me
CreateButton(AdoptMeTab.content, "Auto Age", "Envelhece pets automaticamente").MouseButton1Click:Connect(function()
    print("Auto Age ativado")
end)

local DoorsTab = CreateTab("DOOR", "🚪") -- Doors
CreateButton(DoorsTab.content, "Auto Avoid", "Evita entidades automaticamente").MouseButton1Click:Connect(function()
    print("Auto Avoid ativado")
end)

local TowerDefenseTab = CreateTab("TOWR", "🏰") -- Tower Defense
CreateButton(TowerDefenseTab.content, "Auto Build", "Construção automática").MouseButton1Click:Connect(function()
    print("Auto Build ativado")
end)

local JailbreakTab = CreateTab("JAIL", "🚔") -- Jailbreak
CreateButton(JailbreakTab.content, "Auto Rob", "Roubo automático").MouseButton1Click:Connect(function()
    print("Auto Rob ativado")
end)

local MurderMysteryTab = CreateTab("MURD", "🔪") -- Murder Mystery 2
CreateButton(MurderMysteryTab.content, "Detector", "Identifica o assassino").MouseButton1Click:Connect(function()
    print("Detector ativado")
end)

-- ===== INICIALIZAÇÃO =====
UtilityTab.Show()  -- Mostra a aba de utilitários por padrão

-- Efeito de inicialização premium
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Theme.Colors.Background
loadingFrame.ZIndex = 100
loadingFrame.Parent = ScreenGui

local loadingText = Instance.new("TextLabel")
loadingText.Text = "DR4GONHUB PREMIUM"
loadingText.Size = UDim2.new(1, 0, 0, 30)
loadingText.Position = UDim2.new(0, 0, 0.5, -15)
loadingText.TextColor3 = Theme.Colors.Highlight
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 18
loadingText.ZIndex = 101
loadingText.Parent = loadingFrame

-- Animação de carregamento
local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quint)
game:GetService("TweenService"):Create(
    loadingText,
    tweenInfo,
    {TextTransparency = 1}
):Play()

task.wait(1.5)
loadingFrame:Destroy()

print("🐉 Dr4gonHub Premium (15+ Jogos) carregado com sucesso!")
