--[[
    ╔══════════════════════════════════════════════════════════╗
    ║     PLALETTE SCRIPTS - MURDERERS VS SHERIFFS DUELS    ║
    ║     Professional Edition · Lila Theme                  ║
    ╚══════════════════════════════════════════════════════════╝
]]

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

-- ==================== SETTINGS ====================
local AimbotOn = false
local AimbotFOV = 120
local AimbotSmooth = 0.35
local SilentOn = false
local TriggerOn = false
local HitboxOn = false
local HitboxSz = 3
local ESPOn = false
local ESPBoxOn = true
local ESPNameOn = true
local ESPDistOn = true
local ESPHealthOn = true
local TracersOn = false
local RadarOn = false
local SpeedOn = false
local SpeedVal = 28
local FlyOn = false
local FlyVal = 30
local JumpOn = false
local JumpVal = 60
local StreakChanger = false
local StreakVal = 50
local BrightOn = false
local NoRecoilOn = false
local NoSpreadOn = false
local InstantReloadOn = false

local ESPD = {}
local FOVC = nil
local StreakRemote = nil

-- ==================== COLORS (LILA THEME) ====================
local C = {
    Primary = Color3.fromRGB(140, 80, 255),
    Secondary = Color3.fromRGB(180, 130, 255),
    Dark = Color3.fromRGB(14, 12, 24),
    Surface = Color3.fromRGB(22, 18, 36),
    Card = Color3.fromRGB(26, 24, 38),
    Text = Color3.fromRGB(230, 220, 255),
    Muted = Color3.fromRGB(160, 140, 180),
    Danger = Color3.fromRGB(220, 50, 70),
    Success = Color3.fromRGB(50, 200, 100),
    White = Color3.fromRGB(255, 255, 255)
}

-- ==================== HELPER ====================
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
    AimbotOn = false
    SilentOn = false
    TriggerOn = false
    HitboxOn = false
    ESPOn = false
    TracersOn = false
    RadarOn = false
    SpeedOn = false
    FlyOn = false
    JumpOn = false
    StreakChanger = false
    BrightOn = false
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

-- ==================== UI COMPONENTS ====================
local function Round(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
end

local function CreateSection(page, title)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 22)
    section.BackgroundTransparency = 1
    section.Parent = page

    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 3, 1, 0)
    line.Position = UDim2.new(0, 0, 0, 0)
    line.BackgroundColor3 = C.Primary
    line.BorderSizePixel = 0
    line.Parent = section
    Round(line, 2)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = C.Text
    label.Text = title
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section

    page.CanvasSize = UDim2.new(0, 0, 0, page.CanvasSize.Y.Offset + 26)
end

local function CreateToggle(page, name, varName)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = C.Card
    frame.Parent = page
    Round(frame, 6)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.55, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = C.Text
    label.Text = name
    label.Font = Enum.Font.SourceSansMedium
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 40, 0, 22)
    track.Position = UDim2.new(1, -52, 0, 7)
    track.BackgroundColor3 = Color3.fromRGB(45, 40, 55)
    track.BorderSizePixel = 0
    track.Parent = frame
    Round(track, 11)

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 18, 0, 18)
    thumb.Position = UDim2.new(0, 2, 0, 2)
    thumb.BackgroundColor3 = Color3.fromRGB(180, 170, 200)
    thumb.BorderSizePixel = 0
    thumb.Parent = track
    Round(thumb, 9)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = track

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        if varName == "Aimbot" then AimbotOn = on
        elseif varName == "Silent" then SilentOn = on
        elseif varName == "Trigger" then TriggerOn = on
        elseif varName == "Hitbox" then HitboxOn = on
        elseif varName == "ESP" then ESPOn = on
        elseif varName == "ESPBox" then ESPBoxOn = on
        elseif varName == "ESPName" then ESPNameOn = on
        elseif varName == "ESPDist" then ESPDistOn = on
        elseif varName == "ESPHealth" then ESPHealthOn = on
        elseif varName == "Tracers" then TracersOn = on
        elseif varName == "Radar" then RadarOn = on
        elseif varName == "Speed" then SpeedOn = on
        elseif varName == "Fly" then FlyOn = on
        elseif varName == "Jump" then JumpOn = on
        elseif varName == "Streak" then StreakChanger = on
        elseif varName == "Bright" then BrightOn = on
        elseif varName == "NoRecoil" then NoRecoilOn = on
        elseif varName == "NoSpread" then NoSpreadOn = on
        elseif varName == "Reload" then InstantReloadOn = on
        end

        TweenService:Create(track, TweenInfo.new(0.2), {
            BackgroundColor3 = on and C.Primary or Color3.fromRGB(45, 40, 55)
        }):Play()
        TweenService:Create(thumb, TweenInfo.new(0.2), {
            Position = on and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2),
            BackgroundColor3 = on and C.White or Color3.fromRGB(180, 170, 200)
        }):Play()
    end)

    page.CanvasSize = UDim2.new(0, 0, 0, page.CanvasSize.Y.Offset + 40)
