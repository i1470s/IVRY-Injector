local SharkBiteV2 = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local WelcomeTxt = Instance.new("TextLabel")
local creds = Instance.new("TextLabel")
local DestroyIslandBarriers = Instance.new("TextButton")
local Island = Instance.new("TextButton")
local SpawnBarrier = Instance.new("TextButton")
local SharkHome = Instance.new("TextButton")
local tpOnTopOfMap = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local tpInsideShark = Instance.new("TextButton")
local Water = Instance.new("TextButton")
local NoNeedToEdit = Instance.new("TextLabel")
local TextLabel = Instance.new("TextLabel")
local outSideOfMap = Instance.new("TextButton")
local Spawn = Instance.new("TextButton")
local tpToSpawn = Instance.new("TextButton")
local Open = Instance.new("TextButton")
 
-- Properties
 
SharkBiteV2.Name = "SharkBite V-2"
SharkBiteV2.Parent = game.CoreGui
 
Main.Name = "Main"
Main.Parent = SharkBiteV2
Main.Active = true
Main.BackgroundColor3 = Color3.new(0.345098, 0.545098, 0.686275)
Main.BorderColor3 = Color3.new(0.258824, 0.403922, 0.509804)
Main.BorderSizePixel = 20
Main.Draggable = true
Main.Position = UDim2.new(0, 157, 0, 54)
Main.Selectable = true
Main.Size = UDim2.new(0, 591, 0, 426)
Main.Visible = false
 
WelcomeTxt.Name = "WelcomeTxt"
WelcomeTxt.Parent = Main
WelcomeTxt.BackgroundColor3 = Color3.new(0.258824, 0.403922, 0.509804)
WelcomeTxt.BorderColor3 = Color3.new(0.258824, 0.403922, 0.509804)
WelcomeTxt.Position = UDim2.new(0, 0, 0, -18)
WelcomeTxt.Size = UDim2.new(0, 591, 0, 79)
WelcomeTxt.Font = Enum.Font.SourceSans
WelcomeTxt.FontSize = Enum.FontSize.Size14
WelcomeTxt.Text = "Welcome, to reBite V-2"
WelcomeTxt.TextColor3 = Color3.new(0.113725, 0.501961, 0.866667)
WelcomeTxt.TextScaled = true
WelcomeTxt.TextSize = 14
WelcomeTxt.TextStrokeColor3 = Color3.new(0.101961, 0.443137, 0.764706)
WelcomeTxt.TextStrokeTransparency = 0.30000001192093
WelcomeTxt.TextWrapped = true
 
creds.Name = "creds"
creds.Parent = Main
creds.BackgroundColor3 = Color3.new(0.258824, 0.403922, 0.509804)
creds.BorderColor3 = Color3.new(0.258824, 0.403922, 0.509804)
creds.Position = UDim2.new(0, 0, 0, 376)
creds.Size = UDim2.new(0, 591, 0, 50)
creds.Font = Enum.Font.ArialBold
creds.FontSize = Enum.FontSize.Size14
creds.Text = "Made by: zerotrool#0705 |||| Tp inside shark made by: PumpkinLovesYou     On v3rm "
creds.TextColor3 = Color3.new(1, 1, 1)
creds.TextSize = 14
creds.TextStrokeColor3 = Color3.new(0.345098, 0.345098, 0.345098)
creds.TextStrokeTransparency = 0
 
DestroyIslandBarriers.Name = "DestroyIslandBarriers"
DestroyIslandBarriers.Parent = Main
DestroyIslandBarriers.BackgroundColor3 = Color3.new(1, 1, 1)
DestroyIslandBarriers.Position = UDim2.new(0, 375, 0, 298)
DestroyIslandBarriers.Size = UDim2.new(0, 200, 0, 69)
DestroyIslandBarriers.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
DestroyIslandBarriers.Font = Enum.Font.SourceSans
DestroyIslandBarriers.FontSize = Enum.FontSize.Size14
DestroyIslandBarriers.Text = "Destroy all island barriers (Note while making the script: I cant seem to find the first island barrier sorry still works though)"
DestroyIslandBarriers.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
DestroyIslandBarriers.TextScaled = true
DestroyIslandBarriers.TextSize = 14
DestroyIslandBarriers.TextStrokeColor3 = Color3.new(0.364706, 0.364706, 0.364706)
DestroyIslandBarriers.TextStrokeTransparency = 0
DestroyIslandBarriers.TextWrapped = true
 
