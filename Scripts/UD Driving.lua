-- Instances:
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Refuel = Instance.new("TextButton")
local Boost_toggle = Instance.new("TextButton")
local Boost = Instance.new("TextBox")
local info = Instance.new("TextLabel")
local Car_status = Instance.new("TextLabel")
local Credits = Instance.new("TextLabel")
--Properties:
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = true
 
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.262745, 0.262745, 0.262745)
Frame.Position = UDim2.new(0, 0, 0.270471454, 0)
Frame.Size = UDim2.new(0, 218, 0, 312)
 
Refuel.Name = "Refuel"
Refuel.Parent = Frame
Refuel.BackgroundColor3 = Color3.new(1, 1, 1)
Refuel.BackgroundTransparency = 1
Refuel.BorderColor3 = Color3.new(0.384314, 0.615686, 0.776471)
Refuel.Size = UDim2.new(0, 218, 0, 50)
Refuel.Font = Enum.Font.Highway
Refuel.Text = "Refuel"
Refuel.TextColor3 = Color3.new(1, 1, 1)
Refuel.TextSize = 20
 
Boost_toggle.Name = "Boost_toggle"
Boost_toggle.Parent = Frame
Boost_toggle.BackgroundColor3 = Color3.new(1, 1, 1)
Boost_toggle.BackgroundTransparency = 1
Boost_toggle.BorderColor3 = Color3.new(0.384314, 0.615686, 0.776471)
Boost_toggle.Position = UDim2.new(0, 0, 0.160256416, 0)
Boost_toggle.Size = UDim2.new(0, 218, 0, 50)
Boost_toggle.Font = Enum.Font.Highway
Boost_toggle.Text = "Boost is off"
Boost_toggle.TextColor3 = Color3.new(1, 1, 1)
Boost_toggle.TextSize = 20
 
Boost.Name = "Boost"
Boost.Parent = Frame
Boost.BackgroundColor3 = Color3.new(1, 1, 1)
Boost.BackgroundTransparency = 1
Boost.Position = UDim2.new(0, 0, 0.320512831, 0)
Boost.Size = UDim2.new(0, 218, 0, 50)
Boost.Font = Enum.Font.Highway
Boost.Text = "-13356"
Boost.TextColor3 = Color3.new(1, 1, 1)
Boost.TextSize = 20
 
info.Name = "info"
info.Parent = Frame
info.BackgroundColor3 = Color3.new(1, 1, 1)
info.BackgroundTransparency = 1
info.Position = UDim2.new(0, 0, 0.512820542, 0)
info.Size = UDim2.new(0, 218, 0, 50)
info.Font = Enum.Font.Highway
info.Text = "Default is -13356"
info.TextColor3 = Color3.new(1, 1, 1)
info.TextSize = 20
 
Car_status.Name = "Car_status"
Car_status.Parent = Frame
Car_status.BackgroundColor3 = Color3.new(1, 1, 1)
Car_status.BackgroundTransparency = 1
Car_status.Position = UDim2.new(0, 0, 0.673076987, 0)
Car_status.Size = UDim2.new(0, 218, 0, 50)
Car_status.Font = Enum.Font.Highway
Car_status.Text = "Default is -13356"
Car_status.TextColor3 = Color3.new(1, 1, 1)
Car_status.TextSize = 20
 
Credits.Name = "Credits"
Credits.Parent = Frame
Credits.BackgroundColor3 = Color3.new(1, 1, 1)
Credits.BackgroundTransparency = 1
Credits.Position = UDim2.new(0, 0, 0.839743674, 0)
Credits.Size = UDim2.new(0, 218, 0, 50)
Credits.Font = Enum.Font.Highway
Credits.Text = "Made by JustToSeePosts"
Credits.TextColor3 = Color3.new(1, 1, 1)
Credits.TextSize = 20
-- Scripts:
function SCRIPT_GMMN76_FAKESCRIPT() -- Frame.Script 
	local script = Instance.new('Script')
	script.Parent = Frame
	script.Parent.Refuel.MouseButton1Click:Connect(function()
		vehicle.VehicleSeat.Values.Gas.Value = 10000
	end)
	script.Parent.Boost_toggle.MouseButton1Click:Connect(function()
		if script.Parent.Boost_toggle.Text == "Boost is off" then
			vehicle.VehicleSeat.BoostForce.Force = Vector3.new(0,0,script.Parent.Boost.Text)
			script.Parent.Boost_toggle.Text = "Boost is on"
		else
			vehicle.VehicleSeat.BoostForce.Force = Vector3.new(0,0,0)
			script.Parent.Boost_toggle.Text = "Boost is off"
		end
 
	end)
	vehicle = nil
	while wait(1) do
		for i,v in pairs(game.Workspace._Main.Vehicles:GetChildren()) do
 
			if v.VehicleSeat.Values.Owner.Value == game.Players.LocalPlayer.Name then
				vehicle = v
				script.Parent.Car_status.Text = "Your car is a " .. v.Name
			elseif vehicle ~= nil and vehicle.VehicleSeat.Values.Driver.Value == game.Players.LocalPlayer.Name then
				vehicle = v
				script.Parent.Car_status.Text = "Your car is a " .. v.Name
 
			else 
				script.Parent.Car_status.Text = "Your car has not been found" 
			end
		end
	end
 
end
coroutine.resume(coroutine.create(SCRIPT_GMMN76_FAKESCRIPT))