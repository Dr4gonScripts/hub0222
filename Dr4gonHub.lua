-- Carregar a OrionLib atual
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Criar Janela
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHub",
    IntroEnabled = true,
    IntroText = "Bem-vindo ao Dr4gonHub!",
    Icon = "rbxassetid://4483345998"
})

-- Misc Tab
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "",
    PremiumOnly = false
})

MiscTab:AddSection({Name = "Utilitários"})

MiscTab:AddButton({
    Name = "Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK",
            Content = "Você está protegido contra kick por inatividade.",
            Time = 5
        })
    end
})

MiscTab:AddButton({
    Name = "Resetar WalkSpeed/JumpPower",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
    end
})

MiscTab:AddButton({
    Name = "WalkSpeed 100",
    Callback = function()
        local hum = Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.WalkSpeed = 100 end
    end
})

MiscTab:AddButton({
    Name = "JumpPower 100",
    Callback = function()
        local hum = Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.JumpPower = 100 end
    end
})

-- Fly
local flying = false
MiscTab:AddButton({
    Name = "Ativar Fly (tecla F)",
    Callback = function()
        local UIS = game:GetService("UserInputService")
        local BP = Instance.new("BodyPosition")
        local BG = Instance.new("BodyGyro")
        local char = Player.Character or Player.CharacterAdded:Wait()
        local HRP = char:WaitForChild("HumanoidRootPart")

        UIS.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.F then
                flying = not flying
                if flying then
                    BP.Parent = HRP
                    BG.Parent = HRP
                    BP.MaxForce = Vector3.new(400000, 400000, 400000)
                    BP.Position = HRP.Position
                    BG.MaxTorque = Vector3.new(400000, 400000, 400000)
                    BG.CFrame = HRP.CFrame
                    OrionLib:MakeNotification({
                        Name = "Fly",
                        Content = "Fly ativado",
                        Time = 3
                    })
                else
                    BP:Destroy()
                    BG:Destroy()
                    OrionLib:MakeNotification({
                        Name = "Fly",
                        Content = "Fly desativado",
                        Time = 3
                    })
                end
            end
        end)

        game:GetService("RunService").Heartbeat:Connect(function()
            if flying and HRP then
                BP.Position = HRP.Position + (HRP.CFrame.LookVector * 2)
                BG.CFrame = workspace.CurrentCamera.CFrame
            end
        end)
    end
})

-- Teleporte por clique
MiscTab:AddButton({
    Name = "Ativar Teleporte por Clique (tecla T)",
    Callback = function()
        local UIS = game:GetService("UserInputService")
        UIS.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.T then
                local target = Mouse.Hit + Vector3.new(0, 3, 0)
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(target.Position)
                end
            end
        end)
        OrionLib:MakeNotification({
            Name = "Teleporte",
            Content = "Pressione T para teleportar para onde clicar.",
            Time = 4
        })
    end
})

-- Aba Blox Fruits
local BFTab = Window:MakeTab({
    Name = "🍎 Blox Fruits",
    Icon = "",
    PremiumOnly = false
})

BFTab:AddSection({Name = "Hubs externos"})

BFTab:AddButton({
    Name = "Speed X Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
    end
})

BFTab:AddButton({
    Name = "Ro Hub",
    Callback = function()
        _G.settings = {
            autoLoadConfig = false,
            joinTeam = "Pirates"
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RO-HUB-CODEX/RO-HUB/refs/heads/main/bloxfruits.lua"))()
    end
})

-- Aba Grow a Garden
local GardenTab = Window:MakeTab({
    Name = "🌱 Grow a Garden",
    Icon = "",
    PremiumOnly = false
})

GardenTab:AddSection({Name = "Auto farm & Dupe"})

GardenTab:AddButton({
    Name = "No-Lag Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
    end
})

GardenTab:AddButton({
    Name = "Desligar",
    Callback = function()
        OrionLib:Destroy()
    end
})

OrionLib:Init()
