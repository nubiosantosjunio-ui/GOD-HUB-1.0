-- [[ GOD HUB - Mod Menu Completo com Aimbot, ESP, Movimento, Config ]]
-- Ideal para Delta / Executores Roblox
-- Bolinha flutuante com imagem do Gojo (URL da web)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GODHUB"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- ========== ESTADO ==========
local state = {
    Aimbot = false,
    FOV = 150,              -- raio em pixels
    ESP = false,
    ESPBox = false,
    ESPLine = false,
    ESPName = false,
    ESPHealth = false,
    InfiniteJump = false,
    Noclip = false,
    Speed = 16,
}

-- ========== BOLINHA FLUTUANTE COM GOJO ==========
local bolinha = Instance.new("ImageButton")
bolinha.Size = UDim2.new(0, 55, 0, 55)
bolinha.Position = UDim2.new(0, 15, 0, 120)
bolinha.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bolinha.BorderSizePixel = 0
bolinha.Image = "https://i.imgur.com/GojoSatoru.png"  -- URL de imagem do Gojo (pode trocar)
bolinha.ImageRectOffset = Vector2.new(0, 0)
bolinha.ImageRectSize = Vector2.new(200, 200)
bolinha.ScaleType = Enum.ScaleType.Fit
bolinha.Parent = ScreenGui

-- ========== GUI PRINCIPAL ==========
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 470)
frame.Position = UDim2.new(0.5, -190, 0.5, -235)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(200, 0, 0)
frame.Parent = ScreenGui
frame.Active = true
frame.Draggable = true
frame.Visible = false

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 45)
titulo.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
titulo.Text = "GOD HUB"
titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
titulo.TextScaled = true
titulo.Font = Enum.Font.GothamBold
titulo.Parent = frame

-- Fechar
local fechar = Instance.new("TextButton")
fechar.Size = UDim2.new(0, 30, 0, 30)
fechar.Position = UDim2.new(1, -35, 0, 8)
fechar.BackgroundTransparency = 1
fechar.Text = "✕"
fechar.TextColor3 = Color3.fromRGB(255, 0, 0)
fechar.TextSize = 20
fechar.Font = Enum.Font.GothamBold
fechar.Parent = frame
fechar.MouseButton1Click:Connect(function()
    frame.Visible = false
    bolinha.Visible = true
    -- Desativa funções ao fechar? (opcional)
end)

-- Minimizar
local minimizar = Instance.new("TextButton")
minimizar.Size = UDim2.new(0, 30, 0, 30)
minimizar.Position = UDim2.new(1, -70, 0, 8)
minimizar.BackgroundTransparency = 1
minimizar.Text = "−"
minimizar.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizar.TextSize = 20
minimizar.Font = Enum.Font.GothamBold
minimizar.Parent = frame
minimizar.MouseButton1Click:Connect(function()
    frame.Size = frame.Size == UDim2.new(0, 380, 0, 45) and UDim2.new(0, 380, 0, 470) or UDim2.new(0, 380, 0, 45)
end)

-- ========== ABAS ==========
local abas = {"Aimbot", "ESP", "Movimento", "Config"}
local botoesAbas = {}
local framesAbas = {}

for i, nome in ipairs(abas) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, -1, 0, 30)
    btn.Position = UDim2.new((i - 1) * 0.25, 1, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    btn.BorderSizePixel = 0
    btn.Text = nome
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = frame
    table.insert(botoesAbas, btn)

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -10, 1, -85)
    tabFrame.Position = UDim2.new(0, 5, 0, 80)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = (i == 1)
    tabFrame.Parent = frame
    table.insert(framesAbas, tabFrame)

    btn.MouseButton1Click:Connect(function()
        for j, b in ipairs(botoesAbas) do
            b.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
            framesAbas[j].Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
        framesAbas[i].Visible = true
    end)
end

-- ========== FUNÇÕES AUXILIARES (Toggle, Slider, ColorPicker) ==========
local function criarToggle(parent, texto, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = texto .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = parent

    local estado = false
    btn.MouseButton1Click:Connect(function()
        estado = not estado
        btn.Text = texto .. (estado and " [ON]" or " [OFF]")
        btn.BorderColor3 = estado and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 60)
        if callback then callback(estado) end
    end)
    return btn
end

