-- Carregar OrionLib diretamente (versão atual sem icons)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source", true))()
local Player = game.Players.LocalPlayer

-- Criar Janela
local Window = OrionLib:MakeWindow({
    Name = "Dr4gonHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Dr4gonHub",
    IntroEnabled = true,
    IntroText = "Bem-vindo ao Dr4gonHub!",
    Icon = "" -- Remove ícone para evitar erro de JSON
})

-- Aba Misc
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "", -- Remove ícone
    PremiumOnly = false
})

MiscTab:AddSection({Name = "Utilitários"})

-- Anti-AFK
MiscTab:AddButton({
    Name = "Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            vu:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
        end)
    end
})

-- Resetar status
MiscTab:AddButton({
    Name = "Resetar WalkSpeed/JumpPower",
    Callback = function()
        local hum = Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
    end
})

-- WalkSpeed
MiscTab:AddButton({
    Name = "WalkSpeed 100",
    Callback = function()
        local hum = Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 100
        end
    end
})

-- JumpPower
MiscTab:AddButton({
    Name = "JumpPower 100",
    Callback = function()
        local hum = Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.JumpPower = 100
        end
    end
})

-- Fly (F)
local flying = false
local UIS = game:GetService("UserInputService")

MiscTab:AddButton({
    Name = "Ativar Fly (tecla F)",
    Callback = function()
        UIS.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.F then
                flying = not flying
                local char = Player.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                if flying then
                    local bv = Instance.new("BodyVelocity")
                    bv.Name = "FlyVelocity"
                    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.Parent = hrp

                    local bg = Instance.new("BodyGyro")
                    bg.Name = "FlyGyro"
                    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
                    bg.CFrame = hrp.CFrame
                    bg.Parent = hrp

                    game:GetService("RunService").Heartbeat:Connect(function()
                        if flying then
                            local cam = workspace.CurrentCamera
                            bv.Velocity = cam.CFrame.LookVector * 50
                            bg.CFrame = cam.CFrame
                        else
                            bv:Destroy()
                            bg:Destroy()
                        end
                    end)
                end
            end
        end)
    end
})

-- Teleporte por clique (T)
MiscTab:AddButton({
    Name = "Ativar Teleporte por Clique (tecla T)",
    Callback = function()
        UIS.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.T then
                local mouse = Player:GetMouse()
                local pos = mouse.Hit.Position
                local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
                end
            end
        end)
    end
})

-- Segunda aba: Blox Fruits
local BFTab = Window:MakeTab({
    Name = "🍎 Blox Fruits",
    Icon = "",
    PremiumOnly = false
})

BFTab:AddButton({
    Name = "Speed X Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

BFTab:AddButton({
    Name = "Ro Hub",
    Callback = function()
        _G.settings = { autoLoadConfig = false, joinTeam = "Pirates" }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RO-HUB-CODEX/RO-HUB/refs/heads/main/bloxfruits.lua"))()
    end
})

-- Terceira aba: Grow a Garden
local GrowTab = Window:MakeTab({
    Name = "🌱 Grow a Garden",
    Icon = "",
    PremiumOnly = false
})

GrowTab:AddButton({
    Name = "No-Lag Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
    end
})

-- Finalizar
OrionLib:Init()
