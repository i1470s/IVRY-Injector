local DisasterHAX = Instance.new("ScreenGui")
local MainUI = Instance.new("Frame")
local name = Instance.new("TextLabel")
local creds = Instance.new("TextLabel")
local TPLobby = Instance.new("TextButton")
 
Crazy = Instance.new("TextButton")
local TPMap = Instance.new("TextButton")
local Walkspeed = Instance.new("TextButton")
local AFKWins = Instance.new("TextButton")
local Speedvalue = Instance.new("TextBox")
local Jumpower = Instance.new("TextButton")
local Jumpvalue = Instance.new("TextBox")
local Nofalldamage = Instance.new("TextButton")
 
-- Properties
 
DisasterHAX.Name = "DisasterHAX"
DisasterHAX.Parent = game.CoreGui
 
MainUI.Name = "MainUI"
MainUI.Parent = DisasterHAX
MainUI.BackgroundColor3 = Color3.new(0.435294, 0.435294, 0.435294)
MainUI.Position = UDim2.new(0.612644732, 0, 0.0489642099, 0)
MainUI.Size = UDim2.new(0, 344, 0, 408)
 
name.Name = "name"
name.Parent = MainUI
name.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
name.Size = UDim2.new(0, 344, 0, 45)
name.Font = Enum.Font.SciFi
name.Text = "DisasterHax"
name.TextSize = 50
 
creds.Name = "creds"
creds.Parent = MainUI
creds.BackgroundColor3 = Color3.new(0.435294, 0.435294, 0.435294)
creds.BorderSizePixel = 0
creds.Position = UDim2.new(0, 0, 0.932153404, 0)
creds.Size = UDim2.new(0, 289, 0, 23)
creds.Font = Enum.Font.SciFi
creds.Text = "Made by Roboguyplayzroblox1"
creds.TextSize = 20
 
TPLobby.Name = "TPLobby"
TPLobby.Parent = MainUI
TPLobby.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
TPLobby.Position = UDim2.new(0.0529100522, 0, 0.485391617, 0)
TPLobby.Size = UDim2.new(0, 145, 0, 42)
TPLobby.Font = Enum.Font.SciFi
TPLobby.Text = "Tp to lobby"
TPLobby.TextSize = 20
TPLobby.TextWrapped = true
 
Crazy.Name = "Crazy"
Crazy.Parent = MainUI
Crazy.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
Crazy.Position = UDim2.new(0.518518567, 0, 0.485391617, 0)
Crazy.Size = UDim2.new(0, 145, 0, 42)
Crazy.Font = Enum.Font.SciFi
Crazy.Text = "Choose map"
Crazy.TextSize = 20
Crazy.TextWrapped = true
 
TPMap.Name = "TPMap"
TPMap.Parent = MainUI
TPMap.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
TPMap.Position = UDim2.new(0.0529100895, 0, 0.63009721, 0)
TPMap.Size = UDim2.new(0, 145, 0, 42)
TPMap.Font = Enum.Font.SciFi
TPMap.Text = "Tp to map"
TPMap.TextSize = 20
TPMap.TextWrapped = true
 
Walkspeed.Name = "Walkspeed"
Walkspeed.Parent = MainUI
Walkspeed.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
Walkspeed.Position = UDim2.new(0.0343915336, 0, 0.149574876, 0)
Walkspeed.Size = UDim2.new(0, 121, 0, 42)
Walkspeed.Font = Enum.Font.SciFi
Walkspeed.Text = "Walkspeed"
Walkspeed.TextSize = 20
Walkspeed.TextWrapped = true
 
AFKWins.Name = "AFKWins"
AFKWins.Parent = MainUI
AFKWins.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
AFKWins.Position = UDim2.new(0.518257022, 0, 0.630314112, 0)
AFKWins.Size = UDim2.new(0, 145, 0, 42)
AFKWins.Font = Enum.Font.SciFi
AFKWins.Text = "Afk wins"
AFKWins.TextSize = 20
AFKWins.TextWrapped = true
 
Speedvalue.Name = "Speedvalue"
Speedvalue.Parent = MainUI
Speedvalue.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
Speedvalue.Position = UDim2.new(0.386474103, 0, 0.149574876, 0)
Speedvalue.Size = UDim2.new(0, 129, 0, 42)
Speedvalue.Font = Enum.Font.SciFi
Speedvalue.Text = "Value"
Speedvalue.TextSize = 16
 
Jumpower.Name = "Jumpower"
Jumpower.Parent = MainUI
Jumpower.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
Jumpower.Position = UDim2.new(0.0343915336, 0, 0.278437614, 0)
Jumpower.Size = UDim2.new(0, 121, 0, 42)
Jumpower.Font = Enum.Font.SciFi
Jumpower.Text = "Jumpower"
Jumpower.TextSize = 20
Jumpower.TextWrapped = true
 
Jumpvalue.Name = "Jumpvalue"
Jumpvalue.Parent = MainUI
Jumpvalue.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
Jumpvalue.Position = UDim2.new(0.386474073, 0, 0.278437614, 0)
Jumpvalue.Size = UDim2.new(0, 129, 0, 42)
Jumpvalue.Font = Enum.Font.SciFi
Jumpvalue.Text = "Value"
Jumpvalue.TextSize = 16
 
Nofalldamage.Name = "Nofalldamage"
Nofalldamage.Parent = MainUI
Nofalldamage.BackgroundColor3 = Color3.new(0.6, 0, 0.6)
Nofalldamage.Position = UDim2.new(0.0618616641, 0, 0.765118003, 0)
Nofalldamage.Size = UDim2.new(0, 145, 0, 42)
Nofalldamage.Font = Enum.Font.SciFi
Nofalldamage.Text = "No fall damage"
Nofalldamage.TextSize = 20
Nofalldamage.TextWrapped = true
 
-- local
p = game.Players.LocalPlayer
 
 
-- draggable
MainUI.Active = true
MainUI.Draggable = true
 
 
-- Scripts 
 
Crazy.MouseButton1Click:connect(function()
local id = 1195159620
game:GetObjects('rbxassetid://'..id)[1].Parent=game.Players.LocalPlayer.PlayerGui
 
game.Players.LocalPlayer.PlayerGui.NDSMapSelector.Button.LeButton.Disabled = false
print("Select your map")
end)
 
AFKWins.MouseButton1Click:connect(function()
while true do
wait(5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-290, 178, 379)
game.Players.LocalPlayer.Character.Humanoid.Jump = true
end
end)
 
TPMap.MouseButton1Click:connect(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(106, 46, 3)
end)
 
 
TPLobby.MouseButton1Click:connect(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-290, 178, 379)
end)
 
Walkspeed.MouseButton1Click:connect(function()
p.Character.Humanoid.WalkSpeed = Speedvalue.Text
end)
 
Jumpower.MouseButton1Click:connect(function()
p.Character.Humanoid.JumpPower = Jumpvalue.Text
end)
 
 
Nofalldamage.MouseButton1Click:connect(function()
while wait(0.01) do
a = Instance.new("Script", game.Players.LocalPlayer.Character)
a.Name = "CharacterScript"
wait(0.02)
game.Players.LocalPlayer.Character.CharacterScript:Destroy()
end
end)