end

local function CreateSlider(page, name, varName, min, max, def)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.BackgroundColor3 = C.Card
    frame.Parent = page
    Round(frame, 6)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 0, 20)
    label.Position = UDim2.new(0, 12, 0, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = C.Text
    label.Text = name
    label.Font = Enum.Font.SourceSansMedium
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local value = Instance.new("TextLabel")
    value.Size = UDim2.new(0, 45, 0, 20)
    value.Position = UDim2.new(1, -57, 0, 4)
    value.BackgroundTransparency = 1
    value.TextColor3 = C.Secondary
    value.Text = tostring(def)
    value.Font = Enum.Font.SourceSansBold
    value.TextSize = 13
    value.TextXAlignment = Enum.TextXAlignment.Right
    value.Parent = frame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.3, 0, 0, 22)
    input.Position = UDim2.new(0.35, 0, 0, 26)
    input.BackgroundColor3 = Color3.fromRGB(40, 36, 50)
    input.TextColor3 = C.White
    input.Text = tostring(def)
    input.Font = Enum.Font.SourceSans
    input.TextSize = 12
    input.Parent = frame
    Round(input, 4)

    input.FocusLost:Connect(function()
        local v = tonumber(input.Text)
        if v and v >= min and v <= max then
            if varName == "AimR" then AimbotFOV = v
            elseif varName == "HitS" then HitboxSz = v
            elseif varName == "SpdV" then SpeedVal = v
            elseif varName == "JumpV" then JumpVal = v
            elseif varName == "FlyV" then FlyVal = v
            elseif varName == "StreakV" then StreakVal = v
            end
            value.Text = tostring(v)
        else
            local cur = def
            if varName == "AimR" then cur = AimbotFOV
            elseif varName == "HitS" then cur = HitboxSz
            elseif varName == "SpdV" then cur = SpeedVal
            elseif varName == "JumpV" then cur = JumpVal
            elseif varName == "FlyV" then cur = FlyVal
            elseif varName == "StreakV" then cur = StreakVal
            end
            input.Text = tostring(cur)
        end
    end)

    page.CanvasSize = UDim2.new(0, 0, 0, page.CanvasSize.Y.Offset + 54)
end

-- ==================== MAIN GUI ====================
local GUI = Instance.new("ScreenGui")
GUI.Name = "PlaletteMvSD"
GUI.ResetOnSpawn = false
GUI.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 580, 0, 400)
Main.Position = UDim2.new(0.5, -290, 0.5, -200)
Main.BackgroundColor3 = C.Dark
Main.BackgroundTransparency = 0.02
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = GUI
Round(Main, 10)

-- Glow Border
local Glow = Instance.new("Frame")
Glow.Size = UDim2.new(1, 2, 1, 2)
Glow.Position = UDim2.new(0, -1, 0, -1)
Glow.BackgroundColor3 = C.Primary
Glow.BackgroundTransparency = 0.5
Glow.BorderSizePixel = 0
Glow.Parent = Main
Round(Glow, 10)

task.spawn(function()
    local a = 0
    while GUI and GUI.Parent do
        a = (a + 0.015) % (math.pi * 2)
        pcall(function() Glow.BackgroundTransparency = 0.45 - math.sin(a) * 0.2 end)
        task.wait(0.04)
    end
end)

-- Minimized
local Mini = Instance.new("Frame")
Mini.Size = UDim2.new(0, 190, 0, 30)
Mini.Position = UDim2.new(0.5, -95, 0.02, 0)
Mini.BackgroundColor3 = C.Dark
Mini.BackgroundTransparency = 0.02
Mini.BorderSizePixel = 0
Mini.Visible = false
Mini.Active = true
Mini.Draggable = true
Mini.Parent = GUI
Round(Mini, 8)

