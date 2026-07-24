-- Plalette Scripts · MvSD DUELS · v2.1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local PASS = "plalettescripts3754356"
local OK = false

local Aimbot = false
local FOV = 120
local Silent = false
local Hitbox = false
local HitboxS = 3
local Reload = false
local ESP = false
local Tracers = false
local Speed = false
local SpeedV = 32
local Fly = false
local FlyV = 30
local Jump = false
local JumpV = 60

local ESPD = {}
local FCI = nil

local function GT()
    local b = 99999
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
                    local d = math.sqrt(dx*dx + dy*dy)
                    if d < FOV and d < b then b = d t = p end
                end
            end
        end
    end
    return t
end

local function CE()
    for _, d in pairs(ESPD) do pcall(function() d:Remove() end) end
    ESPD = {}
    if FCI then pcall(function() FCI:Remove() end) FCI = nil end
end

local function SA()
    Aimbot = false Silent = false Hitbox = false Reload = false
    ESP = false Tracers = false Speed = false Fly = false Jump = false
    CE()
    if LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 h.JumpPower = 50 end
        local r = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if r then for _, c in ipairs(r:GetChildren()) do if c:IsA("BodyGyro") or c:IsA("BodyVelocity") then c:Destroy() end end end
    end
    Lighting.Brightness = 1
end

-- PASSWORD SCREEN
local PG = Instance.new("ScreenGui")
PG.Name = "PlaletteMvSD"
PG.ResetOnSpawn = false
PG.Parent = CoreGui

local PF = Instance.new("Frame")
PF.Size = UDim2.new(0, 280, 0, 200)
PF.Position = UDim2.new(0.5, -140, 0.5, -100)
PF.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
PF.BackgroundTransparency = 0.03
PF.BorderSizePixel = 0
PF.Active = true
PF.Draggable = true
PF.Parent = PG
Instance.new("UICorner", PF).CornerRadius = UDim.new(0, 10)

local PGL = Instance.new("Frame")
PGL.Size = UDim2.new(1, 2, 1, 2)
PGL.Position = UDim2.new(0, -1, 0, -1)
PGL.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
PGL.BackgroundTransparency = 0.5
PGL.BorderSizePixel = 0
PGL.Parent = PF
Instance.new("UICorner", PGL).CornerRadius = UDim.new(0, 10)

task.spawn(function()
    local a = 0
    while PG and PG.Parent and not OK do
        a = (a + 0.02) % (math.pi * 2)
        pcall(function() PGL.BackgroundTransparency = 0.45 - math.sin(a) * 0.2 end)
        task.wait(0.04)
    end
end)

local PT = Instance.new("TextLabel")
PT.Size = UDim2.new(1, 0, 0, 26)
PT.Position = UDim2.new(0, 0, 0, 18)
PT.BackgroundTransparency = 1
PT.TextColor3 = Color3.fromRGB(255, 255, 255)
PT.Text = "MvSD DUELS"
PT.Font = Enum.Font.SourceSansBold
PT.TextSize = 20
PT.Parent = PF

local PS = Instance.new("TextLabel")
PS.Size = UDim2.new(1, 0, 0, 16)
PS.Position = UDim2.new(0, 0, 0, 46)
PS.BackgroundTransparency = 1
PS.TextColor3 = Color3.fromRGB(180, 140, 200)
PS.Text = "Plalette Scripts"
PS.Font = Enum.Font.SourceSans
PS.TextSize = 13
PS.Parent = PF

local PI = Instance.new("TextBox")
PI.Size = UDim2.new(1, -40, 0, 30)
PI.Position = UDim2.new(0, 20, 0, 72)
PI.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
PI.BackgroundTransparency = 0.1
PI.TextColor3 = Color3.fromRGB(255, 255, 255)
PI.PlaceholderText = "Passwort eingeben..."
PI.PlaceholderColor3 = Color3.fromRGB(120, 100, 140)
PI.Text = ""
PI.Font = Enum.Font.SourceSans
PI.TextSize = 14
PI.Parent = PF
Instance.new("UICorner", PI).CornerRadius = UDim.new(0, 8)

local PB = Instance.new("TextButton")
PB.Size = UDim2.new(1, -40, 0, 30)
PB.Position = UDim2.new(0, 20, 0, 110)
PB.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
PB.BackgroundTransparency = 0.05
PB.TextColor3 = Color3.fromRGB(255, 255, 255)
PB.Text = "Freischalten"
PB.Font = Enum.Font.SourceSansBold
PB.TextSize = 14
PB.Parent = PF
Instance.new("UICorner", PB).CornerRadius = UDim.new(0, 8)

