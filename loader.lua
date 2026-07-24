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
            local h = p.Character:FindFirstChild-- Plalette Scripts · MvSD DUELS · v3.0 FINAL
local P=game:GetService("Players")
local R=game:GetService("RunService")
local U=game:GetService("UserInputService")
local W=game:GetService("Workspace")
local C=game:GetService("CoreGui")
local LIGHT=game:GetService("Lighting")
local L=P.LocalPlayer
local Cam=W.CurrentCamera
local M=L:GetMouse()
local PASS="plalettescripts3754356"
local OK=false

local A=false
local S=false
local H=false
local T=false
local Fly=false
local AC=nil
local FOV=120
local FC=nil
local HitSize=3
local SpeedVal=32
local FlyVal=30

local function GT()
local b=99999
local t=nil
local cx=Cam.ViewportSize.X/2
local cy=Cam.ViewportSize.Y/2
for _,p in ipairs(P:GetPlayers())do if p~=L and p.Character then local h=p.Character:FindFirstChild("Head")if h then local pos,on=Cam:WorldToViewportPoint(h.Position)if on then local dx=pos.X-cx local dy=pos.Y-cy local d=math.sqrt(dx*dx+dy*dy)if d<FOV and d<b then b=d t=p end end end end end return t end

local function StopFly()
Fly=false
if L.Character then
local r=L.Character:FindFirstChild("HumanoidRootPart")
if r then
for _,c in ipairs(r:GetChildren())do
if c:IsA("BodyGyro")or c:IsA("BodyVelocity")then c:Destroy()end
end
end
end
end

local function NOTAUS()
A=false S=false H=false T=false StopFly()
if FC then FC:Remove()FC=nil end
if AC then AC:Disconnect()end
if L.Character then
local h=L.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=16 end
local r=L.Character:FindFirstChild("HumanoidRootPart")
if r then for _,c in ipairs(r:GetChildren())do if c:IsA("BodyGyro")or c:IsA("BodyVelocity")then c:Destroy()end end end
end
LIGHT.Brightness=1
end

-- PASSWORD SCREEN
local PG=Instance.new("ScreenGui")PG.Name="PlaletteMvSD"PG.ResetOnSpawn=false PG.Parent=C
local PF=Instance.new("Frame")PF.Size=UDim2.new(0,280,0,200)PF.Position=UDim2.new(0.5,-140,0.5,-100)PF.BackgroundColor3=Color3.fromRGB(14,12,24)PF.BackgroundTransparency=0.03 PF.BorderSizePixel=0 PF.Active=true PF.Draggable=true PF.Parent=PG
Instance.new("UICorner",PF).CornerRadius=UDim.new(0,10)
local PGL=Instance.new("Frame")PGL.Size=UDim2.new(1,2,1,2)PGL.Position=UDim2.new(0,-1,0,-1)PGL.BackgroundColor3=Color3.fromRGB(140,80,255)PGL.BackgroundTransparency=0.5 PGL.BorderSizePixel=0 PGL.Parent=PF
Instance.new("UICorner",PGL).CornerRadius=UDim.new(0,10)
local PT=Instance.new("TextLabel")PT.Size=UDim2.new(1,0,0,26)PT.Position=UDim2.new(0,0,0,18)PT.BackgroundTransparency=1 PT.TextColor3=Color3.fromRGB(255,255,255)PT.Text="MvSD DUELS"PT.Font=Enum.Font.SourceSansBold PT.TextSize=20 PT.Parent=PF
local PS=Instance.new("TextLabel")PS.Size=UDim2.new(1,0,0,16)PS.Position=UDim2.new(0,0,0,46)PS.BackgroundTransparency=1 PS.TextColor3=Color3.fromRGB(180,140,200)PS.Text="Plalette Scripts"PS.Font=Enum.Font.SourceSans PS.TextSize=13 PS.Parent=PF
local PI=Instance.new("TextBox")PI.Size=UDim2.new(1,-40,0,30)PI.Position=UDim2.new(0,20,0,72)PI.BackgroundColor3=Color3.fromRGB(28,28,38)PI.BackgroundTransparency=0.1 PI.TextColor3=Color3.fromRGB(255,255,255)PI.PlaceholderText="Passwort eingeben..."PI.PlaceholderColor3=Color3.fromRGB(120,100,140)PI.Text=""PI.Font=Enum.Font.SourceSans PI.TextSize=14 PI.Parent=PF
Instance.new("UICorner",PI).CornerRadius=UDim.new(0,8)
local PB=Instance.new("TextButton")PB.Size=UDim2.new(1,-40,0,30)PB.Position=UDim2.new(0,20,0,110)PB.BackgroundColor3=Color3.fromRGB(140,80,255)PB.BackgroundTransparency=0.05 PB.TextColor3=Color3.fromRGB(255,255,255)PB.Text="Freischalten"PB.Font=Enum.Font.SourceSansBold PB.TextSize=14 PB.Parent=PF
Instance.new("UICorner",PB).CornerRadius=UDim.new(0,8)