local MiniText = Instance.new("TextLabel")
MiniText.Size = UDim2.new(1, 0, 1, 0)
MiniText.BackgroundTransparency = 1
MiniText.TextColor3 = C.Secondary
MiniText.Text = "MvSD · Plalette Scripts"
MiniText.Font = Enum.Font.SourceSansBold
MiniText.TextSize = 11
MiniText.Parent = Mini

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
        Mini.Visible = not Mini.Visible
    end
end)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 46)
Header.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
Header.BorderSizePixel = 0
Header.Parent = Main
Round(Header, 10)

local HeaderAccent = Instance.new("Frame")
HeaderAccent.Size = UDim2.new(1, 0, 0, 2)
HeaderAccent.Position = UDim2.new(0, 0, 1, -2)
HeaderAccent.BackgroundColor3 = C.Primary
HeaderAccent.BorderSizePixel = 0
HeaderAccent.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(0.6, 0, 0.5, 0)
HeaderTitle.Position = UDim2.new(0, 16, 0, 4)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.TextColor3 = C.White
HeaderTitle.Text = "Murderers vs Sheriffs DUELS"
HeaderTitle.Font = Enum.Font.SourceSansBold
HeaderTitle.TextSize = 15
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local HeaderSub = Instance.new("TextLabel")
HeaderSub.Size = UDim2.new(0.6, 0, 0.35, 0)
HeaderSub.Position = UDim2.new(0, 16, 0, 26)
HeaderSub.BackgroundTransparency = 1
HeaderSub.TextColor3 = C.Muted
HeaderSub.Text = "Plalette Scripts · Professional Edition"
HeaderSub.Font = Enum.Font.SourceSans
HeaderSub.TextSize = 10
HeaderSub.TextXAlignment = Enum.TextXAlignment.Left
HeaderSub.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 28)
CloseBtn.Position = UDim2.new(1, -38, 0, 9)
CloseBtn.BackgroundColor3 = C.Danger
CloseBtn.TextColor3 = C.White
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 15
CloseBtn.Parent = Header
Round(CloseBtn, 5)
CloseBtn.MouseButton1Click:Connect(function()
    StopAll()
    GUI:Destroy()
end)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, -46)
Sidebar.Position = UDim2.new(0, 0, 0, 46)
Sidebar.BackgroundColor3 = C.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 2)
SidebarList.FillDirection = Enum.FillDirection.Vertical
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -160, 1, -72)
Content.Position = UDim2.new(0, 160, 0, 46)
Content.BackgroundColor3 = Color3.fromRGB(16, 14, 24)
Content.BorderSizePixel = 0
Content.Parent = Main

-- Footer
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, -160, 0, 26)
Footer.Position = UDim2.new(0, 160, 1, -26)
Footer.BackgroundColor3 = C.Surface
Footer.BorderSizePixel = 0
Footer.Parent = Main

local FooterAvatar = Instance.new("ImageLabel")
FooterAvatar.Size = UDim2.new(0, 30, 0, 30)
FooterAvatar.Position = UDim2.new(0, 8, 0.5, -15)
FooterAvatar.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
FooterAvatar.BorderSizePixel = 0
FooterAvatar.Parent = Footer
Round(FooterAvatar, 15)

task.spawn(function()
    FooterAvatar.Image = Players:GetUserThumbnailAsync(
        LocalPlayer.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size48x48
    )
end)

local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.BackgroundTransparency = 1
FooterText.TextColor3 = C.Muted
FooterText.Text = "Welcome, " .. LocalPlayer.Name .. "  ·  Plalette Scripts"
FooterText.Font = Enum.Font.SourceSans
FooterText.TextSize = 11
FooterText.TextXAlignment = Enum.TextXAlignment.Center
FooterText.Parent = Footer

-- ==================== TAB SYSTEM ====================
local AllTabs = {}

