-- Plalette Scripts · MvSD DUELS v1.1 | plalettescripts
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Settings
local AimbotOn = false
local AimbotFOV = 120
local SilentOn = false
local TriggerOn = false
local HitboxOn = false
local HitboxSz = 3
local ESPOn = false
local ESPBoxOn = true
local ESPNameOn = true
local ESPDistOn = true
local TracersOn = false
local RadarOn = false
local SpeedOn = false
local SpeedVal = 28
local FlyOn = false
local FlyVal = 30
local JumpOn = false
local JumpVal = 60
local StreakOn = false
local StreakVal = 50
local BrightOn = false
local ReloadOn = false

local ESPD = {}
local FOVC = nil

-- Colors
local C1 = Color3.fromRGB(140, 80, 255)
local C2 = Color3.fromRGB(180, 130, 255)
local C3 = Color3.fromRGB(14, 12, 24)
local C4 = Color3.fromRGB(22, 18, 36)
local C5 = Color3.fromRGB(26, 24, 38)
local C6 = Color3.fromRGB(230, 220, 255)
local C7 = Color3.fromRGB(160, 140, 180)
local C8 = Color3.fromRGB(255, 255, 255)
local C9 = Color3.fromRGB(220, 50, 70)

local function ClearESP()
    for _, d in pairs(ESPD) do pcall(function() d:Remove() end) end
    ESPD = {}
    if FOVC then pcall(function() FOVC:Remove() end) FOVC = nil end
end

local function GetTarget()
    local cl = 99999
    local t = nil
    local cx = Camera.ViewportSize.X / 2
    local cy = Camera.ViewportSize.Y / 2
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("Head")
            if h then
                local pos, on = Camera:WorldToViewportPoint(h.Position)
                if on then
                    local dx = pos.X - cx
                    local dy = pos.Y - cy
                    local d = math.sqrt(dx * dx + dy * dy)
                    if d < AimbotFOV and d < cl then
                        cl = d
                        t = p
                    end
                end
            end
        end
    end
    return t
end

local function StopAll()
    AimbotOn = false SilentOn = false TriggerOn = false HitboxOn = false
    ESPOn = false TracersOn = false RadarOn = false SpeedOn = false
    FlyOn = false JumpOn = false StreakOn = false BrightOn = false
    ClearESP()
    if LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
        local r = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if r then
            for _, c in ipairs(r:GetChildren()) do
                if c:IsA("BodyGyro") or c:IsA("BodyVelocity") then c:Destroy() end
            end
        end
    end
    Lighting.Brightness = 1
end

-- ==================== GUI ====================
local GUI = Instance.new("ScreenGui")
GUI.Name = "PlaletteMvSD"
GUI.ResetOnSpawn = false
GUI.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 580, 0, 400)
Main.Position = UDim2.new(0.5, -290, 0.5, -200)
Main.BackgroundColor3 = C3
Main.BackgroundTransparency = 0.02
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = GUI
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Glow = Instance.new("Frame")
Glow.Size = UDim2.new(1, 2, 1, 2)
Glow.Position = UDim2.new(0, -1, 0, -1)
Glow.BackgroundColor3 = C1
Glow.BackgroundTransparency = 0.5
Glow.BorderSizePixel = 0
Glow.Parent = Main
Instance.new("UICorner", Glow).CornerRadius = UDim.new(0, 10)

task.spawn(function()
    local a = 0
    while GUI and GUI.Parent do
        a = (a + 0.015) % (math.pi * 2)
        pcall(function() Glow.BackgroundTransparency = 0.45 - math.sin(a) * 0.2 end)
        task.wait(0.04)
    end
end)

local Mini = Instance.new("Frame")
Mini.Size = UDim2.new(0, 190, 0, 30)
Mini.Position = UDim2.new(0.5, -95, 0.02, 0)
Mini.BackgroundColor3 = C3
Mini.BackgroundTransparency = 0.02
Mini.BorderSizePixel = 0
Mini.Visible = false
Mini.Active = true
Mini.Draggable = true
Mini.Parent = GUI
Instance.new("UICorner", Mini).CornerRadius = UDim.new(0, 8)
local MT = Instance.new("TextLabel")
MT.Size = UDim2.new(1, 0, 1, 0)
MT.BackgroundTransparency = 1
MT.TextColor3 = C2
MT.Text = "MvSD · Plalette Scripts"
MT.Font = Enum.Font.SourceSansBold
MT.TextSize = 11
MT.Parent = Mini

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
        Mini.Visible = not Mini.Visible
    end
