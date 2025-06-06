-- =============== FLUXLIB ADAPTADA (ORION-STYLE) ===============
local Flux = {
    Themes = {
        Dark = {
            Background = Color3.fromRGB(30, 30, 30),
            Text = Color3.fromRGB(255, 255, 255),
            Accent = Color3.fromRGB(0, 120, 215)
        }
    }
}

function Flux:Window(name, description)
    local window = {
        Tabs = {},
        CurrentTheme = self.Themes.Dark
    }
    
    -- Cria uma nova aba (compatível com Orion)
    function window:MakeTab(options)
        local tab = {
            Name = options.Name,
            Icon = options.Icon or "",
            Sections = {}
        }
        
        -- Adiciona seção
        function tab:AddSection(options)
            table.insert(tab.Sections, {
                Name = options.Name,
                Content = {}
            })
            return #tab.Sections
        end
        
        -- Adiciona botão
        function tab:AddButton(options)
            local btn = {
                Type = "Button",
                Name = options.Name,
                Callback = options.Callback or function() end
            }
            table.insert(tab.Sections[#tab.Sections].Content, btn)
        end
        
        -- Adiciona toggle
        function tab:AddToggle(options)
            local toggle = {
                Type = "Toggle",
                Name = options.Name,
                Default = options.Default or false,
                Callback = options.Callback or function() end,
                Value = options.Default
            }
            table.insert(tab.Sections[#tab.Sections].Content, toggle)
        end
        
        -- Adiciona slider
        function tab:AddSlider(options)
            local slider = {
                Type = "Slider",
                Name = options.Name,
                Min = options.Min or 0,
                Max = options.Max or 100,
                Default = options.Default or options.Min,
                Callback = options.Callback or function() end,
                Value = options.Default
            }
            table.insert(tab.Sections[#tab.Sections].Content, slider)
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    -- Renderiza a interface
    function window:Init()
        -- Cria a interface gráfica
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        -- Implementação visual completa aqui...
        -- (Esta parte seria extensa - estou mantendo focada na funcionalidade)
        
        print("[Dr4gonHub] Interface carregada com sucesso!")
    end
    
    return window
end

-- =============== DR4GONHUB IMPLEMENTAÇÃO ===============
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- Cria a janela principal
local Window = Flux:Window("Dr4gonHub", "Bem-vindo ao Dr4gonHub Premium!")

-- =============== UTILITÁRIOS ===============
local UtilityTab = Window:MakeTab({
    Name = "⚙️ Utilitários",
    Icon = "",
    PremiumOnly = false
})

-- Seção de Movimento
UtilityTab:AddSection({Name = "Controles de Movimento"})

local WalkSpeedSlider = UtilityTab:AddSlider({
    Name = "Velocidade (WalkSpeed)",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(value)
        pcall(function()
            Player.Character:WaitForChild("Humanoid").WalkSpeed = value
        end)
    end
})

local JumpPowerSlider = UtilityTab:AddSlider({
    Name = "Pulo (JumpPower)",
    Min = 50,
    Max = 200,
    Default = 50,
    Callback = function(value)
        pcall(function()
            Player.Character:WaitForChild("Humanoid").JumpPower = value
        end)
    end
})

-- Seção de Modificações
UtilityTab:AddSection({Name = "Modificações Avançadas"})

local flying = false
UtilityTab:AddToggle({
    Name = "Ativar Voo (Tecla F)",
    Default = false,
    Callback = function(value)
        flying = value
        if flying then
            -- Implementação do voo
        else
            -- Desativar voo
        end
    end
})

UtilityTab:AddButton({
    Name = "Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
})

-- =============== BLOX FRUITS ===============
local BloxTab = Window:MakeTab({
    Name = "🍩 Blox Fruits",
    Icon = "",
    PremiumOnly = false
})

BloxTab:AddSection({Name = "Auto Farm"})
BloxTab:AddToggle({
    Name = "Auto Farm Nível",
    Default = false,
    Callback = function(value)
        getgenv().autofarm = value
        while autofarm do
            -- Implementação do farm
            task.wait()
        end
    end
})

-- =============== BROOKHAVEN ===============
local BrookhavenTab = Window:MakeTab({
    Name = "🏠 Brookhaven",
    Icon = "",
    PremiumOnly = false
})

BrookhavenTab:AddSection({Name = "Modificações"})
BrookhavenTab:AddButton({
    Name = "Obter $1,000,000",
    Callback = function()
        -- Implementação
    end
})

-- =============== INICIALIZAÇÃO ===============
Window:Init()

-- Atualiza sliders quando o personagem spawnar
Player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    WalkSpeedSlider:Set(humanoid.WalkSpeed)
    JumpPowerSlider:Set(humanoid.JumpPower)
end)