local DiscFrame=Instance.new("Frame")DiscFrame.Size=UDim2.new(1,-40,0,24)DiscFrame.Position=UDim2.new(0,20,0,148)DiscFrame.BackgroundColor3=Color3.fromRGB(88,101,242)DiscFrame.BackgroundTransparency=0.1 DiscFrame.Parent=PF
Instance.new("UICorner",DiscFrame).CornerRadius=UDim.new(0,6)
local DiscLabel=Instance.new("TextLabel")DiscLabel.Size=UDim2.new(0.7,0,1,0)DiscLabel.Position=UDim2.new(0,8,0,0)DiscLabel.BackgroundTransparency=1 DiscLabel.TextColor3=Color3.fromRGB(255,255,255)DiscLabel.Text="Get Password on Discord"DiscLabel.Font=Enum.Font.SourceSans DiscLabel.TextSize=11 DiscLabel.TextXAlignment=Enum.TextXAlignment.Left DiscLabel.Parent=DiscFrame
local CopyBtn=Instance.new("TextButton")CopyBtn.Size=UDim2.new(0.25,0,0,18)CopyBtn.Position=UDim2.new(0.72,0,0,3)CopyBtn.BackgroundColor3=Color3.fromRGB(255,255,255)CopyBtn.BackgroundTransparency=0.2 CopyBtn.TextColor3=Color3.fromRGB(255,255,255)CopyBtn.Text="Copy"CopyBtn.Font=Enum.Font.SourceSansBold CopyBtn.TextSize=10 CopyBtn.Parent=DiscFrame
Instance.new("UICorner",CopyBtn).CornerRadius=UDim.new(0,4)
local CopiedLabel=Instance.new("TextLabel")CopiedLabel.Size=UDim2.new(1,0,0,16)CopiedLabel.Position=UDim2.new(0,0,0,180)CopiedLabel.BackgroundTransparency=1 CopiedLabel.TextColor3=Color3.fromRGB(100,255,100)CopiedLabel.Text=""CopiedLabel.Font=Enum.Font.SourceSansBold CopiedLabel.TextSize=11 CopiedLabel.Parent=PF
CopyBtn.MouseButton1Click:Connect(function()setclipboard("https://discord.gg/duhxrB85tW")CopiedLabel.Text="Copied to clipboard!"task.wait(2)CopiedLabel.Text=""end)

local function TRY()
if PI.Text==PASS then OK=true PG:Destroy()LOAD()else PI.Text=""PI.PlaceholderText="Falsches Passwort!"PI.PlaceholderColor3=Color3.fromRGB(255,80,80)task.wait(1)PI.PlaceholderText="Passwort eingeben..."PI.PlaceholderColor3=Color3.fromRGB(120,100,140)end end
PB.MouseButton1Click:Connect(TRY)
PI.FocusLost:Connect(function(ep)if ep then TRY()end end)

