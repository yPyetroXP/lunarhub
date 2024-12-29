--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
repeat task.wait(0.25) until game:IsLoaded();
getgenv().Image = "rbxassetid://7229442422"; -- put a asset id in here to make it work
getgenv().ToggleUI = "K" -- This where you can Toggle the Fluent ui library

task.spawn(function()
    if not getgenv().LoadedMobileUI == true then getgenv().LoadedMobileUI = true
        local OpenUI = Instance.new("ScreenGui");
        local ImageButton = Instance.new("ImageButton");
        local UICorner = Instance.new("UICorner");
        OpenUI.Name = "OpenUI";
        OpenUI.Parent = game:GetService("CoreGui");
        OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ImageButton.Parent = OpenUI;
        ImageButton.BackgroundColor3 = Color3.fromRGB(105,105,105);
        ImageButton.BackgroundTransparency = 0.8
        ImageButton.Position = UDim2.new(0.9,0,0.1,0);
        ImageButton.Size = UDim2.new(0,50,0,50);
        ImageButton.Image = getgenv().Image;
        ImageButton.Draggable = true;
        ImageButton.Transparency = 1;
        UICorner.CornerRadius = UDim.new(0,200);
        UICorner.Parent = ImageButton;
        ImageButton.MouseButton1Click:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().ToggleUI,false,game);
        end)
    end
end)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Lunar Hub",
    SubTitle = "by lawzera",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.K -- Used when theres no MinimizeKeybind
})


-- Fluent provides Lucide Icons, they are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Início", Icon = nil }),
    Shop = Window:AddTab({ Title = "Loja", Icon = nil }),
    Combat = Window:AddTab({ Title = "Combate", Icon = nil }),
    Settings = Window:AddTab({ Title = "Configurações", Icon = nil }),
    Outros = Window:AddTab({ Title = "Outros", Icon = nil })
}

local Main = Tabs.Main -- Certifique-se de que a aba "Início" foi criada corretamente

local LocalPlayerSection = Main:AddSection("Local Player (BETA)")

