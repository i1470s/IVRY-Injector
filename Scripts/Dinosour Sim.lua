local ScreenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local open = Instance.new("TextButton")
local main = Instance.new("Frame")
local title = Instance.new("TextBox")
local credits = Instance.new("TextBox")
local savep = Instance.new("TextButton")
local loadp = Instance.new("TextButton")
local speed = Instance.new("TextButton")
local food = Instance.new("TextButton")
local close = Instance.new("TextButton")
--Properties:
ScreenGui.Parent = game.CoreGui
 
frame.Name = "frame"
frame.Parent = ScreenGui
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.Position = UDim2.new(0.450560659, 0, 0, 0)
frame.Size = UDim2.new(0, 96, 0, 19)
frame.Style = Enum.FrameStyle.DropShadow
 
open.Name = "open"
open.Parent = frame
open.BackgroundColor3 = Color3.new(0, 0, 0)
open.BackgroundTransparency = 0.60000002384186
open.Position = UDim2.new(-0.0624999925, 0, -0.789473712, 0)
open.Size = UDim2.new(0, 93, 0, 11)
open.Font = Enum.Font.SciFi
open.Text = "Open"
open.TextColor3 = Color3.new(1, 1, 1)
open.TextSize = 14
open.TextWrapped = true
open.MouseButton1Click:connect(function()
frame.Visible = false
main.Visible = true
end)
 
main.Name = "main"
main.Parent = ScreenGui
main.BackgroundColor3 = Color3.new(0, 0, 0)
main.BackgroundTransparency = 0.60000002384186
main.Position = UDim2.new(0.407747209, 0, 0.0823045224, 0)
main.Size = UDim2.new(0, 180, 0, 186)
main.Visible = false
main.Active = true
main.Draggable = true
 
title.Name = "title"
title.Parent = main
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.Position = UDim2.new(-0.055555556, 0, -0.0806451589, 0)
title.Size = UDim2.new(0, 200, 0, 21)
title.Font = Enum.Font.SciFi
title.Text = "Dinosaur Simulator GUI"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.TextSize = 14
title.TextWrapped = true
 
credits.Name = "credits"
credits.Parent = main
credits.BackgroundColor3 = Color3.new(0, 0, 0)
credits.Position = UDim2.new(-0.055555556, 0, 1, 0)
credits.Size = UDim2.new(0, 200, 0, 21)
credits.Font = Enum.Font.SciFi
credits.Text = "Made By Nootella On V3rm"
credits.TextColor3 = Color3.new(1, 1, 1)
credits.TextScaled = true
credits.TextSize = 14
credits.TextWrapped = true
 
savep.Name = "savep"
savep.Parent = main
savep.BackgroundColor3 = Color3.new(0, 0, 0)
savep.Position = UDim2.new(0.0333333351, 0, 0.0645161271, 0)
savep.Size = UDim2.new(0, 68, 0, 67)
savep.Font = Enum.Font.Cartoon
savep.Text = "Save Position"
savep.TextColor3 = Color3.new(1, 1, 1)
savep.TextScaled = true
savep.TextSize = 14
savep.TextWrapped = true
savep.MouseButton1Click:connect(function()
asd=game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end)
 
loadp.Name = "loadp"
loadp.Parent = main
loadp.BackgroundColor3 = Color3.new(0, 0, 0)
loadp.Position = UDim2.new(0.577777803, 0, 0.0645161271, 0)
loadp.Size = UDim2.new(0, 70, 0, 69)
loadp.Font = Enum.Font.Cartoon
loadp.Text = "Load Position"
loadp.TextColor3 = Color3.new(1, 1, 1)
loadp.TextScaled = true
loadp.TextSize = 14
loadp.TextWrapped = true
loadp.MouseButton1Click:connect(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=
CFrame.new(asd)+Vector3.new(1,0,0)
end)
 
speed.Name = "speed"
speed.Parent = main
speed.BackgroundColor3 = Color3.new(0, 0, 0)
speed.Position = UDim2.new(0.0333333351, 0, 0.606664002, 0)
speed.Size = UDim2.new(0, 68, 0, 67)
speed.Font = Enum.Font.Cartoon
speed.Text = "Speed Only For Barosaurus"
speed.TextColor3 = Color3.new(1, 1, 1)
speed.TextScaled = true
speed.TextSize = 14
speed.TextWrapped = true
speed.MouseButton1Click:connect(function()
while true do
dino = "Barosaurus"
game.Workspace[dino].Dinosaur.WalkSpeed = 65
wait(0.5)
end
end)
 
food.Name = "food"
food.Parent = main
food.BackgroundColor3 = Color3.new(0, 0, 0)
food.Position = UDim2.new(0.577777803, 0, 0.596044064, 0)
food.Size = UDim2.new(0, 70, 0, 69)
food.Font = Enum.Font.Cartoon
food.Text = "Food"
food.TextColor3 = Color3.new(1, 1, 1)
food.TextScaled = true
food.TextSize = 14
food.TextWrapped = true
food.MouseButton1Click:connect(function()
game.Workspace.GameEvents.EatPlant:FireServer(Workspace.GameMap.Ferns.Fern, 2)
end)
 
close.Name = "close"
close.Parent = main
close.BackgroundColor3 = Color3.new(0, 0, 0)
close.Position = UDim2.new(1.05555558, 0, -0.0806451589, 0)
close.Size = UDim2.new(0, 21, 0, 21)
close.Font = Enum.Font.SciFi
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextScaled = true
close.TextSize = 14
close.TextWrapped = true
close.MouseButton1Click:connect(function()
frame.Visible = true
main.Visible = false
end)