function LOAD()
local GUI=Instance.new("ScreenGui")GUI.Name="PlaletteMvSDMain"GUI.ResetOnSpawn=false GUI.Parent=C
local Main=Instance.new("Frame")Main.Size=UDim2.new(0,220,0,280)Main.Position=UDim2.new(0.01,0,0.08,0)Main.BackgroundColor3=Color3.fromRGB(14,12,24)Main.BackgroundTransparency=0.04 Main.BorderSizePixel=0 Main.Active=true Main.Draggable=true Main.Parent=GUI
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,8)
local Glow=Instance.new("Frame")Glow.Size=UDim2.new(1,2,1,2)Glow.Position=UDim2.new(0,-1,0,-1)Glow.BackgroundColor3=Color3.fromRGB(140,80,255)Glow.BackgroundTransparency=0.5 Glow.BorderSizePixel=0 Glow.Parent=Main
Instance.new("UICorner",Glow).CornerRadius=UDim.new(0,8)
local Title=Instance.new("TextLabel")Title.Size=UDim2.new(1,0,0,26)Title.BackgroundColor3=Color3.fromRGB(18,15,28)Title.TextColor3=Color3.fromRGB(255,255,255)Title.Text="MvSD - Plalette"Title.Font=Enum.Font.SourceSansBold Title.TextSize=13 Title.Parent=Main
local Close=Instance.new("TextButton")Close.Size=UDim2.new(0,22,0,20)Close.Position=UDim2.new(1,-26,0,3)Close.BackgroundColor3=Color3.fromRGB(220,50,70)Close.TextColor3=Color3.fromRGB(255,255,255)Close.Text="X"Close.Font=Enum.Font.SourceSansBold Close.TextSize=12 Close.Parent=Main
Instance.new("UICorner",Close).CornerRadius=UDim.new(0,4)
Close.MouseButton1Click:Connect(function()NOTAUS()GUI:Destroy()end)

local flyLabel=nil
local flyBtn=nil

local function Tog(y,txt,var)
local f=Instance.new("Frame")f.Size=UDim2.new(1,-14,0,32)f.Position=UDim2.new(0,7,0,y)f.BackgroundColor3=Color3.fromRGB(26,24,38)f.Parent=Main
Instance.new("UICorner",f).CornerRadius=UDim.new(0,5)
local l=Instance.new("TextLabel")l.Size=UDim2.new(0.5,0,1,0)l.Position=UDim2.new(0,8,0,0)l.BackgroundTransparency=1 l.TextColor3=Color3.fromRGB(230,220,240)l.Text=txt..": OFF"l.Font=Enum.Font.SourceSans l.TextSize=11 l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f
local b=Instance.new("TextButton")b.Size=UDim2.new(0,32,0,18)b.Position=UDim2.new(1,-40,0,7)b.BackgroundColor3=Color3.fromRGB(50,45,60)b.Text=""b.Parent=f
Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
b.MouseButton1Click:Connect(function()
if var=="A"then A=not A l.Text=txt..": "..(A and"ON"or"OFF")b.BackgroundColor3=A and Color3.fromRGB(140,80,255)or Color3.fromRGB(50,45,60)
elseif var=="S"then S=not S l.Text=txt..": "..(S and"ON"or"OFF")b.BackgroundColor3=S and Color3.fromRGB(140,80,255)or Color3.fromRGB(50,45,60)
elseif var=="H"then H=not H l.Text=txt..": "..(H and"ON"or"OFF")b.BackgroundColor3=H and Color3.fromRGB(140,80,255)or Color3.fromRGB(50,45,60)
elseif var=="T"then T=not T l.Text=txt..": "..(T and"ON"or"OFF")b.BackgroundColor3=T and Color3.fromRGB(140,80,255)or Color3.fromRGB(50,45,60)
elseif var=="F"then
Fly=not Fly
l.Text=txt..": "..(Fly and"ON"or"OFF")
b.BackgroundColor3=Fly and Color3.fromRGB(140,80,255)or Color3.fromRGB(50,45,60)
if not Fly then StopFly()end
end end)
if var=="F"then flyLabel=l flyBtn=b end
end