Island.Name = "Island"
Island.Parent = Main
Island.BackgroundColor3 = Color3.new(1, 1, 1)
Island.Position = UDim2.new(0, 22, 0, 156)
Island.Size = UDim2.new(0, 200, 0, 50)
Island.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Island.Font = Enum.Font.SourceSans
Island.FontSize = Enum.FontSize.Size14
Island.Text = "Teleport to an Island"
Island.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
Island.TextScaled = true
Island.TextSize = 14
Island.TextStrokeColor3 = Color3.new(518.460388, 294.925598, 1201.00427)
Island.TextStrokeTransparency = 0
Island.TextWrapped = true
 
SpawnBarrier.Name = "SpawnBarrier"
SpawnBarrier.Parent = Main
SpawnBarrier.BackgroundColor3 = Color3.new(1, 1, 1)
SpawnBarrier.Position = UDim2.new(0, 236, 0, 185)
SpawnBarrier.Size = UDim2.new(0, 119, 0, 86)
SpawnBarrier.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
SpawnBarrier.Font = Enum.Font.SourceSans
SpawnBarrier.FontSize = Enum.FontSize.Size14
SpawnBarrier.Text = "Destroy Spawn barrier (Allows you to walk right off of spawn)"
SpawnBarrier.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
SpawnBarrier.TextScaled = true
SpawnBarrier.TextSize = 14
SpawnBarrier.TextStrokeColor3 = Color3.new(0.364706, 0.364706, 0.364706)
SpawnBarrier.TextStrokeTransparency = 0
SpawnBarrier.TextWrapped = true
 
SharkHome.Name = "SharkHome"
SharkHome.Parent = Main
SharkHome.BackgroundColor3 = Color3.new(1, 1, 1)
SharkHome.Position = UDim2.new(0, 376, 0, 88)
SharkHome.Size = UDim2.new(0, 200, 0, 50)
SharkHome.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
SharkHome.Font = Enum.Font.SourceSans
SharkHome.FontSize = Enum.FontSize.Size14
SharkHome.Text = "Teleport to the sharks home"
SharkHome.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
SharkHome.TextScaled = true
SharkHome.TextSize = 14
SharkHome.TextStrokeColor3 = Color3.new(0.364706, 0.364706, 0.364706)
SharkHome.TextStrokeTransparency = 0
SharkHome.TextWrapped = true
 
tpOnTopOfMap.Name = "tpOnTopOfMap"
tpOnTopOfMap.Parent = Main
tpOnTopOfMap.BackgroundColor3 = Color3.new(1, 1, 1)
tpOnTopOfMap.Position = UDim2.new(0, 382, 0, 232)
tpOnTopOfMap.Size = UDim2.new(0, 190, 0, 50)
tpOnTopOfMap.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
tpOnTopOfMap.Font = Enum.Font.SourceSans
tpOnTopOfMap.FontSize = Enum.FontSize.Size14
tpOnTopOfMap.Text = "Teleport on top of map"
tpOnTopOfMap.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
tpOnTopOfMap.TextScaled = true
tpOnTopOfMap.TextSize = 14
tpOnTopOfMap.TextStrokeColor3 = Color3.new(0.364706, 0.364706, 0.364706)
tpOnTopOfMap.TextStrokeTransparency = 0
tpOnTopOfMap.TextWrapped = true
 