PB.MouseEnter:Connect(function() PB.BackgroundTransparency = 0 end)
PB.MouseLeave:Connect(function() PB.BackgroundTransparency = 0.05 end)

-- Discord Info
local DiscFrame = Instance.new("Frame")
DiscFrame.Size = UDim2.new(1, -40, 0, 24)
DiscFrame.Position = UDim2.new(0, 20, 0, 148)
DiscFrame.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscFrame.BackgroundTransparency = 0.1
DiscFrame.Parent = PF
Instance.new("UICorner", DiscFrame).CornerRadius = UDim.new(0, 6)

local DiscLabel = Instance.new("TextLabel")
DiscLabel.Size = UDim2.new(0.7, 0, 1, 0)
DiscLabel.Position = UDim2.new(0, 8, 0, 0)
DiscLabel.BackgroundTransparency = 1
DiscLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscLabel.Text = "🔗 Get Password on Discord"
DiscLabel.Font = Enum.Font.SourceSans
DiscLabel.TextSize = 11
DiscLabel.TextXAlignment = Enum.TextXAlignment.Left
DiscLabel.Parent = DiscFrame

local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0.25, 0, 0, 18)
CopyBtn.Position = UDim2.new(0.72, 0, 0, 3)
CopyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.BackgroundTransparency = 0.2
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Text = "Copy"
CopyBtn.Font = Enum.Font.SourceSansBold
CopyBtn.TextSize = 10
CopyBtn.Parent = DiscFrame
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 4)

local CopiedLabel = Instance.new("TextLabel")
CopiedLabel.Size = UDim2.new(1, 0, 0, 16)
CopiedLabel.Position = UDim2.new(0, 0, 0, 180)
CopiedLabel.BackgroundTransparency = 1
CopiedLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
CopiedLabel.Text = ""
CopiedLabel.Font = Enum.Font.SourceSansBold
CopiedLabel.TextSize = 11
CopiedLabel.Parent = PF

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/duhxrB85tW")
    CopiedLabel.Text = "✅ Copied to clipboard!"
    task.wait(2)
    CopiedLabel.Text = ""
end)

local function TRY()
    if PI.Text == PASS then
        OK = true
        PG:Destroy()
        LOAD()
    else
        PI.Text = ""
        PI.PlaceholderText = "❌ Falsches Passwort!"
        PI.PlaceholderColor3 = Color3.fromRGB(255, 80, 80)
        task.wait(1)
        PI.PlaceholderText = "Passwort eingeben..."
        PI.PlaceholderColor3 = Color3.fromRGB(120, 100, 140)
    end
end
PB.MouseButton1Click:Connect(TRY)
PI.FocusLost:Connect(function(ep) if ep then TRY() end end)

