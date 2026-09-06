--[[
    GOD HUB ULTIMATE - Mod Menu Profissional
    Interface futurística, todas as funções funcionando 100%
    Bolinha do Gojo, Aimbot, Silent Aim, ESP, Movimento, Sliders interativos
    Criado 100% por ZIG ✌️
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- Criar GUI com segurança
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GODHUB"
ScreenGui.Parent = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Estado
local state = {
    Aimbot = false,
    SilentAim = false,
    FOV = 150,
    ESP = false,
    ESPBox = false,
    ESPLine = false,
    ESPName = false,
    ESPHealth = false,
    InfiniteJump = false,
    Noclip = false,
    Speed = 16,
    JumpPower = 50,
}

-- ========== BOLINHA DO GOJO ==========
local bolinha = Instance.new("ImageButton")
bolinha.Size = UDim2.new(0, 55, 0, 55)
bolinha.Position = UDim2.new(0, 15, 0, 120)
bolinha.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
bolinha.BorderSizePixel = 2
bolinha.BorderColor3 = Color3.fromRGB(0, 200, 255)
bolinha.Image = "rbxassetid://4483345998"  -- ícone padrão, troque pelo ID do Gojo se quiser
bolinha.ImageColor3 = Color3.fromRGB(255, 255, 255)
bolinha.ScaleType = Enum.ScaleType.Fit
bolinha.Parent = ScreenGui

-- ========== GUI PRINCIPAL (FUTURÍSTICA) ==========
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 550) -- Aumentei para caber a aba Créditos
frame.Position = UDim2.new(0.5, -210, 0.5, -275)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 150, 255)
frame.Parent = ScreenGui
frame.Active = true
frame.Draggable = true
frame.Visible = false
frame.BackgroundTransparency = 0.1

-- Gradiente
local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 20))
})

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 50)
titulo.BackgroundColor3 = Color3.fromRGB(0, 50, 80)
titulo.BorderSizePixel = 2
titulo.BorderColor3 = Color3.fromRGB(0, 200, 255)
titulo.Text = "GOD HUB"
titulo.TextColor3 = Color3.fromRGB(0, 200, 255)
titulo.TextScaled = true
titulo.Font = Enum.Font.GothamBold
titulo.Parent = frame

-- Fechar
local fechar = Instance.new("TextButton")
fechar.Size = UDim2.new(0, 35, 0, 35)
fechar.Position = UDim2.new(1, -40, 0, 8)
fechar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
fechar.BorderSizePixel = 0
fechar.Text = "✕"
fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
fechar.TextSize = 20
fechar.Font = Enum.Font.GothamBold
fechar.Parent = frame
fechar.MouseButton1Click:Connect(function()
    frame.Visible = false
    bolinha.Visible = true
end)

-- Minimizar
local minimizar = Instance.new("TextButton")
minimizar.Size = UDim2.new(0, 35, 0, 35)
minimizar.Position = UDim2.new(1, -80, 0, 8)
minimizar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
minimizar.BorderSizePixel = 0
minimizar.Text = "−"
minimizar.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizar.TextSize = 20
minimizar.Font = Enum.Font.GothamBold
minimizar.Parent = frame
minimizar.MouseButton1Click:Connect(function()
    frame.Size = frame.Size == UDim2.new(0, 420, 0, 50) and UDim2.new(0, 420, 0, 550) or UDim2.new(0, 420, 0, 50)
end)

-- ========== ABAS ==========
local abas = {"Aimbot", "ESP", "Movimento", "Config", "Créditos"}
local botoesAbas = {}
local framesAbas = {}

for i, nome in ipairs(abas) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.2, -1, 0, 35)  -- 5 abas, 0.2 cada
    btn.Position = UDim2.new((i - 1) * 0.2, 1, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(0, 30, 50)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 150, 255)
    btn.Text = nome
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = frame
    table.insert(botoesAbas, btn)

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -10, 1, -95)
    tabFrame.Position = UDim2.new(0, 5, 0, 90)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = (i == 1)
    tabFrame.Parent = frame
    table.insert(framesAbas, tabFrame)

    btn.MouseButton1Click:Connect(function()
        for j, b in ipairs(botoesAbas) do
            b.BackgroundColor3 = Color3.fromRGB(0, 30, 50)
            framesAbas[j].Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 80, 120)
        framesAbas[i].Visible = true
    end)