Tog(30,"FOV+RC Aimbot","A")
Tog(66,"Triggerbot","T")
Tog(102,"Hitbox Exp.","H")
Tog(138,"Speed","S")
Tog(174,"Fly (G=An/Aus, CTRL=Runter)","F")

local sf=Instance.new("Frame")sf.Size=UDim2.new(1,-14,0,30)sf.Position=UDim2.new(0,7,0,210)sf.BackgroundColor3=Color3.fromRGB(26,24,38)sf.Parent=Main
Instance.new("UICorner",sf).CornerRadius=UDim.new(0,5)
local sl=Instance.new("TextLabel")sl.Size=UDim2.new(0.4,0,1,0)sl.Position=UDim2.new(0,6,0,0)sl.BackgroundTransparency=1 sl.TextColor3=Color3.fromRGB(200,190,220)sl.Text="Speed: "..SpeedVal sl.Font=Enum.Font.SourceSans sl.TextSize=10 sl.TextXAlignment=Enum.TextXAlignment.Left sl.Parent=sf
local sin=Instance.new("TextBox")sin.Size=UDim2.new(0.3,0,0,18)sin.Position=UDim2.new(0.55,0,0,6)sin.BackgroundColor3=Color3.fromRGB(40,36,50)sin.TextColor3=Color3.fromRGB(255,255,255)sin.Text=tostring(SpeedVal)sin.Font=Enum.Font.SourceSans sin.TextSize=10 sin.Parent=sf
Instance.new("UICorner",sin).CornerRadius=UDim.new(0,4)
sin.FocusLost:Connect(function()local v=tonumber(sin.Text)if v and v>=16 and v<=60 then SpeedVal=v sl.Text="Speed: "..v else sin.Text=tostring(SpeedVal)end end)

local ff=Instance.new("Frame")ff.Size=UDim2.new(1,-14,0,30)ff.Position=UDim2.new(0,7,0,244)ff.BackgroundColor3=Color3.fromRGB(26,24,38)ff.Parent=Main
Instance.new("UICorner",ff).CornerRadius=UDim.new(0,5)
local fl=Instance.new("TextLabel")fl.Size=UDim2.new(0.4,0,1,0)fl.Position=UDim2.new(0,6,0,0)fl.BackgroundTransparency=1 fl.TextColor3=Color3.fromRGB(200,190,220)fl.Text="Fly: "..FlyVal fl.Font=Enum.Font.SourceSans fl.TextSize=10 fl.TextXAlignment=Enum.TextXAlignment.Left fl.Parent=ff
local fin=Instance.new("TextBox")fin.Size=UDim2.new(0.3,0,0,18)fin.Position=UDim2.new(0.55,0,0,6)fin.BackgroundColor3=Color3.fromRGB(40,36,50)fin.TextColor3=Color3.fromRGB(255,255,255)fin.Text=tostring(FlyVal)fin.Font=Enum.Font.SourceSans fin.TextSize=10 fin.Parent=ff
Instance.new("UICorner",fin).CornerRadius=UDim.new(0,4)
fin.FocusLost:Connect(function()local v=tonumber(fin.Text)if v and v>=10 and v<=100 then FlyVal=v fl.Text="Fly: "..v else fin.Text=tostring(FlyVal)end end)

-- FOV CIRCLE
task.spawn(function()while task.wait(0.03)do if A then if not FC then FC=Drawing.new("Circle")end FC.Visible=true FC.Radius=FOV FC.Thickness=1.5 FC.Color=Color3.fromRGB(140,80,255)FC.Filled=false FC.Position=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)else if FC then FC.Visible=false end end end end)