Close.Name = "Close"
Close.Parent = Main
Close.BackgroundColor3 = Color3.new(1, 0, 0)
Close.BorderColor3 = Color3.new(0.509804, 0.0627451, 0.00392157)
Close.Position = UDim2.new(0, 586, 0, -19)
Close.Size = UDim2.new(0, 23, 0, 25)
Close.Font = Enum.Font.ArialBold
Close.FontSize = Enum.FontSize.Size14
Close.Text = "X"
Close.TextColor3 = Color3.new(0, 0, 0)
Close.TextSize = 14
 
Water.Name = "Water"
Water.Parent = Main
Water.BackgroundColor3 = Color3.new(1, 1, 1)
Water.Position = UDim2.new(0, 374, 0, 156)
Water.Size = UDim2.new(0, 200, 0, 50)
Water.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Water.Font = Enum.Font.SourceSans
Water.FontSize = Enum.FontSize.Size14
Water.Text = "Teleport to the water"
Water.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
Water.TextScaled = true
Water.TextSize = 14
Water.TextStrokeColor3 = Color3.new(0.364706, 0.364706, 0.364706)
Water.TextStrokeTransparency = 0
Water.TextWrapped = true
 
NoNeedToEdit.Name = "NoNeedToEdit"
NoNeedToEdit.Parent = Main
NoNeedToEdit.BackgroundColor3 = Color3.new(0.258824, 0.403922, 0.509804)
NoNeedToEdit.BorderColor3 = Color3.new(0.258824, 0.403922, 0.509804)
NoNeedToEdit.Position = UDim2.new(0, 227, 0, 275)
NoNeedToEdit.Size = UDim2.new(0, 138, 0, 86)
NoNeedToEdit.Font = Enum.Font.SourceSans
NoNeedToEdit.FontSize = Enum.FontSize.Size18
NoNeedToEdit.Text = "Please know this is for SharkBite usually you find it on the popular tab :) and thank you for using this <3 V-2"
NoNeedToEdit.TextColor3 = Color3.new(0.0235294, 0.129412, 0.223529)
NoNeedToEdit.TextScaled = true
NoNeedToEdit.TextSize = 15
NoNeedToEdit.TextStrokeColor3 = Color3.new(0.113725, 0.501961, 0.866667)
NoNeedToEdit.TextStrokeTransparency = 0.69999998807907
NoNeedToEdit.TextWrapped = true
 
TextLabel.Parent = NoNeedToEdit
TextLabel.BackgroundColor3 = Color3.new(0.258824, 0.403922, 0.509804)
TextLabel.BorderColor3 = Color3.new(0.258824, 0.403922, 0.509804)
TextLabel.Position = UDim2.new(0, 0, 0, 86)
TextLabel.Size = UDim2.new(0, 138, 0, 25)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.FontSize = Enum.FontSize.Size14
TextLabel.Text = ""
TextLabel.TextSize = 14
 
outSideOfMap.Name = "outSideOfMap"
outSideOfMap.Parent = Main
outSideOfMap.BackgroundColor3 = Color3.new(1, 1, 1)
outSideOfMap.Position = UDim2.new(0, 236, 0, 95)
outSideOfMap.Size = UDim2.new(0, 119, 0, 86)
outSideOfMap.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
outSideOfMap.Font = Enum.Font.SourceSans
outSideOfMap.FontSize = Enum.FontSize.Size14
outSideOfMap.Text = "Teleport outside of the map"
outSideOfMap.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
outSideOfMap.TextScaled = true
outSideOfMap.TextSize = 14
outSideOfMap.TextStrokeColor3 = Color3.new(0.364706, 0.364706, 0.364706)
outSideOfMap.TextStrokeTransparency = 0
outSideOfMap.TextWrapped = true
 
Spawn.Name = "Spawn"
Spawn.Parent = Main
Spawn.BackgroundColor3 = Color3.new(1, 1, 1)
Spawn.Position = UDim2.new(0, 23, 0, 92)
Spawn.Size = UDim2.new(0, 200, 0, 50)
Spawn.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
Spawn.Font = Enum.Font.SourceSans
Spawn.FontSize = Enum.FontSize.Size14
Spawn.Text = "Win everyround"
Spawn.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
Spawn.TextScaled = true
Spawn.TextSize = 14
Spawn.TextStrokeColor3 = Color3.new(0.364706, 0.364706, 0.364706)
Spawn.TextStrokeTransparency = 0
Spawn.TextWrapped = true
 