function LOAD()
    local GUI = Instance.new("ScreenGui")
    GUI.Name = "PlaletteMvSDMain"
    GUI.ResetOnSpawn = false
    GUI.Parent = CoreGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 200, 0, 240)
    Main.Position = UDim2.new(0.01, 0, 0.1, 0)
    Main.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
    Main.BackgroundTransparency = 0.04
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Parent = GUI
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

    local Glow = Instance.new("Frame")
    Glow.Size = UDim2.new(1, 2, 1, 2)
    Glow.Position = UDim2.new(0, -1, 0, -1)
    Glow.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
    Glow.BackgroundTransparency = 0.5
    Glow.BorderSizePixel = 0
    Glow.Parent = Main
    Instance.new("UICorner", Glow).CornerRadius = UDim.new(0, 8)

    local Mini = Instance.new("Frame")
    Mini.Size = UDim2.new(0, 180, 0, 28)
    Mini.Position = UDim2.new(0.01, 0, 0.1, 0)
    Mini.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
    Mini.BackgroundTransparency = 0.04
    Mini.BorderSizePixel = 0
    Mini.Visible = false
    Mini.Active = true
    Mini.Draggable = true
    Mini.Parent = GUI
    Instance.new("UICorner", Mini).CornerRadius = UDim.new(0, 8)
    local MT = Instance.new("TextLabel")
    MT.Size = UDim2.new(1, 0, 1, 0)
    MT.BackgroundTransparency = 1
    MT.TextColor3 = Color3.fromRGB(180, 130, 255)
    MT.Text = "MvSD · Plalette Scripts · CTRL"
    MT.Font = Enum.Font.SourceSansBold
    MT.TextSize = 11
    MT.Parent = Mini
    UserInputService.InputBegan:Connect(function(i, p) if p then return end if i.KeyCode == Enum.KeyCode.LeftControl or i.KeyCode == Enum.KeyCode.RightControl then Main.Visible = not Main.Visible Mini.Visible = not Mini.Visible end end)

    local H = Instance.new("Frame")
    H.Size = UDim2.new(1, 0, 0, 28)
    H.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
    H.BorderSizePixel = 0
    H.Parent = Main
    Instance.new("UICorner", H).CornerRadius = UDim.new(0, 8)
    local HT = Instance.new("TextLabel")
    HT.Size = UDim2.new(0.6, 0, 1, 0)
    HT.Position = UDim2.new(0, 8, 0, 0)
    HT.BackgroundTransparency = 1
    HT.TextColor3 = Color3.fromRGB(255, 255, 255)
    HT.Text = "MvSD DUELS"
    HT.Font = Enum.Font.SourceSansBold
    HT.TextSize = 13
    HT.TextXAlignment = Enum.TextXAlignment.Left
    HT.Parent = H
    local CB = Instance.new("TextButton")
    CB.Size = UDim2.new(0, 20, 0, 18)
    CB.Position = UDim2.new(1, -24, 0, 5)
    CB.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
    CB.TextColor3 = Color3.fromRGB(255, 255, 255)
    CB.Text = "X"
    CB.Font = Enum.Font.SourceSansBold
    CB.TextSize = 11
    CB.Parent = H
    Instance.new("UICorner", CB).CornerRadius = UDim.new(0, 4)
    CB.MouseButton1Click:Connect(function() SA() GUI:Destroy() end)

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, -6, 1, -32)
    Scroll.Position = UDim2.new(0, 3, 0, 30)
    Scroll.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
    Scroll.BackgroundTransparency = 0.15
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 2
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(140, 80, 255)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 480)
    Scroll.Parent = Main
    local SL = Instance.new("UIListLayout")
    SL.Padding = UDim.new(0, 2)
    SL.FillDirection = Enum.FillDirection.Vertical
    SL.SortOrder = Enum.SortOrder.LayoutOrder
    SL.Parent = Scroll

    local function Div(t) local f = Instance.new("Frame") f.Size = UDim2.new(1,-2,0,16) f.BackgroundTransparency = 1 f.Parent = Scroll local l = Instance.new("TextLabel") l.Size = UDim2.new(1,0,1,0) l.BackgroundTransparency = 1 l.TextColor3 = Color3.fromRGB(180,130,255) l.Text = "▸ "..t l.Font = Enum.Font.SourceSansBold l.TextSize = 10 l.TextXAlignment = Enum.TextXAlignment.Left l.Parent = f end
    local function Tog(n,v) local f = Instance.new("Frame") f.Size = UDim2.new(1,-2,0,26) f.BackgroundColor3 = Color3.fromRGB(26,24,38) f.Parent = Scroll Instance.new("UICorner",f).CornerRadius = UDim.new(0,5) local l = Instance.new("TextLabel") l.Size = UDim2.new(0.55,0,1,0) l.Position = UDim2.new(0,8,0,0) l.BackgroundTransparency = 1 l.TextColor3 = Color3.fromRGB(230,220,240) l.Text = n..": OFF" l.Font = Enum.Font.SourceSans l.TextSize = 11 l.TextXAlignment = Enum.TextXAlignment.Left l.Parent = f local b = Instance.new("TextButton") b.Size = UDim2.new(0,28,0,16) b.Position = UDim2.new(1,-38,0,5) b.BackgroundColor3 = Color3.fromRGB(50,45,60) b.Text = "" b.Parent = f Instance.new("UICorner",b).CornerRadius = UDim.new(0,8) local on = false b.MouseButton1Click:Connect(function() on = not on if v=="Aimbot"then Aimbot=on elseif v=="Silent"then Silent=on elseif v=="Hitbox"then Hitbox=on elseif v=="Reload"then Reload=on elseif v=="ESP"then ESP=on elseif v=="Tracers"then Tracers=on elseif v=="Speed"then Speed=on elseif v=="Fly"then Fly=on elseif v=="Jump"then Jump=on end l.Text = n..": "..(on and"ON"or"OFF") b.BackgroundColor3 = on and Color3.fromRGB(140,80,255)or Color3.fromRGB(50,45,60) end) end
    local function Sli(n,v,min,max,def) local f = Instance.new("Frame") f.Size = UDim2.new(1,-2,0,38) f.BackgroundColor3 = Color3.fromRGB(26,24,38) f.Parent = Scroll Instance.new("UICorner",f).CornerRadius = UDim.new(0,5) local l = Instance.new("TextLabel") l.Size = UDim2.new(0.4,0,0,16) l.Position = UDim2.new(0,8,0,2) l.BackgroundTransparency = 1 l.TextColor3 = Color3.fromRGB(230,220,240) l.Text = n l.Font = Enum.Font.SourceSans l.TextSize = 11 l.TextXAlignment = Enum.TextXAlignment.Left l.Parent = f local vl = Instance.new("TextLabel") vl.Size = UDim2.new(0,35,0,16) vl.Position = UDim2.new(1,-45,0,2) vl.BackgroundTransparency = 1 vl.TextColor3 = Color3.fromRGB(180,140,255) vl.Text = tostring(def) vl.Font = Enum.Font.SourceSansBold vl.TextSize = 11 vl.TextXAlignment = Enum.TextXAlignment.Right vl.Parent = f local inp = Instance.new("TextBox") inp.Size = UDim2.new(0.3,0,0,18) inp.Position = UDim2.new(0.35,0,0,20) inp.BackgroundColor3 = Color3.fromRGB(40,36,50) inp.TextColor3 = Color3.fromRGB(255,255,255) inp.Text = tostring(def) inp.Font = Enum.Font.SourceSans inp.TextSize = 10 inp.Parent = f Instance.new("UICorner",inp).CornerRadius = UDim.new(0,4) inp.FocusLost:Connect(function() local val = tonumber(inp.Text) if val and val>=min and val<=max then if v=="FOV"then FOV=val elseif v=="HitboxS"then HitboxS=val elseif v=="SpeedV"then SpeedV=val elseif v=="FlyV"then FlyV=val elseif v=="JumpV"then JumpV=val end vl.Text = tostring(val) else inp.Text = vl.Text end end) end

    Div("Aimbot") Tog("FOV Aimbot","Aimbot") Sli("FOV Size","FOV",30,300,120) Tog("Silent Aim","Silent")
    Div("Weapon") Tog("Hitbox Expander","Hitbox") Sli("Hitbox Size","HitboxS",1,8,3) Tog("Instant Reload","Reload")
    Div("ESP") Tog("Player ESP","ESP") Tog("Tracers","Tracers")
    Div("Movement") Tog("Speed Hack","Speed") Sli("Walk Speed","SpeedV",16,60,32) Tog("Fly (G-Key)","Fly") Sli("Fly Speed","FlyV",10,80,30) Tog("Infinite Jump","Jump") Sli("Jump Power","JumpV",50,200,60)

    local Foot = Instance.new("TextLabel") Foot.Size = UDim2.new(1,-2,0,20) Foot.BackgroundColor3 = Color3.fromRGB(26,24,38) Foot.Parent = Scroll Instance.new("UICorner",Foot).CornerRadius = UDim.new(0,5) local FT = Instance.new("TextLabel") FT.Size = UDim2.new(1,-8,1,0) FT.Position = UDim2.new(0,4,0,0) FT.BackgroundTransparency = 1 FT.TextColor3 = Color3.fromRGB(160,140,180) FT.Text = "Plalette Scripts · discord.gg/duhxrB85tW" FT.Font = Enum.Font.SourceSans FT.TextSize = 8 FT.Parent = Foot

    -- FOV CIRCLE
    task.spawn(function() while task.wait(0.03) do if Aimbot then if not FCI then FCI = Drawing.new("Circle") end FCI.Visible = true FCI.Radius = FOV FCI.Thickness = 1.5 FCI.Color = Color3.fromRGB(140,80,255) FCI.Filled = false FCI.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2) else if FCI then FCI.Visible = false end end end end)

    -- SILENT AIM
    local oldNC = hookmetamethod(game,"__namecall",function(s,...) local m = getnamecallmethod() local a = {...} if m == "FireServer" and Aimbot and Silent then local t = GT() if t and t.Character then local h = t.Character:FindFirstChild("Head") if h and a[1] then a[1] = h.Position end end end return oldNC(s,unpack(a)) end)

    -- HITBOX
    task.spawn(function() while task.wait(0.3) do if Hitbox then for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character then local r = p.Character:FindFirstChild("HumanoidRootPart") if r then r.Size = Vector3.new(HitboxS,HitboxS,HitboxS) r.Transparency = 0.4 end end end end end end)

    -- RELOAD
    task.spawn(function() while task.wait(0.15) do if Reload then pcall(function() for _,t in ipairs(LocalPlayer.Backpack:GetChildren()) do if t:IsA("Tool") and t:FindFirstChild("Ammo") then t.Ammo.Value = 99 end end local ct = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool") if ct and ct:FindFirstChild("Ammo") then ct.Ammo.Value = 99 end end) end end end)

    -- ESP + TRACERS
    task.spawn(function() while task.wait(0.08) do CE() if ESP then for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character then local h = p.Character:FindFirstChild("Head") local r = p.Character:FindFirstChild("HumanoidRootPart") if h and r then local hp,on = Camera:WorldToViewportPoint(h.Position+Vector3.new(0,0.5,0)) if on then local fp = Camera:WorldToViewportPoint(r.Position-Vector3.new(0,3,0)) local bh = math.abs(hp.Y-fp.Y) local bw = bh/2 local bx = Drawing.new("Square") bx.Color = Color3.fromRGB(140,80,255) bx.Thickness = 1 bx.Size = Vector2.new(bw,bh) bx.Position = Vector2.new(hp.X-bw/2,hp.Y) bx.Filled = false bx.Visible = true table.insert(ESPD,bx) local nm = Drawing.new("Text") nm.Text = p.Name nm.Color = Color3.fromRGB(255,255,255) nm.Size = 12 nm.Position = Vector2.new(hp.X,hp.Y-16) nm.Center = true nm.Visible = true table.insert(ESPD,nm) end end end end end if Tracers then for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character then local r = p.Character:FindFirstChild("HumanoidRootPart") if r then local pos,on = Camera:WorldToViewportPoint(r.Position) if on then local ln = Drawing.new("Line") ln.Color = Color3.fromRGB(180,130,255) ln.Thickness = 0.5 ln.From = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y) ln.To = Vector2.new(pos.X,pos.Y) ln.Visible = true table.insert(ESPD,ln) end end end end end end end)

    -- SPEED + JUMP
    task.spawn(function() while task.wait(0.5) do if LocalPlayer.Character then local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if h then if Speed then h.WalkSpeed = SpeedV end if Jump then h.JumpPower = JumpV end end end end end)

    UserInputService.JumpRequest:Connect(function() if Jump and LocalPlayer.Character then local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end)

    -- FLY (G-Key)
    UserInputService.InputBegan:Connect(function(i,p) if p then return end if i.KeyCode == Enum.KeyCode.G then Fly = not Fly if not Fly and LocalPlayer.Character then local r = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if r then for _,c in ipairs(r:GetChildren()) do if c:IsA("BodyGyro")or c:IsA("BodyVelocity")then c:Destroy() end end end end end end)
    task.spawn(function() while task.wait() do if Fly and LocalPlayer.Character then local r = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if r then local g = r:FindFirstChild("FlyG")or Instance.new("BodyGyro",r) g.Name = "FlyG" g.MaxTorque = Vector3.new(9e9,9e9,9e9) g.CFrame = Camera.CFrame g.Parent = r local v = r:FindFirstChild("FlyV")or Instance.new("BodyVelocity",r) v.Name = "FlyV" v.MaxForce = Vector3.new(400000,400000,400000) v.Parent = r local m = Vector3.zero if UserInputService:IsKeyDown(Enum.KeyCode.W)then m=m+Camera.CFrame.LookVector end if UserInputService:IsKeyDown(Enum.KeyCode.S)then m=m-Camera.CFrame.LookVector end if UserInputService:IsKeyDown(Enum.KeyCode.A)then m=m-Camera.CFrame.RightVector end if UserInputService:IsKeyDown(Enum.KeyCode.D)then m=m+Camera.CFrame.RightVector end if UserInputService:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)then m=m-Vector3.new(0,1,0)end v.Velocity = m*FlyV end end end end)

    -- ANTI-AFK
    task.spawn(function() while task.wait(60) do pcall(function() local VIM = game:GetService("VirtualInputManager") VIM:SendKeyEvent(true,Enum.KeyCode.Space,false,nil) task.wait(0.1) VIM:SendKeyEvent(false,Enum.KeyCode.Space,false,nil) end) end end)

    print("Plalette Scripts · MvSD v2.1 · discord.gg/duhxrB85tW")
end