local function criarSlider(parent, texto, y, min, max, padrao, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.9, 0, 0, 45)
    container.Position = UDim2.new(0.05, 0, 0, y)
    container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    container.BorderSizePixel = 1
    container.BorderColor3 = Color3.fromRGB(60, 60, 60)
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
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    slider.BorderSizePixel = 0
    slider.Parent = container

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((padrao - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    fill.BorderSizePixel = 0
    fill.Parent = slider

    local drag = Instance.new("TextButton")
    drag.Size = UDim2.new(0, 12, 0, 12)
    drag.Position = UDim2.new((padrao - min) / (max - min), -6, 0.5, -6)
    drag.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    drag.BorderSizePixel = 0
    drag.Text = ""
    drag.Parent = slider

    local valor = padrao
    drag.MouseButton1Down:Connect(function()
        local conexao
        conexao = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                valor = math.round((min + (max - min) * pos) * 10) / 10
                fill.Size = UDim2.new(pos, 0, 1, 0)
                drag.Position = UDim2.new(pos, -6, 0.5, -6)
                label.Text = texto .. ": " .. tostring(valor)
                if callback then callback(valor) end
            end
        end)
        drag.MouseButton1Up:Connect(function()
            conexao:Disconnect()
        end)
    end)
end

-- ========== AIMBOT ==========
local aimbotConnection
local function toggleAimbot(ativo)
    state.Aimbot = ativo
    if aimbotConnection then aimbotConnection:Disconnect() end
    if not ativo then return end

    aimbotConnection = RunService.RenderStepped:Connect(function()
        if not state.Aimbot then return end
        local char = LocalPlayer.Character
        if not char then return end

        local alvo = nil
        local menorDist = state.FOV  -- usa FOV configurável
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
                Camera.CFrame = Camera.CFrame:Lerp(novoCF, 0.25)
            end
        end
    end)
end

-- ========== ESP (Box, Line, Name, Health) ==========
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

        -- Box
        if state.ESPBox then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "ESP_Box"
            box.Size = Vector3.new(4, 6, 2)
            box.CFrame = root.CFrame
            box.Color3 = Color3.fromRGB(255, 0, 0)
            box.Transparency = 0.4
            box.ZIndex = 0
            box.AlwaysOnTop = true
            box.Parent = root
            table.insert(espObjects, box)
        end

        -- Line (tracer)
        if state.ESPLine then
            local line = Instance.new("LineHandleAdornment")
            line.Name = "ESP_Line"
            line.Color3 = Color3.fromRGB(0, 255, 0)
            line.Thickness = 1.5
            line.Transparency = 0.3
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

        -- Name
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
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = nameTag
            table.insert(espObjects, nameTag)
        end

        -- Health
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

            -- Atualiza vida
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

    -- Aplica em todos
    for _, jog in pairs(Players:GetPlayers()) do
        criarESP(jog)
    end

    -- Novo jogador
    espConnections[1] = Players.PlayerAdded:Connect(function(jog)
        jog.CharacterAdded:Connect(function()
            task.wait(0.5)
            if state.ESP then criarESP(jog) end
        end)
    end)

    -- Atualização contínua (para line e box seguirem)
    espConnections[2] = RunService.RenderStepped:Connect(function()
        if not state.ESP then return end
        for _, jog in pairs(Players:GetPlayers()) do
            if jog ~= LocalPlayer and jog.Character then
                local root = jog.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    -- Atualiza Box
                    local box = root:FindFirstChild("ESP_Box")
                    if box and state.ESPBox then
                        box.CFrame = root.CFrame
                    end
                    -- Atualiza Line
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
    if ativo then
        atualizarESP()
    else
        limparESP()
    end
end

-- Sub-funções para toggles específicos
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

-- ========== PERSISTÊNCIA AO RENASCER ==========
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if state.InfiniteJump then toggleInfiniteJump(true) end
    if state.Noclip then toggleNoclip(true) end
    if state.Speed ~= 16 then setSpeed(state.Speed) end
    if state.ESP then atualizarESP() end
end)

-- ========== CRIAÇÃO DOS ELEMENTOS DA GUI ==========

-- Aba Aimbot
criarToggle(framesAbas[1], "Aimbot", 10, toggleAimbot)
criarSlider(framesAbas[1], "FOV", 55, 50, 300, 150, function(val)
    state.FOV = val
end)

-- Aba ESP
criarToggle(framesAbas[2], "ESP Geral", 10, toggleESP)
criarToggle(framesAbas[2], "Box", 55, toggleESPBox)
criarToggle(framesAbas[2], "Linha (Tracer)", 95, toggleESPLine)
criarToggle(framesAbas[2], "Nome", 135, toggleESPName)
criarToggle(framesAbas[2], "Vida", 175, toggleESPHealth)

-- Aba Movimento
criarToggle(framesAbas[3], "Infinite Jump", 10, toggleInfiniteJump)
criarToggle(framesAbas[3], "Noclip", 55, toggleNoclip)
criarSlider(framesAbas[3], "Velocidade", 100, 10, 100, 16, setSpeed)

-- Aba Config
local reset = Instance.new("TextButton")
reset.Size = UDim2.new(0.8, 0, 0, 40)
reset.Position = UDim2.new(0.1, 0, 0, 20)
reset.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
reset.BorderSizePixel = 0
reset.Text = "🔄 RESTAURAR PADRÃO"
reset.TextColor3 = Color3.fromRGB(255, 255, 255)
reset.TextScaled = true
reset.Font = Enum.Font.GothamBold
reset.Parent = framesAbas[4]
reset.MouseButton1Click:Connect(function()
    toggleAimbot(false)
    toggleESP(false)
    toggleInfiniteJump(false)
    toggleNoclip(false)
    setSpeed(16)
    state.ESPBox = false
    state.ESPLine = false
    state.ESPName = false
    state.ESPHealth = false
    state.FOV = 150
    limparESP()
    -- Atualizar textos dos toggles (opcional - pode ser feito reiniciando a GUI)
    print("Configurações restauradas!")
end)

-- ========== BOLINHA: ABRIR/FECHAR GUI ==========
bolinha.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    bolinha.Visible = not frame.Visible
    if frame.Visible then
        -- Liga aimbot e ESP automaticamente ao abrir? (deixamos o usuário ativar pelos toggles)
        -- Apenas exibe a GUI
    end
end)

print("✅ GOD HUB carregado! Clique na bolinha do Gojo.")
