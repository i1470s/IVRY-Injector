-- Original Gui by ApocStreamin
-- Edited by PurgePotato with Working Coin Tp Button
-- Cycles through all the coins by teleporting to each individual one.
 
-- Objects
 
local SurvivorBeta = Instance.new("ScreenGui")
local DRAGGABLE = Instance.new("TextButton")
local UI = Instance.new("Frame")
local Editor = Instance.new("TextLabel")
local Version = Instance.new("TextLabel")
local Tip = Instance.new("TextLabel")
local Title = Instance.new("TextLabel")
local Idols = Instance.new("TextButton")
local Advantages = Instance.new("TextButton")
local Coins = Instance.new("TextButton")
local Teleport = Instance.new("TextButton")
local TextBox = Instance.new("TextBox")
 
-- Properties
 
SurvivorBeta.Name = "Survivor (Beta)"
SurvivorBeta.Parent = game.CoreGui
 
DRAGGABLE.Name = "DRAGGABLE"
DRAGGABLE.Parent = SurvivorBeta
DRAGGABLE.BackgroundColor3 = Color3.new(1, 1, 1)
DRAGGABLE.BackgroundTransparency = 1
DRAGGABLE.BorderSizePixel = 0
DRAGGABLE.Draggable = true
DRAGGABLE.Position = UDim2.new(0.5, -250, 0.5, -200)
DRAGGABLE.Size = UDim2.new(0, 500, 0, 400)
DRAGGABLE.Font = Enum.Font.SourceSans
DRAGGABLE.FontSize = Enum.FontSize.Size14
DRAGGABLE.Text = ""
DRAGGABLE.TextSize = 14
 
UI.Name = "UI"
UI.Parent = DRAGGABLE
UI.BackgroundColor3 = Color3.new(0,100,255)
UI.BackgroundTransparency = 0.5
UI.BorderColor3 = Color3.new(0,0,255)
UI.BorderSizePixel = 5
UI.Position = UDim2.new(0.5, -200, 0.5, -150)
UI.Size = UDim2.new(0, 400, 0, 300)
 
Editor.Name = "Editor"
Editor.Parent = UI
Editor.BackgroundColor3 = Color3.new(1, 1, 255)
Editor.BackgroundTransparency = 1
Editor.Position = UDim2.new(0, 280, 0, 250)
Editor.Size = UDim2.new(0, 50, 0, 50)
Editor.Font = Enum.Font.Code
Editor.FontSize = Enum.FontSize.Size14
Editor.Text = "Edited by PurgePotato"
Editor.TextColor3 = Color3.new(0,0,0)
Editor.TextSize = 14
 
Version.Name = "Version"
Version.Parent = UI
Version.BackgroundColor3 = Color3.new(1, 1, 255)
Version.BackgroundTransparency = 1
Version.Position = UDim2.new(0, 275, 0, 265)
Version.Size = UDim2.new(0, 50, 0, 50)
Version.Font = Enum.Font.Code
Version.FontSize = Enum.FontSize.Size14
Version.Text = "Version 1.0.1"
Version.TextColor3 = Color3.new(0,0,0)
Version.TextSize = 14
 
Tip.Name = "Tip"
Tip.Parent = UI
Tip.BackgroundColor3 = Color3.new(1, 1, 255)
Tip.BackgroundTransparency = 1
Tip.Position = UDim2.new(0, 190, 0, 180)
Tip.Size = UDim2.new(0, 200, 0, 80)
Tip.Font = Enum.Font.SourceSansBold
Tip.FontSize = Enum.FontSize.Size14
Tip.Text = "Tip: Must be in-game to collect to Idols/ Advantages!"
Tip.TextColor3 = Color3.new(0,0,0)
Tip.TextSize = 13
Tip.TextScaled = true
 
Title.Name = "Title"
Title.Parent = UI
Title.BackgroundColor3 = Color3.new(1, 1, 255)
Title.BackgroundTransparency = 0.5
Title.BorderColor3 = Color3.new(0, 0, 255)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(0, 400, 0, 50)
Title.Font = Enum.Font.SourceSansBold
Title.FontSize = Enum.FontSize.Size48
Title.Text = "Survivor (Beta) Exploit"
Title.TextColor3 = Color3.new(0,0,0)
Title.TextSize = 45
 
Idols.Name = "Idols"
Idols.Parent = UI
Idols.BackgroundColor3 = Color3.new(1, 1, 255)
Idols.BackgroundTransparency = 0.5
Idols.BorderSizePixel = 0
Idols.Position = UDim2.new(0, 25, 0, 75)
Idols.Size = UDim2.new(0, 150, 0, 50)
Idols.Font = Enum.Font.SourceSansBold
Idols.FontSize = Enum.FontSize.Size28
Idols.Text = "Idols"
Idols.TextColor3 = Color3.new(0,0,0)
Idols.TextSize = 25
 
Advantages.Name = "Advantages"
Advantages.Parent = UI
Advantages.BackgroundColor3 = Color3.new(1, 1, 255)
Advantages.BackgroundTransparency = 0.5
Advantages.BorderSizePixel = 0
Advantages.Position = UDim2.new(0, 25, 0, 150)
Advantages.Size = UDim2.new(0, 150, 0, 50)
Advantages.Font = Enum.Font.SourceSansBold
Advantages.FontSize = Enum.FontSize.Size28
Advantages.Text = "Advantages"
Advantages.TextColor3 = Color3.new(0,0,0)
Advantages.TextSize = 25
 