local function CreateTab(name, icon)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(26, 22, 38)
    Btn.TextColor3 = C.Muted
    Btn.Text = "  " .. icon .. "  " .. name
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 12
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = Sidebar
    Round(Btn, 6)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, -16, 1, -16)
    Page.Position = UDim2.new(0, 8, 0, 8)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = C.Primary
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page.Parent = Content

    local PageList = Instance.new("UIListLayout")
    PageList.Padding = UDim.new(0, 4)
    PageList.FillDirection = Enum.FillDirection.Vertical
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Parent = Page

    Btn.MouseButton1Click:Connect(function()
        for _, b in ipairs(Sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(26, 22, 38)
                b.TextColor3 = C.Muted
            end
        end
        for _, p in pairs(AllTabs) do p.Visible = false end
        Btn.BackgroundColor3 = C.Primary
        Btn.TextColor3 = C.White
        Page.Visible = true
    end)

    table.insert(AllTabs, Page)
    if #AllTabs == 1 then
        Btn.BackgroundColor3 = C.Primary
        Btn.TextColor3 = C.White
        Page.Visible = true
    end
    return Page
end

-- Create Tabs
local HomePage = CreateTab("Home", "HS")
local CombatPage = CreateTab("Combat", "CO")
local VisualPage = CreateTab("Visuals", "VI")
local CharPage = CreateTab("Character", "CH")
local SettingsPage = CreateTab("Settings", "SE")

-- HOME
local wf = Instance.new("Frame")
wf.Size = UDim2.new(1, 0, 0, 100)
wf.BackgroundColor3 = C.Card
wf.Parent = HomePage
Round(wf, 8)

local wt = Instance.new("TextLabel")
wt.Size = UDim2.new(1, -20, 0, 30)
wt.Position = UDim2.new(0, 12, 0, 14)
wt.BackgroundTransparency = 1
wt.TextColor3 = C.White
wt.Text = "Welcome, " .. LocalPlayer.Name
wt.Font = Enum.Font.SourceSansBold
wt.TextSize = 18
wt.TextXAlignment = Enum.TextXAlignment.Left
wt.Parent = wf

local wi = Instance.new("TextLabel")
wi.Size = UDim2.new(1, -20, 0, 35)
wi.Position = UDim2.new(0, 12, 0, 50)
wi.BackgroundTransparency = 1
wi.TextColor3 = C.Muted
wi.Text = "Murderers vs Sheriffs DUELS\nPlalette Scripts · Lila Edition\nCTRL = Hide | X = Emergency Stop"
wi.Font = Enum.Font.SourceSans
wi.TextSize = 12
wi.TextXAlignment = Enum.TextXAlignment.Left
wi.Parent = wf
HomePage.CanvasSize = UDim2.new(0, 0, 0, 120)

-- COMBAT
CreateSection(CombatPage, "Aimbot")
CreateToggle(CombatPage, "FOV Aimbot", "Aimbot")
CreateSlider(CombatPage, "FOV Radius", "AimR", 30, 300, 120)
CreateToggle(CombatPage, "Silent Aim", "Silent")
CreateToggle(CombatPage, "Triggerbot", "Trigger")
CreateSection(CombatPage, "Weapon Mods")
CreateToggle(CombatPage, "Hitbox Expander", "Hitbox")
CreateSlider(CombatPage, "Hitbox Size", "HitS", 1, 8, 3)
CreateToggle(CombatPage, "No Recoil", "NoRecoil")
CreateToggle(CombatPage, "No Spread", "NoSpread")
CreateToggle(CombatPage, "Instant Reload", "Reload")

-- VISUALS
CreateSection(VisualPage, "Player ESP")
CreateToggle(VisualPage, "Player ESP", "ESP")
CreateToggle(VisualPage, "Boxes", "ESPBox")
CreateToggle(VisualPage, "Names", "ESPName")
CreateToggle(VisualPage, "Distance", "ESPDist")
CreateToggle(VisualPage, "Health Bar", "ESPHealth")
CreateToggle(VisualPage, "Tracers", "Tracers")
CreateToggle(VisualPage, "Radar", "Radar")

-- CHARACTER
CreateSection(CharPage, "Movement")
CreateToggle(CharPage, "Speed Hack", "Speed")
CreateSlider(CharPage, "Walk Speed", "SpdV", 16, 35, 28)
CreateToggle(CharPage, "Infinite Jump", "Jump")
CreateSlider(CharPage, "Jump Power", "JumpV", 50, 200, 60)
CreateToggle(CharPage, "Fly", "Fly")
CreateSlider(CharPage, "Fly Speed", "FlyV", 15, 50, 30)
CreateSection(CharPage, "Stats")
CreateToggle(CharPage, "Streak Changer", "Streak")
CreateSlider(CharPage, "Streak Value", "StreakV", 1, 1000, 50)

-- SETTINGS
CreateSection(SettingsPage, "World")
CreateToggle(SettingsPage, "Fullbright", "Bright")

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 0, 70)
infoFrame.BackgroundColor3 = C.Card
infoFrame.Parent = SettingsPage
Round(infoFrame, 8)

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -20, 1, -16)
infoText.Position = UDim2.new(0, 10, 0, 8)
infoText.BackgroundTransparency = 1
infoText.TextColor3 = C.Muted
infoText.Text = "Plalette Scripts · MvSD\nplalettescripts\nX = Emergency Stop"
infoText.Font = Enum.Font.SourceSans
infoText.TextSize = 11
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.Parent = infoFrame
SettingsPage.CanvasSize = UDim2.new(0, 0, 0, SettingsPage.CanvasSize.Y.Offset + 90)