local SpeedSlider = LocalPlayerSection:AddSlider("Slider", 
{
    Title = "Speed (WalkSpeed)",
    Description = "Altera sua velocidade no jogo.",
    Default = 16,
    Min = 16,
    Max = 256,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local JumpSlider = LocalPlayerSection:AddSlider("JumpSlider", 
{
    Title = "Jump Power",
    Description = "Altera a altura do seu pulo no jogo.",
    Default = 50,
    Min = 50,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

-- Rejoin Game Button
LocalPlayerSection:AddButton({
    Title = "Rejoin Game",
    Description = "Reinicia o jogo.",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- Section Blox Fruits
local BloxFruitsSection = Tabs.Main:AddSection("Blox Fruits")

BloxFruitsSection:AddButton({
    Title = "Virar Pirata",
    Description = "Faz você mudar para o time dos Piratas",
    Callback = function()
        local value = "Pirates" -- Define the value variable
        local args = {
            [1] = "SetTeam",
            [2] = value
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end
})

BloxFruitsSection:AddButton({
    Title = "Virar Marinha",
    Description = "Faz você mudar para o time da Marinha",
    Callback = function()
        local value = "Marines" -- Define the value variable
        local args = {
            [1] = "SetTeam",
            [2] = value
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end
})


-- Exemplo Dropdown
--[[
    local Dropdown = Tab:AddDropdown("Dropdown", {
        Title = "Dropdown",
        Description = "Dropdown description",
        Values = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen"},
        Multi = false,
        Default = 1,
    })
        ]]


-- Botão de copiar coordenadas
local CopyCoordinates = Tabs.Main:AddSection("Copiar Coordenadas")

CopyCoordinates:AddButton({
    Title = "Copiar Coordenadas",
    Description = "Copia as coordenadas do seu personagem",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        local Position = HumanoidRootPart.Position
        local X = math.floor(Position.X)
        local Y = math.floor(Position.Y)
        local Z = math.floor(Position.Z)
        
        local Clipboard = setclipboard
        Clipboard(X..", "..Y..", "..Z)
    end
})


local TeleportSection = Tabs.Main:AddSection("Teleportes")

local Dropdown = TeleportSection:AddDropdown("Dropdown", {
    Title = "Teleporte",
    Description = "Teleporta você para a localização selecionada",
    Values = {"Castelo do Mar", "Mansão", "seila"},
    Multi = false,
    Default = 1,
})

local TweenService = game:GetService("TweenService")

TeleportSection:AddButton({
    Title = "Teleportar",
    Description = "Teleporta você para a localização selecionada",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        local Position = HumanoidRootPart.Position
        
        local targetPosition
        if Dropdown.Value == "Castelo do Mar" then
            targetPosition = Vector3.new(-4988, 314, -3015)
        elseif Dropdown.Value == "Mansão" then
            targetPosition = Vector3.new(-12551, 337, -7471)
        elseif Dropdown.Value == "seila" then
            targetPosition = Vector3.new(3182.65673828125, 903.97021484375, -7035.15576171875)
        end

        if targetPosition then
            local tweenInfo = TweenInfo.new(43, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
            tween:Play()
        end
    end
})


--[[][-- DEATH STEP V2:
Este código compra o estilo de luta "Death Step V2" utilizando o evento remoto "CommF_".
]]
--[[
local args = {
    [1] = "BuyDeathStep"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- DEATH STEP V1:
Este código compra o estilo de luta "Black Leg", que é necessário para evoluir para o "Death Step".
]]
--[[
local args = {
    [1] = "BuyBlackLeg"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- Electro:
Este código compra o estilo de luta "Electro".
]]
--[[
local args = {
    [1] = "BuyElectro"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- Fishman Karate:
Este código compra o estilo de luta "Fishman Karate".
]]
--[[
local args = {
    [1] = "BuyFishmanKarate"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- Sharkman Karate:
Este código compra o estilo de luta "Sharkman Karate", evolução do "Fishman Karate".
]]
--[[
local args = {
    [1] = "BuySharkmanKarate"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- Super Human:
Este código compra o estilo de luta "Super Human", que combina diversos estilos para se tornar mais poderoso.
]]
--[[
local args = {
    [1] = "BuySuperhuman"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- Dragon Claw:
Este código adquire o estilo "Dragon Claw" ao completar a missão do Barba Negra (Blackbeard).
]]
--[[
local args = {
    [1] = "BlackbeardReward",
    [2] = "DragonClaw",
    [3] = "2"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- Dragon Talon:
Este código compra o estilo de luta "Dragon Talon".
]]
--[[
local args = {
    [1] = "BuyDragonTalon"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- God Human:
Este código compra o estilo de luta "God Human", o mais avançado entre os estilos disponíveis.
]]
--[[
local args = {
    [1] = "BuyGodhuman"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]

--[[][-- Sanguine Art:
Este código compra o estilo de luta "Sanguine Art", provavelmente inspirado em ataques sanguinários ou vampíricos.
]]
--[[
local args = {
    [1] = "BuySanguineArt"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]


local Shop = Tabs.Shop

local EstilosDeLutaSection = Shop:AddSection("Estilos de Luta")


-- Dropdown de Estilos de Luta
local EstilosDeLutaDropdown = EstilosDeLutaSection:AddDropdown("Estilos de Luta", {
    Title = "Estilos de Luta",
    Description = "Seleciona o estilo de luta que você deseja comprar",
    Values = {
        "DeathStep",
        "BlackLeg",
        "Electro",
        "FishmanKarate",
        "SharkmanKarate",
        "Superhuman",
        "DragonClaw",
        "DragonTalon",
        "GodHuman",
        "SanguineArt"
    },
    Multi = false,
    Default = 1,
})

EstilosDeLutaSection:AddButton({
    Title = "Comprar Estilo de Luta",
    Description = "Compra o estilo de luta selecionado",
    Callback = function()
        local EstiloDeLuta = EstilosDeLutaDropdown.Value
        local args = {
            [1] = "Buy"..EstiloDeLuta
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end
})

-- Script Girar fruta
--[[
    local args = {
        [1] = "Cousin",
        [2] = "Buy"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]--

local FrutaSelection = Shop:AddSection("Frutas (Akuma no Mi)")

-- Girar Fruta Automaticamente (Toggle)
local GirarFrutaToggle = FrutaSelection:AddToggle("Girar Fruta Automaticamente", {
    Title = "Girar Fruta Automaticamente",
    Description = "Gira frutas automaticamente",
    Default = false,
    Callback = function(Value)
        if Value then
            task.spawn(function()
                while GirarFrutaToggle.Value do
                    local args = {
                        [1] = "Cousin",
                        [2] = "Buy"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
                    task.wait(5.0)
                end
            end)
        end
    end
})

-- Girar Fruta Manualmente
FrutaSelection:AddButton({
    Title = "Girar Fruta Manualmente",
    Description = "Gira a fruta manualmente",
    Callback = function()
        local args = {
            [1] = "Cousin",
            [2] = "Buy"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end
})


-- Destroy UI Button (Outros Tab)
local Outros = Tabs.Outros

Outros:AddButton({
    Title = "Fechar UI",
    Description = "Fecha a interface do usuário",
    Callback = function()
        Window:Destroy()
    end
})


-- Combat TAB
local Combat = Tabs.Combat

local BasicoCombat = Combat:AddSection("Combate Básico")


-- Script buso haki
--[[
    local args = {
        [1] = "Buso"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
]]--


-- Auto Buso Haki
-- Auto Buso Haki
-- Auto Buso Haki
-- Auto Buso Haki
-- Auto Buso Haki
local AutoBusoHakiToggle
AutoBusoHakiToggle = BasicoCombat:AddToggle("Auto Buso Haki", {
    Title = "Auto Buso Haki",
    Description = "Ativa o Buso Haki automaticamente",
    Default = false,
    Callback = function(Value)
        if Value then
            task.spawn(function()
                local hakiAtivado = false -- Flag para verificar se o Haki foi ativado

                while AutoBusoHakiToggle and AutoBusoHakiToggle.Value do
                    -- Verifique se o Haki já está ativado
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local hakiStatus = character:FindFirstChild("BusoHaki") -- Supondo que o nome do objeto seja "BusoHaki"
                        
                        -- Se o Haki ainda não foi ativado, ativamos
                        if not hakiStatus and not hakiAtivado then
                            local args = {"Buso"}
                            local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")
                            if remote then
                                pcall(function()
                                    remote:InvokeServer(unpack(args))
                                    hakiAtivado = true -- Marca como ativado
                                end)
                            end
                        end
                    end

                    -- Se o Haki já foi ativado, sai do loop
                    if hakiAtivado then
                        break
                    end

                    task.wait(5.0) -- Tempo entre checagens
                end
            end)
        end
    end
})


-- ESP Section
local ESPSection = Combat:AddSection("ESP")

-- Função para criar ESP Box
local function createESPBox(player)
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(4, 5, 1)
    box.Color3 = Color3.fromRGB(255, 0, 0)
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.ZIndex = 1
    box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
    box.Parent = game:GetService("CoreGui")

    local name = Instance.new("TextLabel")
    name.Text = player.Name
    name.TextColor3 = Color3.fromRGB(255, 255, 255)
    name.BackgroundTransparency = 1
    name.Size = UDim2.new(0, 100, 0, 50)
    name.AnchorPoint = Vector2.new(0.5, 1)
    name.Position = UDim2.new(0.5, 0, 0, -50)
    name.Parent = box

    local distance = Instance.new("TextLabel")
    distance.Text = ""
    distance.TextColor3 = Color3.fromRGB(255, 255, 255)
    distance.BackgroundTransparency = 1
    distance.Size = UDim2.new(0, 100, 0, 50)
    distance.AnchorPoint = Vector2.new(0.5, 0)
    distance.Position = UDim2.new(0.5, 0, 0, 50)
    distance.Parent = box

    return {box = box, name = name, distance = distance}
end

local function createChams(player)
    local chams = Instance.new("Highlight")
    chams.Adornee = player.Character
    chams.FillColor = Color3.fromRGB(0, 255, 0)
    chams.FillTransparency = 0.5
    chams.OutlineColor = Color3.fromRGB(0, 0, 0)
    chams.OutlineTransparency = 0
    chams.Parent = game:GetService("CoreGui")
    return chams
end

local ESPObjects = {}
local ChamsObjects = {}

-- Toggle para ESP Box
local ToggleESPBox = ESPSection:AddToggle("ToggleESPBox", {Title = "ESP Box", Default = false})
ToggleESPBox:OnChanged(function(Value)
    for _, esp in pairs(ESPObjects) do
        esp.box.Visible = Value
    end
end)

-- Toggle para ESP Name
local ToggleESPName = ESPSection:AddToggle("ToggleESPName", {Title = "ESP Name", Default = false})
ToggleESPName:OnChanged(function(Value)
    for _, esp in pairs(ESPObjects) do
        esp.name.Visible = Value
    end
end)

-- Toggle para ESP Distance
local ToggleESPDistance = ESPSection:AddToggle("ToggleESPDistance", {Title = "ESP Distance", Default = false})
ToggleESPDistance:OnChanged(function(Value)
    for _, esp in pairs(ESPObjects) do
        esp.distance.Visible = Value
    end
end)

-- Toggle para ESP Chams
local ToggleESPChams = ESPSection:AddToggle("ToggleESPChams", {Title = "ESP Chams", Default = false})
ToggleESPChams:OnChanged(function(Value)
    for _, chams in pairs(ChamsObjects) do
        chams.Enabled = Value
    end
end)

-- Toggle para Team Check
local ToggleTeamCheck = ESPSection:AddToggle("ToggleTeamCheck", {Title = "Team Check", Default = false})
local TeamCheckEnabled = false
ToggleTeamCheck:OnChanged(function(Value)
    TeamCheckEnabled = Value
end)

-- Atualizar ESP
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if TeamCheckEnabled and player.Team == LocalPlayer.Team then
                if ESPObjects[player] then
                    ESPObjects[player].box.Visible = false
                    ESPObjects[player].name.Visible = false
                    ESPObjects[player].distance.Visible = false
                end
                if ChamsObjects[player] then
                    ChamsObjects[player].Enabled = false
                end
            else
                if not ESPObjects[player] then
                    ESPObjects[player] = createESPBox(player)
                end

                if not ChamsObjects[player] then
                    ChamsObjects[player] = createChams(player)
                end

                local esp = ESPObjects[player]
                local rootPart = player.Character.HumanoidRootPart
                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

                if onScreen then
                    esp.box.Adornee = rootPart
                    esp.box.Visible = ToggleESPBox.Value

                    esp.name.Text = player.Name
                    esp.name.Position = UDim2.new(0.5, screenPos.X - 50, 0, screenPos.Y - 70)
                    esp.name.Visible = ToggleESPName.Value

                    esp.distance.Text = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude) .. "m"
                    esp.distance.Position = UDim2.new(0.5, screenPos.X - 50, 0, screenPos.Y + 70)
                    esp.distance.Visible = ToggleESPDistance.Value

                    ChamsObjects[player].Enabled = ToggleESPChams.Value
                else
                    esp.box.Visible = false
                    esp.name.Visible = false
                    esp.distance.Visible = false
                    ChamsObjects[player].Enabled = false
                end
            end
        elseif ESPObjects[player] then
            -- Remove ESP para players que não existem mais ou morreram
            ESPObjects[player].box:Destroy()
            ESPObjects[player].name:Destroy()
            ESPObjects[player].distance:Destroy()
            ESPObjects[player] = nil

            ChamsObjects[player]:Destroy()
            ChamsObjects[player] = nil
        end
    end
end)

-- Remover ESP quando o jogador sair do jogo
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        ESPObjects[player].box:Destroy()
        ESPObjects[player].name:Destroy()
        ESPObjects[player].distance:Destroy()
        ESPObjects[player] = nil
    end

    if ChamsObjects[player] then
        ChamsObjects[player]:Destroy()
        ChamsObjects[player] = nil
    end
end)