tpToSpawn.Name = "tpToSpawn"
tpToSpawn.Parent = Main
tpToSpawn.BackgroundColor3 = Color3.new(1, 1, 1)
tpToSpawn.Position = UDim2.new(0, 23, 0, 300)
tpToSpawn.Size = UDim2.new(0, 200, 0, 69)
tpToSpawn.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
tpToSpawn.Font = Enum.Font.SourceSans
tpToSpawn.FontSize = Enum.FontSize.Size14
tpToSpawn.Text = "Teleport to spawn (Good for escaping the shark)"
tpToSpawn.TextColor3 = Color3.new(0.882353, 0.882353, 0.882353)
tpToSpawn.TextScaled = true
tpToSpawn.TextSize = 14
tpToSpawn.TextStrokeColor3 = Color3.new(0.364706, 0.364706, 0.364706)
tpToSpawn.TextStrokeTransparency = 0
tpToSpawn.TextWrapped = true
 
Open.Name = "Open"
Open.Parent = SharkBiteV2
Open.BackgroundColor3 = Color3.new(0.462745, 0.72549, 0.909804)
Open.BorderColor3 = Color3.new(0.211765, 0.333333, 0.419608)
Open.BorderSizePixel = 6
Open.Draggable = true
Open.Position = UDim2.new(0, 777, 0, 0)
Open.Size = UDim2.new(0, 86, 0, 50)
Open.Font = Enum.Font.ArialBold
Open.FontSize = Enum.FontSize.Size14
Open.Text = "Open"
Open.TextColor3 = Color3.new(0.345098, 0.537255, 0.67451)
Open.TextScaled = true
Open.TextSize = 14
Open.TextStrokeColor3 = Color3.new(0.203922, 0.321569, 0.403922)
Open.TextStrokeTransparency = 0
Open.TextWrapped = true
 
Open.MouseButton1Down:connect(function()
	Main.Visible = true
end)
 
Close.MouseButton1Down:connect(function()
	Main.Visible = false
end)
 
Spawn.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7.83537865, 285, 125.780952)
end)
 
Water.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1087.05896, 270.061218, -132.401871)
end)
 
SharkHome.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(8.13647556, 109.141472, 62.5032921)
end)
 
tpInsideShark.MouseButton1Down:connect(function()
	local Player = game.Players.LocalPlayer.Name
 
for index, child in pairs(game.workspace.Sharks:GetChildren()) do
    shark = tostring(child.Name)
end
 
game.workspace.Sharks[shark].Body.Weld.Part1 = game.workspace[Player].Torso
game.workspace.Sharks[shark].Body.Transparency = 1
 
game.Players.LocalPlayer.Character.Humanoid.Name = 1
local l = game.Players.LocalPlayer.Character["1"]:Clone()
l.Parent = game.Players.LocalPlayer.Character
l.Name = "Humanoid"
wait(0.1)
game.Players.LocalPlayer.Character["1"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.Character.Animate.Disabled = true
wait(0.1)
game.Players.LocalPlayer.Character.Animate.Disabled = false
game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
end)
 
Island.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(511.770996, 261.023529, -691.858948)
end)
 
tpOnTopOfMap.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(150.609, 746.224, -522.41)
end)
 
outSideOfMap.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1927.028, 308.338, -160.652)
end)
 
tpToSpawn.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-18.5856209, 466.08041, 17.5029106)
end)
 
SpawnBarrier.MouseButton1Down:connect(function()
	game.Workspace.Barrier:Destroy()
end)
 
DestroyIslandBarriers.MouseButton1Down:connect(function()
	game.Workspace.SmallIslandBarrier2:Destroy()
	game.Workspace.StuffSimonHasntFoldered.SmallIslandBarriers3:Destroy()
end)