end)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 46)
Header.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderAccent = Instance.new("Frame")
HeaderAccent.Size = UDim2.new(1, 0, 0, 2)
HeaderAccent.Position = UDim2.new(0, 0, 1, -2)
HeaderAccent.BackgroundColor3 = C1
HeaderAccent.BorderSizePixel = 0
HeaderAccent.Parent = Header

local HT = Instance.new("TextLabel")
HT.Size = UDim2.new(0.6, 0, 0.5, 0)
HT.Position = UDim2.new(0, 16, 0, 4)
HT.BackgroundTransparency = 1
HT.TextColor3 = C8
HT.Text = "Murderers vs Sheriffs DUELS"
HT.Font = Enum.Font.SourceSansBold
HT.TextSize = 15
HT.TextXAlignment = Enum.TextXAlignment.Left
HT.Parent = Header

local HS = Instance.new("TextLabel")
HS.Size = UDim2.new(0.6, 0, 0.35, 0)
HS.Position = UDim2.new(0, 16, 0, 26)
HS.BackgroundTransparency = 1
HS.TextColor3 = C7
HS.Text = "Plalette Scripts"
HS.Font = Enum.Font.SourceSans
HS.TextSize = 10
HS.TextXAlignment = Enum.TextXAlignment.Left
HS.Parent = Header

local CB = Instance.new("TextButton")
CB.Size = UDim2.new(0, 30, 0, 28)
CB.Position = UDim2.new(1, -38, 0, 9)
CB.BackgroundColor3 = C9
CB.TextColor3 = C8
CB.Text = "✕"
CB.Font = Enum.Font.SourceSansBold
CB.TextSize = 15
CB.Parent = Header
Instance.new("UICorner", CB).CornerRadius = UDim.new(0, 5)
CB.MouseButton1Click:Connect(function() StopAll() GUI:Destroy() end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, -46)
Sidebar.Position = UDim2.new(0, 0, 0, 46)
Sidebar.BackgroundColor3 = C4
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SBL = Instance.new("UIListLayout")
SBL.Padding = UDim.new(0, 2)
SBL.FillDirection = Enum.FillDirection.Vertical
SBL.HorizontalAlignment = Enum.HorizontalAlignment.Center
SBL.SortOrder = Enum.SortOrder.LayoutOrder
SBL.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -150, 1, -72)
Content.Position = UDim2.new(0, 150, 0, 46)
Content.BackgroundColor3 = Color3.fromRGB(16, 14, 24)
Content.BorderSizePixel = 0
Content.Parent = Main

local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, -150, 0, 26)
Footer.Position = UDim2.new(0, 150, 1, -26)
Footer.BackgroundColor3 = C4
Footer.BorderSizePixel = 0
Footer.Parent = Main

local FA = Instance.new("ImageLabel")
FA.Size = UDim2.new(0, 30, 0, 30)
FA.Position = UDim2.new(0, 8, 0.5, -15)
FA.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
FA.BorderSizePixel = 0
FA.Parent = Footer
Instance.new("UICorner", FA).CornerRadius = UDim.new(0, 15)
task.spawn(function() FA.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) end)

local FL = Instance.new("TextLabel")
FL.Size = UDim2.new(1, 0, 1, 0)
FL.BackgroundTransparency = 1
FL.TextColor3 = C7
FL.Text = "Welcome, " .. LocalPlayer.Name .. "  ·  Plalette Scripts"
FL.Font = Enum.Font.SourceSans
FL.TextSize = 11
FL.TextXAlignment = Enum.TextXAlignment.Center
FL.Parent = Footer

-- ==================== TAB SYSTEM ====================
local AllTabs = {}

