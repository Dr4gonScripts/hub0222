local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "Dr4gonHub",
    IntroEnabled = true,
    IntroText = "Bem-vindo ao Dr4gonHub!",
    Icon = "" -- Vazio para evitar erro com JSON
})

-- =============== MISC TAB ===============
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "",
    PremiumOnly = false
})

MiscTab:AddSection({Name = "Utilitários"})

-- Anti-AFK
MiscTab:AddButton({
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

-- Reset stats
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
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.WalkSpeed = 100 end
    end
})

MiscTab:AddButton({
    Name = "JumpPower 100",
    Callback = function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.JumpPower = 100 end
    end
})

-- Fly
local flying = false
MiscTab:AddButton({
    Name = "Ativar Fly (tecla F)",
    Callback = function()
        local UIS = game:GetService("UserInputService")
        local bp, bg
        local speed = 5

        UIS.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.F then
                flying = not flying
                if flying then
                    local char = Player.Character
                    local hrp = char:WaitForChild("HumanoidRootPart")

                    bp = Instance.new("BodyPosition", hrp)
                    bp.D = 10
                    bp.MaxForce = Vector3.new(400000, 400000, 400000)
                    bp.Position = hrp.Position

                    bg = Instance.new("BodyGyro", hrp)
                    bg.D = 10
                    bg.MaxTorque = Vector3.new(400000, 400000, 400000)
                    bg.CFrame = hrp.CFrame

                    while flying and task.wait() do
                        bp.Position = hrp.Position + (workspace.CurrentCamera.CFrame.LookVector * speed)
                        bg.CFrame = workspace.CurrentCamera.CFrame
                    end
                else
                    if bp then bp:Destroy() end
                    if bg then bg:Destroy() end
                end
            end
        end)
    end
})

-- Teleport
MiscTab:AddButton({
    Name = "Ativar Teleporte por Clique (tecla T)",
    Callback = function()
        local UIS = game:GetService("UserInputService")
        UIS.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.T then
                local pos = Mouse.Hit.Position
                local char = Player.Character or Player.CharacterAdded:Wait()
                local root = char:WaitForChild("HumanoidRootPart")
                root.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
            end
        end)
    end
})

-- =============== BLOX FRUITS ===============
local BloxTab = Window:MakeTab({
    Name = "🍩 Blox Fruits",
    Icon = "",
    PremiumOnly = false
})

BloxTab:AddButton({
    Name = "Speed X Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
    end
})

-- =============== GARDEN TAB ===============
local GardenTab = Window:MakeTab({
    Name = "🌱 Grow a Garden",
    Icon = "",
    PremiumOnly = false
})

GardenTab:AddButton({
    Name = "No Lag Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
    end
})

OrionLib:Init()