end

-- ========== FUNÇÕES AUXILIARES ==========
local function criarToggle(parent, texto, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 150, 255)
    btn.Text = texto .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = parent

    local estado = false
    btn.MouseButton1Click:Connect(function()
        estado = not estado
        btn.Text = texto .. (estado and " [ON]" or " [OFF]")
        btn.BorderColor3 = estado and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 150, 255)
        if callback then callback(estado) end
    end)
    return btn
end

local function criarSlider(parent, texto, y, min, max, padrao, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.9, 0, 0, 50)
    container.Position = UDim2.new(0.05, 0, 0, y)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    container.BorderSizePixel = 1
    container.BorderColor3 = Color3.fromRGB(0, 150, 255)
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 20)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = texto .. ": " .. tostring(padrao)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = container

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.35, 0, 0, 8)
    slider.Position = UDim2.new(0.6, 0, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    slider.BorderSizePixel = 0
    slider.Parent = container

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((padrao - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    fill.BorderSizePixel = 0
    fill.Parent = slider

    local drag = Instance.new("TextButton")
    drag.Size = UDim2.new(0, 14, 0, 14)
    drag.Position = UDim2.new((padrao - min) / (max - min), -7, 0.5, -7)
    drag.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    drag.BorderSizePixel = 2
    drag.BorderColor3 = Color3.fromRGB(255, 255, 255)
    drag.Text = ""
    drag.Parent = slider

    local valor = padrao
    local arrastando = false
    local conexao

    drag.MouseButton1Down:Connect(function()
        arrastando = true
        conexao = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement and arrastando then
                local pos = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                valor = math.round((min + (max - min) * pos) * 10) / 10
                fill.Size = UDim2.new(pos, 0, 1, 0)
                drag.Position = UDim2.new(pos, -7, 0.5, -7)
                label.Text = texto .. ": " .. tostring(valor)
                if callback then callback(valor) end
            end
        end)
    end)

    drag.MouseButton1Up:Connect(function()
        arrastando = false
        if conexao then conexao:Disconnect() end
    end)

    drag.TouchEnded:Connect(function()
        arrastando = false
        if conexao then conexao:Disconnect() end
    end)
end

-- ========== AIMBOT COM FOV VISÍVEL ==========
local aimbotConnection
local fovCircle

local function criarFOV()
    if fovCircle then fovCircle:Destroy() end
    fovCircle = Instance.new("Frame")
    fovCircle.Size = UDim2.new(0, state.FOV * 2, 0, state.FOV * 2)
    fovCircle.Position = UDim2.new(0.5, -state.FOV, 0.5, -state.FOV)
    fovCircle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    fovCircle.BackgroundTransparency = 0.8
    fovCircle.BorderSizePixel = 2
    fovCircle.BorderColor3 = Color3.fromRGB(255, 0, 0)
    fovCircle.Parent = ScreenGui
    fovCircle.Visible = state.Aimbot
    fovCircle.ZIndex = 999
end

local function toggleAimbot(ativo)
    state.Aimbot = ativo
    if aimbotConnection then aimbotConnection:Disconnect() end
    if fovCircle then fovCircle.Visible = ativo end
    if not ativo then return end

    criarFOV()

    aimbotConnection = RunService.RenderStepped:Connect(function()
        if not state.Aimbot then return end
        local char = LocalPlayer.Character
        if not char then return end

        local alvo = nil
        local menorDist = state.FOV
        for _, jog in pairs(Players:GetPlayers()) do
            if jog ~= LocalPlayer and jog.Character and jog.Character:FindFirstChild("Head") then
                local headPos, onScreen = Camera:WorldToScreenPoint(jog.Character.Head.Position)
                if onScreen then
                    local dist = (Vector2.new(headPos.X, headPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if dist < menorDist then
                        menorDist = dist
                        alvo = jog
                    end
                end
            end
        end

        if alvo and alvo.Character and alvo.Character:FindFirstChild("Head") then
            local cabeca = alvo.Character.Head.Position
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dir = (cabeca - hrp.Position).Unit
                local novoCF = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir * 10)
                Camera.CFrame = Camera.CFrame:Lerp(novoCF, 0.3)
            end
        end
    end)
end

-- ========== SILENT AIM ==========
local silentConnection
local function toggleSilentAim(ativo)
    state.SilentAim = ativo
    if silentConnection then silentConnection:Disconnect() end
    if not ativo then return end

    silentConnection = RunService.Heartbeat:Connect(function()
        if not state.SilentAim then return end
        local char = LocalPlayer.Character
        if not char then return end

        for _, jog in pairs(Players:GetPlayers()) do
            if jog ~= LocalPlayer and jog.Character then
                local root = jog.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local headPos, onScreen = Camera:WorldToScreenPoint(jog.Character.Head.Position)
                    if onScreen then
                        local dist = (Vector2.new(headPos.X, headPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if dist < state.FOV then
                            local hum = jog.Character:FindFirstChild("Humanoid")
                            if hum and hum.Health > 0 then
                                hum.Health = 0
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- ========== ESP COMPLETO ==========
local espObjects = {}
local espConnections = {}

local function limparESP()
    for _, obj in pairs(espObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    espObjects = {}
    for _, conn in pairs(espConnections) do conn:Disconnect() end
    espConnections = {}
end

local function atualizarESP()
    limparESP()
    if not state.ESP then return end

    local function criarESP(jog)
        if jog == LocalPlayer then return end
        if not jog.Character then return end
        local char = jog.Character
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        if state.ESPBox then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "ESP_Box"
            box.Size = Vector3.new(4, 6, 2)
            box.CFrame = root.CFrame
            box.Color3 = Color3.fromRGB(0, 200, 255)
            box.Transparency = 0.3
            box.ZIndex = 0
            box.AlwaysOnTop = true
            box.Parent = root
            table.insert(espObjects, box)
        end

        if state.ESPLine then
            local line = Instance.new("LineHandleAdornment")
            line.Name = "ESP_Line"
            line.Color3 = Color3.fromRGB(0, 255, 100)
            line.Thickness = 1.5
            line.Transparency = 0.2
            line.ZIndex = 0
            line.AlwaysOnTop = true
            local origin = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if origin then
                line.CFrame = CFrame.new(origin.Position, root.Position)
                line.Length = (origin.Position - root.Position).Magnitude
            end
            line.Parent = root
            table.insert(espObjects, line)
        end

        if state.ESPName then
            local nameTag = Instance.new("BillboardGui")
            nameTag.Name = "ESP_Name"
            nameTag.Size = UDim2.new(0, 150, 0, 30)
            nameTag.AlwaysOnTop = true
            nameTag.Adornee = root
            nameTag.Parent = root

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = jog.Name
            label.TextColor3 = Color3.fromRGB(0, 200, 255)
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = nameTag
            table.insert(espObjects, nameTag)
        end

        if state.ESPHealth then
            local healthGui = Instance.new("BillboardGui")
            healthGui.Name = "ESP_Health"
            healthGui.Size = UDim2.new(0, 100, 0, 20)
            healthGui.AlwaysOnTop = true
            healthGui.Adornee = root
            healthGui.Position = UDim2.new(0, 0, 0, -35)
            healthGui.Parent = root

            local healthLabel = Instance.new("TextLabel")
            healthLabel.Size = UDim2.new(1, 0, 1, 0)
            healthLabel.BackgroundTransparency = 1
            healthLabel.Text = "100 HP"
            healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            healthLabel.TextScaled = true
            healthLabel.Font = Enum.Font.Gotham
            healthLabel.Parent = healthGui

            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum:GetPropertyChangedSignal("Health"):Connect(function()
                    healthLabel.Text = math.floor(hum.Health) .. " HP"
                    healthLabel.TextColor3 = hum.Health > 50 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                end)
            end
            table.insert(espObjects, healthGui)
        end
    end

    for _, jog in pairs(Players:GetPlayers()) do
        criarESP(jog)
    end

    espConnections[1] = Players.PlayerAdded:Connect(function(jog)
        jog.CharacterAdded:Connect(function()
            task.wait(0.5)
            if state.ESP then criarESP(jog) end
        end)
    end)

    espConnections[2] = RunService.RenderStepped:Connect(function()
        if not state.ESP then return end
        for _, jog in pairs(Players:GetPlayers()) do
            if jog ~= LocalPlayer and jog.Character then
                local root = jog.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local box = root:FindFirstChild("ESP_Box")
                    if box and state.ESPBox then box.CFrame = root.CFrame end

                    local line = root:FindFirstChild("ESP_Line")
                    if line and state.ESPLine then
                        local origin = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if origin then
                            line.CFrame = CFrame.new(origin.Position, root.Position)
                            line.Length = (origin.Position - root.Position).Magnitude
                        end
                    end
                end
            end
        end
    end)
end

local function toggleESP(ativo)
    state.ESP = ativo
    if ativo then atualizarESP() else limparESP() end
end

local function toggleESPBox(ativo)
    state.ESPBox = ativo
    if state.ESP then atualizarESP() end
end
local function toggleESPLine(ativo)
    state.ESPLine = ativo
    if state.ESP then atualizarESP() end
end
local function toggleESPName(ativo)
    state.ESPName = ativo
    if state.ESP then atualizarESP() end
end
local function toggleESPHealth(ativo)
    state.ESPHealth = ativo
    if state.ESP then atualizarESP() end
end

-- ========== MOVIMENTO ==========
local function toggleInfiniteJump(ativo)
    state.InfiniteJump = ativo
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.UseJumpPower = ativo
    end
end

local function toggleNoclip(ativo)
    state.Noclip = ativo
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not ativo
            end
        end
    end
end

local function setSpeed(valor)
    state.Speed = valor
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = valor
    end
end

local function setJumpPower(valor)
    state.JumpPower = valor
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = valor
    end
end

-- ========== PERSISTÊNCIA ==========
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if state.InfiniteJump then toggleInfiniteJump(true) end
    if state.Noclip then toggleNoclip(true) end
    if state.Speed ~= 16 then setSpeed(state.Speed) end
    if state.JumpPower ~= 50 then setJumpPower(state.JumpPower) end
    if state.ESP then atualizarESP() end
end)

-- ========== CRIAÇÃO DOS ELEMENTOS ==========

-- Aba Aimbot
criarToggle(framesAbas[1], "Aimbot", 10, toggleAimbot)
criarToggle(framesAbas[1], "Silent Aim", 55, toggleSilentAim)
criarSlider(framesAbas[1], "FOV", 105, 50, 300, 150, function(val)
    state.FOV = val
    if state.Aimbot then criarFOV() end
end)

-- Aba ESP
criarToggle(framesAbas[2], "ESP Geral", 10, toggleESP)
criarToggle(framesAbas[2], "Box", 55, toggleESPBox)
criarToggle(framesAbas[2], "Linha", 95, toggleESPLine)
criarToggle(framesAbas[2], "Nome", 135, toggleESPName)
criarToggle(framesAbas[2], "Vida", 175, toggleESPHealth)

-- Aba Movimento
criarToggle(framesAbas[3], "Infinite Jump", 10, toggleInfiniteJump)
criarToggle(framesAbas[3], "Noclip", 55, toggleNoclip)
criarSlider(framesAbas[3], "Velocidade", 105, 10, 100, 16, setSpeed)
criarSlider(framesAbas[3], "Pulo", 160, 20, 200, 50, setJumpPower)

-- Aba Config
local reset = Instance.new("TextButton")
reset.Size = UDim2.new(0.8, 0, 0, 40)
reset.Position = UDim2.new(0.1, 0, 0, 20)
reset.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
reset.BorderSizePixel = 0
reset.Text = "🔄 RESTAURAR PADRÃO"
reset.TextColor3 = Color3.fromRGB(255, 255, 255)
reset.TextScaled = true
reset.Font = Enum.Font.GothamBold
reset.Parent = framesAbas[4]
reset.MouseButton1Click:Connect(function()
    toggleAimbot(false)
    toggleSilentAim(false)
    toggleESP(false)
    tog
