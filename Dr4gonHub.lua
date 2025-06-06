--[[
  Dr4gonHub Premium - Versão Temática Chinesa
  Design: Dragões, lanternas vermelhas e elementos tradicionais
  Funcionalidades: Utilitários + Hubs para jogos populares
]]

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- =============== CONFIGURAÇÃO DO TEMA ===============
local Theme = {
    Colors = {
        Primary = Color3.fromRGB(188, 10, 28),    -- Vermelho chinês
        Secondary = Color3.fromRGB(255, 212, 96), -- Dourado imperial
        Background = Color3.fromRGB(25, 20, 15),  -- Preto lacado
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(87, 20, 28)       -- Vermelho escuro
    },
    Images = {
        Dragon = "rbxassetid://14204253922",      -- Dragão dourado
        Lantern = "rbxassetid://14204257810",     -- Lanterna vermelha
        Pattern = "rbxassetid://14204261233",     -- Padrão de seda
        Seal = "rbxassetid://14204265000"         -- Selo imperial
    },
    Icons = {
        Utility = "⚔️",  -- Espadas cruzadas
        Blox = "🍜",     -- Macarrão da sorte
        Brookhaven = "🏯", -- Pagode
        Arsenal = "🎆",   -- Fogos de artifício
        AdoptMe = "🐉",  -- Dragão
        Settings = "🀄"  -- Peça de mahjong
    },
    Sounds = {
        Open = "rbxassetid://9119658371",        -- Som de gongo
        Click = "rbxassetid://9119659103"        -- Som de sino
    }
}

-- =============== BIBLIOTECA DE UI ===============
local Flux = {
    CurrentTheme = Theme,
    Elements = {}
}

function Flux:CreateElement(type, properties)
    local element = Instance.new(type)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    table.insert(self.Elements, element)
    return element
end

function Flux:Window(name, description)
    local window = {
        Tabs = {},
        UI = {}
    }
    
    -- Cria a janela principal
    function window:BuildUI()
        -- ScreenGui principal
        local screenGui = self:CreateElement("ScreenGui", {
            Name = "DragonHubUI",
            ResetOnSpawn = false,
            Parent = Player:WaitForChild("PlayerGui")
        })
        
        -- Frame principal (biombo chinês)
        local mainFrame = self:CreateElement("Frame", {
            Size = UDim2.new(0.35, 0, 0.6, 0),
            Position = UDim2.new(0.325, 0, 0.2, 0),
            BackgroundColor3 = Theme.Colors.Background,
            BackgroundTransparency = 0.1,
            ClipsDescendants = true,
            Parent = screenGui
        })
        
        -- Padrão de fundo
        self:CreateElement("ImageLabel", {
            Image = Theme.Images.Pattern,
            ImageTransparency = 0.93,
            ScaleType = Enum.ScaleType.Tile,
            TileSize = UDim2.new(0, 100, 0, 100),
            Size = UDim2.new(1, 0, 1, 0),
            Parent = mainFrame
        })
        
        -- Cabeçalho com dragão
        local header = self:CreateElement("Frame", {
            Size = UDim2.new(1, 0, 0.12, 0),
            BackgroundColor3 = Theme.Colors.Primary,
            BorderSizePixel = 0,
            Parent = mainFrame
        })
        
        -- Dragão animado
        local dragon = self:CreateElement("ImageLabel", {
            Image = Theme.Images.Dragon,
            Size = UDim2.new(0.15, 0, 1.5, 0),
            Position = UDim2.new(0.02, 0, -0.25, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Parent = header
        })
        
        -- Animação do dragão
        game:GetService("RunService").Heartbeat:Connect(function(dt)
            dragon.Rotation = math.sin(os.clock() * 2) * 3
        end)
        
        -- Título
        self:CreateElement("TextLabel", {
            Text = "龍王 "..name, -- 龍王 = "Rei Dragão"
            Font = Enum.Font.GothamBold,
            TextSize = 18,
            TextColor3 = Theme.Colors.Secondary,
            Size = UDim2.new(0.7, 0, 0.8, 0),
            Position = UDim2.new(0.2, 0, 0.1, 0),
            BackgroundTransparency = 1,
            Parent = header
        })
        
        -- Lanterna decorativa
        self:CreateElement("ImageLabel", {
            Image = Theme.Images.Lantern,
            Size = UDim2.new(0.1, 0, 0.2, 0),
            Position = UDim2.new(0.9, 0, -0.05, 0),
            BackgroundTransparency = 1,
            Parent = header
        })
        
        -- [...] (Continua com outros elementos UI)
        
        window.UI.MainFrame = mainFrame
        return mainFrame
    end
    
    -- [...] (Implementar MakeTab, AddSection, etc.)
    
    return window
end

-- =============== DR4GONHUB ===============
local Window = Flux:Window("Dr4gonHub", "O Poder do Dragão")
Window:BuildUI()

-- =============== UTILITÁRIOS ===============
local UtilityTab = Window:MakeTab({
    Name = Theme.Icons.Utility .. " Artes Marciais",
    Icon = Theme.Images.Seal
})

UtilityTab:AddSection({Name = "🏮 Controles do Guerreiro"})

-- Slider de velocidade com temática
UtilityTab:AddSlider({
    Name = "Velocidade do Dragão",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(value)
        pcall(function()
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end)
    end
})

-- [...] (Implementar outras abas e funções)

-- Efeito de inicialização
task.spawn(function()
    local sound = Instance.new("Sound")
    sound.SoundId = Theme.Sounds.Open
    sound.Parent = workspace
    sound:Play()
    
    for i = 1, 5 do
        -- Efeito visual de fogos
        print("✨🎆✨ 龍王 Hub Iniciado ✨🎆✨")
        task.wait(0.3)
    end
end)
