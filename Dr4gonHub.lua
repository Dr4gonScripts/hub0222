--[[
  🐉 Dr4gonHub Premium - Design Moderno
  Abas laterais com ícones + Área de loja central
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- ===== CONFIGURAÇÃO DO TEMA DR4GONHUB =====
local Theme = {
    Colors = {
        Primary = Color3.fromRGB(188, 10, 28),     -- Vermelho Dr4gon
        Secondary = Color3.fromRGB(255, 212, 96),  -- Dourado
        Background = Color3.fromRGB(15, 15, 20),   -- Preto-azulado
        Text = Color3.fromRGB(240, 240, 240),
        Button = Color3.fromRGB(35, 40, 45),
        Highlight = Color3.fromRGB(220, 50, 50)    -- Vermelho vibrante
    },
    Images = {
        Logo = "rbxassetid://14903454321",        -- Logo do Dr4gonHub
        GameIcons = {
            "rbxassetid://14912345678",           -- Blox Fruits
            "rbxassetid://14912345679",           -- Brookhaven
            "rbxassetid://14912345680"            -- Arsenal
        }
    }
}

-- ===== CRIAÇÃO DA INTERFACE =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dr4gonHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame principal (estilo moderno)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.7, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Theme.Colors.Background
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Borda estilizada
local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Theme.Colors.Primary
FrameStroke.Thickness = 2
FrameStroke.Parent = MainFrame

-- ===== BARRA LATERAL DE ABAS =====
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0.18, 0, 1, 0)          -- Mais larga para ícones
TabBar.BackgroundColor3 = Theme.Colors.Primary
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Vertical
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = TabBar

-- ===== ÁREA DE CONTEÚDO =====
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(0.82, 0, 1, 0)
ContentFrame.Position = UDim2.new(0.18, 0, 0, 0)
ContentFrame.BackgroundColor3 = Theme.Colors.Background
ContentFrame.Parent = MainFrame

-- Cabeçalho (estilo Dr4gon)
local Header = Instance.new("TextLabel")
Header.Text = "DR4GONHUB PREMIUM"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.TextColor3 = Theme.Colors.Secondary
Header.BackgroundColor3 = Theme.Colors.Primary
Header.Font = Enum.Font.GothamBlack
Header.TextSize = 18
Header.Parent = ContentFrame

-- Divisor dourado
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, 0, 0, 2)
Divider.Position = UDim2.new(0, 0, 0, 50)
Divider.BackgroundColor3 = Theme.Colors.Secondary
Divider.BorderSizePixel = 0
Divider.Parent = ContentFrame

-- ===== SISTEMA DE ABAS COM ÍCONES =====
local currentTab = nil
local tabs = {}

local function CreateGameTab(gameName, iconId, index)
    local tabButton = Instance.new("ImageButton")
    tabButton.Image = Theme.Images.GameIcons[index]
    tabButton.Size = UDim2.new(0.8, 0, 0, 70)  -- Botões quadrados
    tabButton.Position = UDim2.new(0.1, 0, 0, 10 + (75 * index))
    tabButton.BackgroundColor3 = Theme.Colors.Button
    tabButton.Parent = TabBar
    
    -- Efeito de hover
    tabButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(
            tabButton,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Theme.Colors.Highlight}
        ):Play()
    end)
    
    tabButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(
            tabButton,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Theme.Colors.Button}
        ):Play()
    end)

    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Size = UDim2.new(1, 0, 1, -60)
    tabContent.Position = UDim2.new(0, 0, 0, 60)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.ScrollBarThickness = 6
    tabContent.Parent = ContentFrame

    local tab = {
        button = tabButton,
        content = tabContent,
        Show = function()
            if currentTab then
                currentTab.content.Visible = false
            end
            currentTab = tab
            tab.content.Visible = true
        end
    }
    
    tabButton.MouseButton1Click:Connect(tab.Show)
    table.insert(tabs, tab)
    return tab
end

-- ===== EXEMPLO DE ABA DE LOJA =====
local ShopTab = CreateGameTab("Shop", 1, 1)

-- Título da seção
local ShopTitle = Instance.new("TextLabel")
ShopTitle.Text = "ITEM SHOP"
ShopTitle.Size = UDim2.new(1, 0, 0, 40)
ShopTitle.Position = UDim2.new(0, 20, 0, 10)
ShopTitle.TextColor3 = Theme.Colors.Secondary
ShopTitle.BackgroundTransparency = 1
ShopTitle.Font = Enum.Font.GothamBold
ShopTitle.TextSize = 16
ShopTitle.TextXAlignment = Enum.TextXAlignment.Left
ShopTitle.Parent = ShopTab.content

-- Item de exemplo (Bait Crate)
local ItemFrame1 = Instance.new("Frame")
ItemFrame1.Size = UDim2.new(0.9, 0, 0, 80)
ItemFrame1.Position = UDim2.new(0.05, 0, 0, 60)
ItemFrame1.BackgroundColor3 = Theme.Colors.Button
ItemFrame1.Parent = ShopTab.content

local ItemName1 = Instance.new("TextLabel")
ItemName1.Text = "Bait Crate"
ItemName1.Size = UDim2.new(0.6, 0, 0, 30)
ItemName1.Position = UDim2.new(0.1, 0, 0, 10)
ItemName1.TextColor3 = Theme.Colors.Text
ItemName1.Font = Enum.Font.GothamMedium
ItemName1.TextSize = 14
ItemName1.TextXAlignment = Enum.TextXAlignment.Left
ItemName1.Parent = ItemFrame1

-- Botão de compra
local BuyButton1 = Instance.new("TextButton")
BuyButton1.Text = "COMPRAR"
BuyButton1.Size = UDim2.new(0.3, 0, 0, 30)
BuyButton1.Position = UDim2.new(0.6, 0, 0, 40)
BuyButton1.BackgroundColor3 = Theme.Colors.Primary
BuyButton1.TextColor3 = Color3.new(1, 1, 1)
BuyButton1.Font = Enum.Font.GothamBold
BuyButton1.TextSize = 12
BuyButton1.Parent = ItemFrame1

-- ===== INICIALIZAÇÃO =====
ShopTab.Show()

-- Efeito de entrada
game:GetService("TweenService"):Create(
    MainFrame,
    TweenInfo.new(0.5),
    {Position = UDim2.new(0.05, 0, 0.2, 0)}
):Play()

print("🐉 Dr4gonHub Premium - Interface carregada!")