local function MakeTab(name, icon)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -8, 0, 34)
    Btn.BackgroundColor3 = Color3.fromRGB(26, 22, 38)
    Btn.TextColor3 = C7
    Btn.Text = "  " .. icon .. "  " .. name
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 12
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, -16, 1, -16)
    Page.Position = UDim2.new(0, 8, 0, 8)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = C1
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page.Parent = Content

    local PL = Instance.new("UIListLayout")
    PL.Padding = UDim.new(0, 4)
    PL.FillDirection = Enum.FillDirection.Vertical
    PL.SortOrder = Enum.SortOrder.LayoutOrder
    PL.Parent = Page

    Btn.MouseButton1Click:Connect(function()
        for _, b in ipairs(Sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(26, 22, 38)
                b.TextColor3 = C7
            end
        end
        for _, p in pairs(AllTabs) do p.Visible = false end
        Btn.BackgroundColor3 = C1
        Btn.TextColor3 = C8
        Page.Visible = true
    end)

    table.insert(AllTabs, Page)
    if #AllTabs == 1 then
        Btn.BackgroundColor3 = C1
        Btn.TextColor3 = C8
        Page.Visible = true
    end
    return Page
end

-- ==================== UI ELEMENTS ====================
local function Sec(p, t)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 22)
    f.BackgroundTransparency = 1
    f.Parent = p
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 3, 1, 0)
    line.BackgroundColor3 = C1
    line.BorderSizePixel = 0
    line.Parent = f
    Instance.new("UICorner", line).CornerRadius = UDim.new(0, 2)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -10, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.BackgroundTransparency = 1
    l.TextColor3 = C6
    l.Text = t
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    p.CanvasSize = UDim2.new(0, 0, 0, p.CanvasSize.Y.Offset + 26)
end

local function Tog(p, n, vn)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 36)
    f.BackgroundColor3 = C5
    f.Parent = p
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.6, 0, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.BackgroundTransparency = 1
    l.TextColor3 = C6
    l.Text = n
    l.Font = Enum.Font.SourceSansMedium
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    local tr = Instance.new("Frame")
    tr.Size = UDim2.new(0, 40, 0, 22)
    tr.Position = UDim2.new(1, -52, 0, 7)
    tr.BackgroundColor3 = Color3.fromRGB(45, 40, 55)
    tr.BorderSizePixel = 0
    tr.Parent = f
    Instance.new("UICorner", tr).CornerRadius = UDim.new(0, 11)
    local th = Instance.new("Frame")
    th.Size = UDim2.new(0, 18, 0, 18)
    th.Position = UDim2.new(0, 2, 0, 2)
    th.BackgroundColor3 = Color3.fromRGB(180, 170, 200)
    th.BorderSizePixel = 0
    th.Parent = tr
    Instance.new("UICorner", th).CornerRadius = UDim.new(0, 9)
    local tb = Instance.new("TextButton")
    tb.Size = UDim2.new(1, 0, 1, 0)
    tb.BackgroundTransparency = 1
    tb.Text = ""
    tb.Parent = tr
    local on = false
    tb.MouseButton1Click:Connect(function()
        on = not on
        if vn == "Aimbot" then AimbotOn = on
        elseif vn == "Silent" then SilentOn = on
        elseif vn == "Trigger" then TriggerOn = on
        elseif vn == "Hitbox" then HitboxOn = on
        elseif vn == "ESP" then ESPOn = on
        elseif vn == "ESPBox" then ESPBoxOn = on
        elseif vn == "ESPName" then ESPNameOn = on
        elseif vn == "ESPDist" then ESPDistOn = on
        elseif vn == "Tracers" then TracersOn = on
        elseif vn == "Radar" then RadarOn = on
        elseif vn == "Speed" then SpeedOn = on
        elseif vn == "Fly" then FlyOn = on
        elseif vn == "Jump" then JumpOn = on
        elseif vn == "Streak" then StreakOn = on
        elseif vn == "Bright" then BrightOn = on
        elseif vn == "Reload" then ReloadOn = on
        end
        TweenService:Create(tr, TweenInfo.new(0.2), {BackgroundColor3 = on and C1 or Color3.fromRGB(45, 40, 55)}):Play()
        TweenService:Create(th, TweenInfo.new(0.2), {Position = on and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2), BackgroundColor3 = on and C8 or Color3.fromRGB(180, 170, 200)}):Play()
    end)
    p.CanvasSize = UDim2.new(0, 0, 0, p.CanvasSize.Y.Offset + 40)
end

