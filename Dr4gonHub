local player = game.Players.LocalPlayer

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest"
})

local MiscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MiscTab:AddSection({Name = "Section"})

OrionLib:MakeNotification({
	Name = "Inicializando...",
	Content = "Bem vindo ao Dr4gonHub!!!",
	Image = "rbxassetid://4483345998",
	Time = 5
})

MiscTab:AddButton({
	Name = "Speed",
	Callback = function()
      	player.Character.Humanoid.WalkSpeed = 500
  	end    
})

MiscTab:AddButton({
	Name = "Jump",
	Callback = function()
      	player.Character.Humanoid.JumpPower = 50
  	end    
})

MiscTab:AddButton({
    Name = "Ajustar Iluminação",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 1.5
        Lighting.OutdoorAmbient = Color3.new(0.2, 0.2, 0.2)
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    end
})

local function giveFX3ToPlayer(player)
    local playerData = Instance.new("BoolValue")
    playerData.Name = "HasFX3"
    playerData.Parent = player

    local tool = Instance.new("Tool")
    tool.Name = "FX3 Tool"
    tool.Parent = player.Backpack

    local toolScript = Instance.new("LocalScript")
    toolScript.Parent = tool

    toolScript.Source = [[
        local tool = script.Parent
        local player = game.Players.LocalPlayer

        tool.Activated:Connect(function()
            print("FX3 ativada!")
        end)
    ]]
end

MiscTab:AddButton({
    Name = "FX3",
    Callback = function()
        giveFX3ToPlayer(player)
    end
})

local function teleportPlayer(player, position)
    local character = player.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(position)
        else
            warn("HumanoidRootPart não encontrado")
        end
    else
        warn("Personagem não encontrado")
    end
end

local destinationPosition = Vector3.new(0, 50, 0)

MiscTab:AddButton({
    Name = "Teletransportar",
    Callback = function()
        teleportPlayer(player, destinationPosition)
    end
})

-- Segunda aba: Grow a Garden
local GardenTab = Window:MakeTab({
	Name = "Grow a garden",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

GardenTab:AddSection({Name = "Section"})

GardenTab:AddButton({
	Name = "Speed X hub",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
	end
})

GardenTab:AddButton({
	Name = "Seed Spawner",
	Callback = function()
        loadstring(game:HttpGet("https://codeberg.org/twentys2/Scripts/raw/branch/main/Grow-A-Garden"))()
	end
})

OrionLib:Init()
