-- Carregar a biblioteca Orion atual (a que você pediu)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
local Player = game.Players.LocalPlayer

-- Criar janela
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHub",
    IntroEnabled = true,
    IntroText = "Bem-vindo ao Dr4gonHub!",
    Icon = "rbxassetid://4483345998"
})

-- Aba Misc
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MiscTab:AddSection({Name = "Utilitários"})

-- Anti-AFK
MiscTab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK",
            Content = "Você não será mais desconectado por inatividade.",
            Time = 5
        })
    end
})

-- Resetar status
MiscTab:AddButton({
    Name = "Resetar WalkSpeed e JumpPower",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
            OrionLib:MakeNotification({
                Name = "Resetado",
                Content = "WalkSpeed e JumpPower foram restaurados.",
                Time = 5
            })
        end
    end
})

-- WalkSpeed 100
MiscTab:AddButton({
    Name = "WalkSpeed 100",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 100
        end
    end
})

-- JumpPower 100
MiscTab:AddButton({
    Name = "JumpPower 100",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.JumpPower = 100
        end
    end
})

-- Segunda aba (exemplo: Blox Fruits)
local BFTab = Window:MakeTab({
    Name = "Blox Fruits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

BFTab:AddSection({Name = "Hubs externos"})

BFTab:AddButton({
    Name = "Speed X Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

Tab:AddButton({
	Name = "Ro Hub",
	Callback = function()
      		_G.settings = {
    autoLoadConfig = false, -- self explanatory
    joinTeam = "Pirates" -- "Pirates" or "Marines"
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/RO-HUB-CODEX/RO-HUB/refs/heads/main/bloxfruits.lua"))()
  	end    
})

Tab:AddButton({
	Name = "W Azure",
	Callback = function()
      		getgenv().Team = "Marines" getgenv().AutoLoad = false --Will Load Script On Server Hop loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
  	end    
})

Tab:AddButton({
	Name = "Tsou Hub",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
  	end    
})

Tab:AddButton({
	Name = "Banana Free",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/kimprobloxdz/Banana-Free/refs/heads/main/Protected_5609200582002947.lua.txt"))()
  	end    
})

local Tab = Window:MakeTab({
	Name = "🌱 Grow a Garden",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Scipts - Auto farm & Dupe"
})

Tab:AddButton({
	Name = "Speed X Hub",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
  	end    
})

Tab:AddButton({
	Name = "No-Lag hub",
	Callback = function()
      		loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
  	end    
})

Tab:AddButton({
	Name = "OFF",
	Callback = function()
      		print("button pressed")
  	end    
})


OrionLib:Init()
 print("Dr4gonHub carregado")