local function Sli(p, n, vn, min, max, def)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 50)
    f.BackgroundColor3 = C5
    f.Parent = p
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.4, 0, 0, 20)
    l.Position = UDim2.new(0, 12, 0, 4)
    l.BackgroundTransparency = 1
    l.TextColor3 = C6
    l.Text = n
    l.Font = Enum.Font.SourceSansMedium
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    local vl = Instance.new("TextLabel")
    vl.Size = UDim2.new(0, 45, 0, 20)
    vl.Position = UDim2.new(1, -57, 0, 4)
    vl.BackgroundTransparency = 1
    vl.TextColor3 = C2
    vl.Text = tostring(def)
    vl.Font = Enum.Font.SourceSansBold
    vl.TextSize = 13
    vl.TextXAlignment = Enum.TextXAlignment.Right
    vl.Parent = f
    local inp = Instance.new("TextBox")
    inp.Size = UDim2.new(0.3, 0, 0, 22)
    inp.Position = UDim2.new(0.35, 0, 0, 26)
    inp.BackgroundColor3 = Color3.fromRGB(40, 36, 50)
    inp.TextColor3 = C8
    inp.Text = tostring(def)
    inp.Font = Enum.Font.SourceSans
    inp.TextSize = 12
    inp.Parent = f
    Instance.new("UICorner", inp).CornerRadius = UDim.new(0, 4)
    inp.FocusLost:Connect(function()
        local v = tonumber(inp.Text)
        if v and v >= min and v <= max then
            if vn == "AimR" then AimbotFOV = v
            elseif vn == "HitS" then HitboxSz = v
            elseif vn == "SpdV" then SpeedVal = v
            elseif vn == "JumpV" then JumpVal = v
            elseif vn == "FlyV" then FlyVal = v
            elseif vn == "StreakV" then StreakVal = v
            end
            vl.Text = tostring(v)
        else
            local cur = def
            if vn == "AimR" then cur = AimbotFOV
            elseif vn == "HitS" then cur = HitboxSz
            elseif vn == "SpdV" then cur = SpeedVal
            elseif vn == "JumpV" then cur = JumpVal
            elseif vn == "FlyV" then cur = FlyVal
            elseif vn == "StreakV" then cur = StreakVal
            end
            inp.Text = tostring(cur)
        end
    end)
    p.CanvasSize = UDim2.new(0, 0, 0, p.CanvasSize.Y.Offset + 54)
end

-- ==================== BUILD TABS ====================
local home = MakeTab("Home", "🏠")
local combat = MakeTab("Combat", "🎯")
local visual = MakeTab("Visuals", "👁")
local char = MakeTab("Character", "🏃")
local sett = MakeTab("Settings", "⚙️")

-- HOME
local wf = Instance.new("Frame")
wf.Size = UDim2.new(1, 0, 0, 90)
wf.BackgroundColor3 = C5
wf.Parent = home
Instance.new("UICorner", wf).CornerRadius = UDim.new(0, 8)
local wt = Instance.new("TextLabel")
wt.Size = UDim2.new(1, -20, 0, 30)
wt.Position = UDim2.new(0, 12, 0, 14)
wt.BackgroundTransparency = 1
wt.TextColor3 = C8
wt.Text = "Welcome, " .. LocalPlayer.Name
wt.Font = Enum.Font.SourceSansBold
wt.TextSize = 18
wt.TextXAlignment = Enum.TextXAlignment.Left
wt.Parent = wf
local wi = Instance.new("TextLabel")
wi.Size = UDim2.new(1, -20, 0, 30)
wi.Position = UDim2.new(0, 12, 0, 48)
wi.BackgroundTransparency = 1
wi.TextColor3 = C7
wi.Text = "MvSD DUELS · Plalette Scripts"
wi.Font = Enum.Font.SourceSans
wi.TextSize = 13
wi.TextXAlignment = Enum.TextXAlignment.Left
wi.Parent = wf
home.CanvasSize = UDim2.new(0, 0, 0, 110)

-- COMBAT
Sec(combat, "Aimbot")
Tog(combat, "FOV Aimbot", "Aimbot")
Sli(combat, "FOV Radius", "AimR", 30, 300, 120)
Tog(combat, "Silent Aim", "Silent")
Tog(combat, "Triggerbot", "Trigger")
Sec(combat, "Weapon")
Tog(combat, "Hitbox Expander", "Hitbox")
Sli(combat, "Hitbox Size", "HitS", 1, 8, 3)
Tog(combat, "Instant Reload", "Reload")