Coins.Name = "Coins"
Coins.Parent = UI
Coins.BackgroundColor3 = Color3.new(1, 1, 255)
Coins.BackgroundTransparency = 0.5
Coins.BorderSizePixel = 0
Coins.Position = UDim2.new(0, 25, 0, 225)
Coins.Size = UDim2.new(0, 150, 0, 50)
Coins.Font = Enum.Font.SourceSansBold
Coins.FontSize = Enum.FontSize.Size28
Coins.Text = "Coins"
Coins.TextColor3 = Color3.new(0,0,0)
Coins.TextSize = 25
 
Teleport.Name = "Teleport"
Teleport.Parent = UI
Teleport.BackgroundColor3 = Color3.new(1, 1, 255)
Teleport.BackgroundTransparency = 0.5
Teleport.BorderSizePixel = 0
Teleport.Position = UDim2.new(0, 225, 0, 75)
Teleport.Size = UDim2.new(0, 150, 0, 50)
Teleport.Font = Enum.Font.SourceSansBold
Teleport.FontSize = Enum.FontSize.Size28
Teleport.Text = "Teleport"
Teleport.TextColor3 = Color3.new(0,0,0)
Teleport.TextSize = 25
 
TextBox.Parent = UI
TextBox.BackgroundColor3 = Color3.new(1, 1, 255)
TextBox.BackgroundTransparency = 0.20000000298023
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0, 225, 0, 135)
TextBox.Size = UDim2.new(0, 150, 0, 30)
TextBox.Font = Enum.Font.SourceSansBold
TextBox.FontSize = Enum.FontSize.Size24
TextBox.Text = "Enter Playername"
TextBox.TextColor3 = Color3.new(0,0,0)
TextBox.TextSize = 20
 
-- Script 
 
warn('--// V3RMILLION @Rowenator. //--')
warn('Idea Inspired by: V3RMILLION @TOHAK')
 
--// Anti-Exploit //--
 
for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
if v:IsA('LocalScript') then
v:Destroy()
end
end
 
for _,v in pairs(game.StarterGui:GetChildren()) do
if v:IsA('LocalScript') then
v:Destroy()
end
end
 
--// Variables //--
 
survivorgui = game.CoreGui['Survivor (Beta)']
UI = survivorgui.DRAGGABLE.UI
 
--// Idols //--
 
UI.Idols.MouseButton1Down:connect(function()
local idols = game.Workspace.Misc.Idols:GetChildren()
local lp = game.Players.LocalPlayer.Character
local posbrick = Instance.new("Part")
posbrick.CanCollide = false
posbrick.Transparency = 1
posbrick.Position = lp.Torso.Position
 
for i = 1,#idols do
if #idols>0 then
UI.Idols.Text = "Searching for Idols..."
lp:MoveTo(idols[i].Position)
wait(2)
end
end
UI.Idols.Text = "Collected all Idols!"
lp:MoveTo(posbrick.Position)
wait(1)
UI.Idols.Text = "Idols"
 
if #idols == 0 then
UI.Idols.Text = "No Idols"
wait(1)
UI.Idols.Text = "Idols"
end
end)
 
--// Advantages //--
 
UI.Advantages.MouseButton1Down:connect(function()
local advantages = game.Workspace.Misc.Advantages:GetChildren()
local lp = game.Players.LocalPlayer.Character
local posbrick = Instance.new("Part")
posbrick.CanCollide = false
posbrick.Transparency = 1
posbrick.Position = lp.Torso.Position
 
for i = 1,#advantages do
if #advantages>0 then
UI.Advantages.Text = "Searching for Adv's..."
lp:MoveTo(advantages[i].Position)
wait(2)
end
UI.Advantages.Text = "Collected all Adv's!"
end
 
 
lp:MoveTo(posbrick.Position)
wait(1)
UI.Advantages.Text = "Advantages"
 
if #advantages == 0 then
UI.Advantages.Text = "No Advantages"
wait(1)
UI.Advantages.Text = "Advantages"
end
end)
 
--// Coins //--
 
UI.Coins.MouseButton1Down:connect(function()
local coins1 = game.Workspace.Misc.Coins.Island1:GetChildren()
local coins2 = game.Workspace.Misc.Coins.Island2:GetChildren()
local coins4 = game.Workspace.Misc.Coins.Lobby:GetChildren()
local lp = game.Players.LocalPlayer.Character
local posbrick = Instance.new("Part")
posbrick.CanCollide = false
posbrick.Transparency = 1
posbrick.Position = lp.Torso.Position
 
wait(0.001)
for i = 1, #coins1 do
if #coins1>0 then
UI.Coins.Text = "Collecting Coins..."
lp:MoveTo(coins1[i].Position)
wait(0.35)
end
end
 
for i = 1, #coins2 do
if #coins2>0 then
lp:MoveTo(coins2[i].Position)
wait(0.35)
end
end
 
for i = 1, #coins4 do
if #coins4>0 then
lp:MoveTo(coins4[i].Position)
wait(0.35)
end
UI.Coins.Text = "All Coins Collected!"
end
 
lp:MoveTo(posbrick.Position)
wait(1)
UI.Coins.Text = "Coins"
 
if #totalcoins == 0 then
UI.Coins.Text = "No Coins"
wait(1)
UI.Coins.Text = "Coins"
end
 
end)
 
--// Teleport //--
 
UI.Teleport.MouseButton1Down:connect(function()
game.Players.LocalPlayer.Character:MoveTo(game.Players[UI.TextBox.Text].Character.Torso.Position)
end)