-- ==================== FEATURES ====================

-- FOV Circle
task.spawn(function()
    while task.wait(0.03) do
        if AimbotOn then
            if not FOVC then FOVC = Drawing.new("Circle") end
            FOVC.Visible = true
            FOVC.Radius = AimbotFOV
            FOVC.Thickness = 1.5
            FOVC.Color = C.Primary
            FOVC.Filled = false
            FOVC.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            if FOVC then FOVC.Visible = false end
        end
    end
end)

-- Silent Aim
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

-- Triggerbot
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

-- Hitbox Expander
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

-- Instant Reload
task.spawn(function()
    while task.wait(0.1) do
        if InstantReloadOn then
            pcall(function()
                for _, t in ipairs(LocalPlayer.Backpack:GetChildren()) do
                    if t:IsA("Tool") and t:FindFirstChild("Ammo") then
                        t.Ammo.Value = 99
                    end
                end
                local ct = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if ct and ct:FindFirstChild("Ammo") then ct.Ammo.Value = 99 end
            end)
        end
    end
end)

-- Streak Changer
task.spawn(function()
    while task.wait(1) do
        if StreakChanger then
            pcall(function()
                -- Suche nach Streak-Wert in Leaderstats oder PlayerGui
                local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
                if leaderstats then
                    local streak = leaderstats:FindFirstChild("Streak") or leaderstats:FindFirstChild("Kills")
                    if streak and streak:IsA("IntValue") then
                        streak.Value = StreakVal
                    end
                end
                -- Remote für Streak
                if not StreakRemote then
                    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
                        if obj:IsA("RemoteEvent") and (obj.Name:lower():find("streak") or obj.Name:lower():find("kill")) then
                            StreakRemote = obj
                        end
                    end
                end
                if StreakRemote then
                    StreakRemote:FireServer(StreakVal)
                end
            end)
        end
    end
end)

-- ESP
task.spawn(function()
    while task.wait(0.06) do
        ClearESP()
        if ESPOn then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local head = p.Character:FindFirstChild("Head")
                    local root = p.Character:FindFirstChild("HumanoidRootPart")
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if head and root then
                        local hp, on = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local fp = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                        if on then
                            local h = math.abs(hp.Y - fp.Y)
                            local w = h / 2

                            if ESPBoxOn then
                                local box = Drawing.new("Square")
                                box.Color = C.Primary
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
                                nm.Color = C.White
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
                                    dt.Color = C.Muted
                                    dt.Size = 10
                                    dt.Position = Vector2.new(hp.X, hp.Y - 4)
                                    dt.Center = true
                                    dt.Visible = true
                                    table.insert(ESPD, dt)
                                end
                            end

                            if ESPHealthOn and hum then
                                local hpPercent = hum.Health / hum.MaxHealth
                                local barW = w
                                local barH = 3
                                local barX = hp.X - w / 2
                                local barY = fp.Y + 3
                                local bg = Drawing.new("Square")
                                bg.Color = Color3.fromRGB(40, 40, 40)
                                bg.Size = Vector2.new(barW, barH)
                                bg.Position = Vector2.new(barX, barY)
                                bg.Filled = true
                                bg.Visible = true
                                table.insert(ESPD, bg)
                                local fill = Drawing.new("Square")
                                fill.Color = hpPercent > 0.5 and C.Success or (hpPercent > 0.25 and Color3.fromRGB(255, 200, 50) or C.Danger)
                                fill.Size = Vector2.new(barW * hpPercent, barH)
                                fill.Position = Vector2.new(barX, barY)
                                fill.Filled = true
                                fill.Visible = true
                                table.insert(ESPD, fill)
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
                            ln.Color = C.Secondary
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
                                dt.Color = pl == LocalPlayer and Color3.fromRGB(0, 255, 0) or C.Primary
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

-- Speed + Jump
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

-- Fly
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

-- Fullbright
task.spawn(function()
    while task.wait(60) do
        if BrightOn then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
        end
        -- Anti-AFK
        pcall(function()
            local VIM = game:GetService("VirtualInputManager")
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, nil)
            task.wait(0.1)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, nil)
        end)
    end
end)

print("Plalette Scripts · MvSD DUELS · Lila Edition")