-- VISUALS
Sec(visual, "ESP")
Tog(visual, "Player ESP", "ESP")
Tog(visual, "Boxes", "ESPBox")
Tog(visual, "Names", "ESPName")
Tog(visual, "Distance", "ESPDist")
Tog(visual, "Tracers", "Tracers")
Tog(visual, "Radar", "Radar")

-- CHARACTER
Sec(char, "Movement")
Tog(char, "Speed Hack", "Speed")
Sli(char, "Walk Speed", "SpdV", 16, 35, 28)
Tog(char, "Infinite Jump", "Jump")
Sli(char, "Jump Power", "JumpV", 50, 200, 60)
Tog(char, "Fly", "Fly")
Sli(char, "Fly Speed", "FlyV", 15, 50, 30)
Sec(char, "Stats")
Tog(char, "Streak Changer", "Streak")
Sli(char, "Streak Value", "StreakV", 1, 1000, 50)

-- SETTINGS
Sec(sett, "World")
Tog(sett, "Fullbright", "Bright")

local inf = Instance.new("Frame")
inf.Size = UDim2.new(1, 0, 0, 60)
inf.BackgroundColor3 = C5
inf.Parent = sett
Instance.new("UICorner", inf).CornerRadius = UDim.new(0, 8)
local it = Instance.new("TextLabel")
it.Size = UDim2.new(1, -20, 1, -16)
it.Position = UDim2.new(0, 10, 0, 8)
it.BackgroundTransparency = 1
it.TextColor3 = C7
it.Text = "Plalette Scripts · MvSD\nX = Stop · CTRL = Hide"
it.Font = Enum.Font.SourceSans
it.TextSize = 11
it.TextXAlignment = Enum.TextXAlignment.Left
it.Parent = inf
sett.CanvasSize = UDim2.new(0, 0, 0, sett.CanvasSize.Y.Offset + 80)

-- ==================== FEATURES ====================

task.spawn(function()
    while task.wait(0.03) do
        if AimbotOn then
            if not FOVC then FOVC = Drawing.new("Circle") end
            FOVC.Visible = true
            FOVC.Radius = AimbotFOV
            FOVC.Thickness = 1.5
            FOVC.Color = C1
            FOVC.Filled = false
            FOVC.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            if FOVC then FOVC.Visible = false end
        end
    end
end)

local oldNC = hookmetamethod(game, "__namecall", function(s, ...)
    local m = getnamecallmethod()
    local a = {...}
    if m == "FireServer" and AimbotOn and SilentOn then
        local t = GetTarget()
        if t and t.Character then
            local h = t.Character:FindFirstChild("Head")
            if h and a[1] then a[1] = h.Position end
        end
    end
    return oldNC(s, unpack(a))
end)