-- RC AIMBOT
U.InputBegan:Connect(function(i,p)if p then return end if i.UserInputType==Enum.UserInputType.MouseButton2 and A then AC=R.RenderStepped:Connect(function()local t=GT()if t and t.Character and t.Character:FindFirstChild("Head")then Cam.CFrame=CFrame.new(Cam.CFrame.Position,t.Character.Head.Position)end end)end end)
U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton2 then if AC then AC:Disconnect()AC=nil end end end)

-- SPEED
R.Stepped:Connect(function()if S and L.Character then local h=L.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=SpeedVal end end end)

-- HITBOX
task.spawn(function()while task.wait(0.2)do if H then for _,p in ipairs(P:GetPlayers())do if p~=L and p.Character then local r=p.Character:FindFirstChild("HumanoidRootPart")if r then r.Size=Vector3.new(HitSize,HitSize,HitSize)r.Transparency=0.4 end end end end end end)

-- TRIGGERBOT
task.spawn(function()while task.wait(0.05)do if T and L.Character then pcall(function()local tool=L.Character:FindFirstChildOfClass("Tool")if tool then local t=GT()if t and t.Character then local h=t.Character:FindFirstChild("Head")if h then local shoot=tool:FindFirstChild("Shoot")if shoot then shoot:FireServer(h.Position)end end end end end)end end end)

-- FLY
U.InputBegan:Connect(function(i,p)if p then return end if i.KeyCode==Enum.KeyCode.G then Fly=not Fly if Fly then if flyLabel then flyLabel.Text="Fly (G=An/Aus, CTRL=Runter): ON"end if flyBtn then flyBtn.BackgroundColor3=Color3.fromRGB(140,80,255)end else StopFly()if flyLabel then flyLabel.Text="Fly (G=An/Aus, CTRL=Runter): OFF"end if flyBtn then flyBtn.BackgroundColor3=Color3.fromRGB(50,45,60)end end end end)

task.spawn(function()
while task.wait()do
if Fly and L.Character then
local r=L.Character:FindFirstChild("HumanoidRootPart")
if r then
local g=r:FindFirstChild("FlyG")if not g then g=Instance.new("BodyGyro",r)g.Name="FlyG"g.Parent=r end
g.MaxTorque=Vector3.new(9e9,9e9,9e9)g.CFrame=Cam.CFrame
local v=r:FindFirstChild("FlyV")if not v then v=Instance.new("BodyVelocity",r)v.Name="FlyV"v.Parent=r end
v.MaxForce=Vector3.new(9e9,9e9,9e9)
local m=Vector3.zero
if U:IsKeyDown(Enum.KeyCode.W)then m=m+Cam.CFrame.LookVector end
if U:IsKeyDown(Enum.KeyCode.S)then m=m-Cam.CFrame.LookVector end
if U:IsKeyDown(Enum.KeyCode.A)then m=m-Cam.CFrame.RightVector end
if U:IsKeyDown(Enum.KeyCode.D)then m=m+Cam.CFrame.RightVector end
if U:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end
if U:IsKeyDown(Enum.KeyCode.LeftControl)or U:IsKeyDown(Enum.KeyCode.RightControl)then m=m-Vector3.new(0,1,0)end
v.Velocity=m*FlyVal
end
else
if L.Character then
local r=L.Character:FindFirstChild("HumanoidRootPart")
if r then
local g=r:FindFirstChild("FlyG")if g then g:Destroy()end
local v=r:FindFirstChild("FlyV")if v then v:Destroy()end
end
end
end
end
end)

-- ANTI-AFK
task.spawn(function()while task.wait(60)do pcall(function()local VIM=game:GetService("VirtualInputManager")VIM:SendKeyEvent(true,Enum.KeyCode.Space,false,nil)task.wait(0.1)VIM:SendKeyEvent(false,Enum.KeyCode.Space,false,nil)end)end end)

print("Plalette Scripts · MvSD v3.0 · discord.gg/duhxrB85tW")
end
