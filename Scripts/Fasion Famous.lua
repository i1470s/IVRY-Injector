-- Gui to Lua
-- Version: 3
 
-- Instances:
 
local FashionFuck = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local GoToVIP = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
 
--Properties:
 
FashionFuck.Name = "FashionFuck"
FashionFuck.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
FashionFuck.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
 
Frame.Parent = FashionFuck
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.Position = UDim2.new(-0.863456964, 0, -7.4505806e-09, 0)
Frame.Size = UDim2.new(0, 3224, 0, 40)
Frame.Style = Enum.FrameStyle.RobloxRound
 
GoToVIP.Name = "GoToVIP"
GoToVIP.Parent = Frame
GoToVIP.BackgroundColor3 = Color3.new(1, 1, 1)
GoToVIP.Position = UDim2.new(0.68671006, 0, -0.175000086, 0)
GoToVIP.Size = UDim2.new(0, 200, 0, 31)
GoToVIP.Style = Enum.ButtonStyle.RobloxRoundButton
GoToVIP.Font = Enum.Font.SourceSans
GoToVIP.Text = "Tp to VIP "
GoToVIP.TextColor3 = Color3.new(0, 0, 0)
GoToVIP.TextScaled = true
GoToVIP.TextSize = 14
GoToVIP.TextWrapped = true
 
TextLabel.Parent = FashionFuck
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.309392273, 0, 0.954545438, 0)
TextLabel.Size = UDim2.new(0, 520, 0, 50)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Made by DDi"
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.TextSize = 14
 
-- Scripts:
 
local function PDOOE_fake_script() -- GoToVIP.LocalScript 
	local script = Instance.new('LocalScript', GoToVIP)
 
	game.Players.LocalPlayer.PlayerGui.FashionFuck.Frame.GoToVIP.MouseButton1Click:connect (function()
		local x = 2510
		local y = 63
		local z = -408
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z))
	end)
end
coroutine.wrap(PDOOE_fake_script)()