task.spawn(function()
    while task.wait(0.06) do
        if TriggerOn and LocalPlayer.Character then
            pcall(function()
                local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    local t = GetTarget()
                    if t and t.Character then
                        local h = t.Character:FindFirstChild("Head")
                        if h then
                            local shoot = tool:FindFirstChild("Shoot")
                            if shoot then shoot:FireServer(h.Position) end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if HitboxOn then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local r = p.Character:FindFirstChild("HumanoidRootPart")
                    if r then
                        r.Size = Vector3.new(HitboxSz, HitboxSz, HitboxSz)
                        r.Transparency = 0.4
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if ReloadOn then
            pcall(function()
                for _, t in ipairs(LocalPlayer.Backpack:GetChildren()) do
                    if t:IsA("Tool") and t:FindFirstChild("Ammo") then t.Ammo.Value = 99 end
                end
                local ct = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if ct and ct:FindFirstChild("Ammo") then ct.Ammo.Value = 99 end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.06) do
        ClearESP()
        if ESPOn then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local head = p.Character:FindFirstChild("Head")
                    local root = p.Character:FindFirstChild("HumanoidRootPart")
                    if head and root then
                        local hp, on = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local fp = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                        if on then
                            local h = math.abs(hp.Y - fp.Y)
                            local w = h / 2
                            if ESPBoxOn then
                                local box = Drawing.new("Square")
                                box.Color = C1
                                box.Thickness = 1.2
                                box.Size = Vector2.new(w, h)
                                box.Position = Vector2.new(hp.X - w / 2, hp.Y)
                                box.Filled = false
                                box.Visible = true
                                table.insert(ESPD, box)
                            end
                            if ESPNameOn then
                                local nm = Drawing.new("Text")
                                nm.Text = p.Name
                                nm.Color = C8
                                nm.Size = 12
                                nm.Position = Vector2.new(hp.X, hp.Y - 18)
                                nm.Center = true
                                nm.Visible = true
                                table.insert(ESPD, nm)
                            end
                            if ESPDistOn and LocalPlayer.Character then
                                local mr = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if mr then
                                    local dt = Drawing.new("Text")
                                    dt.Text = math.floor((root.Position - mr.Position).Magnitude) .. "m"
                                    dt.Color = C7
                                    dt.Size = 10
                                    dt.Position = Vector2.new(hp.X, hp.Y - 4)
                                    dt.Center = true
                                    dt.Visible = true
                                    table.insert(ESPD, dt)
                                end
                            end
                        end
                    end
                end
            end
        end
        if TracersOn then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local r = p.Character:FindFirstChild("HumanoidRootPart")
                    if r then
                        local pos, on = Camera:WorldToViewportPoint(r.Position)
                        if on then
                            local ln = Drawing.new("Line")
                            ln.Color = C2
                            ln.Thickness = 0.5
                            ln.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            ln.To = Vector2.new(pos.X, pos.Y)
                            ln.Visible = true
                            table.insert(ESPD, ln)
                        end
                    end
                end
            end
        end
        if RadarOn then
            local rs = 55
            local rx = Camera.ViewportSize.X - rs - 8
            local ry = Camera.ViewportSize.Y - rs - 8
            local bg = Drawing.new("Square")
            bg.Color = Color3.fromRGB(0, 0, 0)
            bg.Size = Vector2.new(rs, rs)
            bg.Position = Vector2.new(rx, ry)
            bg.Filled = true
            bg.Visible = true
            table.insert(ESPD, bg)
            if LocalPlayer.Character then
                local mr = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if mr then
                    for _, pl in ipairs(Players:GetPlayers()) do
                        if pl.Character then
                            local pr = pl.Character:FindFirstChild("HumanoidRootPart")
                            if pr then
                                local off = pr.Position - mr.Position
                                local rd = math.clamp(off.Magnitude / 3, 0, rs / 2 - 2)
                                local a = math.atan2(off.Z, off.X)
                                local dx = rx + rs / 2 + math.cos(a) * rd
                                local dy = ry + rs / 2 + math.sin(a) * rd
                                local dt = Drawing.new("Circle")
                                dt.Color = pl == LocalPlayer and Color3.fromRGB(0, 255, 0) or C1
                                dt.Radius = 2
                                dt.Position = Vector2.new(dx, dy)
                                dt.Filled = true
                                dt.Visible = true
                                table.insert(ESPD, dt)
                            end
                        end
                    end
                end
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if SpeedOn and LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = SpeedVal end
    end
    if JumpOn and LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.JumpPower = JumpVal end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if JumpOn and LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

task.spawn(function()
    while task.wait() do
        if FlyOn and LocalPlayer.Character then
            local r = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if r then
                local g = r:FindFirstChild("FlyG") or Instance.new("BodyGyro", r)
                g.Name = "FlyG"
                g.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                g.CFrame = Camera.CFrame
                g.Parent = r
                local v = r:FindFirstChild("FlyV") or Instance.new("BodyVelocity", r)
                v.Name = "FlyV"
                v.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                v.Parent = r
                local m = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then m = m + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then m = m - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then m = m - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then m = m + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then m = m + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then m = m - Vector3.new(0, 1, 0) end
                v.Velocity = m * FlyVal
            end
        end
    end
end)

task.spawn(function()
    while task.wait(60) do
        if BrightOn then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
        end
        pcall(function()
            local VIM = game:GetService("VirtualInputManager")
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, nil)
            task.wait(0.1)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, nil)
        end)
    end
end)

print("Plalette Scripts · MvSD v1.1")
