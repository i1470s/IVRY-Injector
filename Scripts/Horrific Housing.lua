-- Farewell Infortality.
-- Version: 2.82
-- Instances:
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local TextButton = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")
local TextButton_4 = Instance.new("TextButton")
local TextButton_5 = Instance.new("TextButton")
local TextButton_6 = Instance.new("TextButton")
local TextButton_7 = Instance.new("TextButton")
local TextButton_8 = Instance.new("TextButton")
local TextButton_9 = Instance.new("TextButton")
local TextButton_10 = Instance.new("TextButton")
local TextButton_11 = Instance.new("TextButton")
local TextButton_12 = Instance.new("TextButton")
local TextButton_13 = Instance.new("TextButton")
local ScrollingFrame_2 = Instance.new("ScrollingFrame")
local TextButton_14 = Instance.new("TextButton")
local TextButton_15 = Instance.new("TextButton")
local TextButton_16 = Instance.new("TextButton")
local TextButton_17 = Instance.new("TextButton")
local TextButton_18 = Instance.new("TextButton")
local TextButton_19 = Instance.new("TextButton")
local TextButton_20 = Instance.new("TextButton")
local TextButton_21 = Instance.new("TextButton")
local TextButton_22 = Instance.new("TextButton")
local TextButton_23 = Instance.new("TextButton")
local TextButton_24 = Instance.new("TextButton")
local TextButton_25 = Instance.new("TextButton")
local TextButton_26 = Instance.new("TextButton")
local TextButton_27 = Instance.new("TextButton")
local TextButton_28 = Instance.new("TextButton")
local TextButton_29 = Instance.new("TextButton")
local TextButton_up = Instance.new("TextButton")
local Frame_3 = Instance.new("Frame")
local TextButton_30 = Instance.new("TextButton")
local TextBox = Instance.new("TextBox")
local TextButton_31 = Instance.new("TextButton")
local TextBox_2 = Instance.new("TextBox")
local TextButton_32 = Instance.new("TextButton")
local Back = Instance.new("TextButton")
local TextButton_33 = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
--Properties:
ScreenGui.Parent = game.CoreGui


Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.Position = UDim2.new(0.376923084, 0, 0.396411121, 0)
Frame.Size = UDim2.new(0, 316, 0, 16)
Frame.Draggable = true;
Frame.Active = true



Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.new(0.619608, 0.619608, 0.619608)
Frame_2.Position = UDim2.new(-0.000584179827, 0, 0.999998987, 0)
Frame_2.Size = UDim2.new(0, 316, 0, 126)

ScrollingFrame.Parent = Frame_2
ScrollingFrame.BackgroundColor3 = Color3.new(0.619608, 0.619608, 0.619608)
ScrollingFrame.Position = UDim2.new(0.683544278, 0, 0.206349209, 0)
ScrollingFrame.Size = UDim2.new(0, 100, 0, 100)

TextButton.Parent = ScrollingFrame
TextButton.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton.Position = UDim2.new(0, 0, -0.00760009745, 0)
TextButton.Size = UDim2.new(0, 89, 0, 20)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "FrostDragon"
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.TextSize = 14
TextButton.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("FrostDragon")
end)

TextButton_2.Parent = ScrollingFrame
TextButton_2.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_2.Position = UDim2.new(0, 0, 0.0717649832, 0)
TextButton_2.Size = UDim2.new(0, 89, 0, 20)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "Penguin"
TextButton_2.TextColor3 = Color3.new(0, 0, 0)
TextButton_2.TextSize = 14
TextButton_2.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("Penguin")
end)

TextButton_3.Parent = ScrollingFrame
TextButton_3.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_3.Position = UDim2.new(0, 0, 0.151130065, 0)
TextButton_3.Size = UDim2.new(0, 89, 0, 20)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = "Phoenix"
TextButton_3.TextColor3 = Color3.new(0, 0, 0)
TextButton_3.TextSize = 14
TextButton_3.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("Phoenix")
end)

TextButton_4.Parent = ScrollingFrame
TextButton_4.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_4.Position = UDim2.new(0, 0, 0.230495155, 0)
TextButton_4.Size = UDim2.new(0, 89, 0, 20)
TextButton_4.Font = Enum.Font.SourceSans
TextButton_4.Text = "Oof"
TextButton_4.TextColor3 = Color3.new(0, 0, 0)
TextButton_4.TextSize = 14
TextButton_4.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("Oof")
end)

TextButton_5.Parent = ScrollingFrame
TextButton_5.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_5.Position = UDim2.new(0, 0, 0.309860229, 0)
TextButton_5.Size = UDim2.new(0, 89, 0, 20)
TextButton_5.Font = Enum.Font.SourceSans
TextButton_5.Text = "Doge"
TextButton_5.TextColor3 = Color3.new(0, 0, 0)
TextButton_5.TextSize = 14
TextButton_5.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("Doge")
end)

TextButton_6.Parent = ScrollingFrame
TextButton_6.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_6.Position = UDim2.new(0, 0, 0.385257035, 0)
TextButton_6.Size = UDim2.new(0, 89, 0, 20)
TextButton_6.Font = Enum.Font.SourceSans
TextButton_6.Text = "Duck"
TextButton_6.TextColor3 = Color3.new(0, 0, 0)
TextButton_6.TextSize = 14
TextButton_6.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("Duck")
end)

TextButton_7.Parent = ScrollingFrame
TextButton_7.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_7.Position = UDim2.new(0, 0, 0.46462211, 0)
TextButton_7.Size = UDim2.new(0, 89, 0, 20)
TextButton_7.Font = Enum.Font.SourceSans
TextButton_7.Text = "BabyDragon"
TextButton_7.TextColor3 = Color3.new(0, 0, 0)
TextButton_7.TextSize = 14
TextButton_7.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("BabyDragon")
end)

TextButton_8.Parent = ScrollingFrame
TextButton_8.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_8.Position = UDim2.new(0, 0, 0.543987215, 0)
TextButton_8.Size = UDim2.new(0, 89, 0, 20)
TextButton_8.Font = Enum.Font.SourceSans
TextButton_8.Text = "BunnyBot"
TextButton_8.TextColor3 = Color3.new(0, 0, 0)
TextButton_8.TextSize = 14
TextButton_8.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("BunnyBot")
end)

TextButton_9.Parent = ScrollingFrame
TextButton_9.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_9.Position = UDim2.new(0, 0, 0.623352289, 0)
TextButton_9.Size = UDim2.new(0, 89, 0, 20)
TextButton_9.Font = Enum.Font.SourceSans
TextButton_9.Text = "Skull"
TextButton_9.TextColor3 = Color3.new(0, 0, 0)
TextButton_9.TextSize = 14
TextButton_9.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("Skull")
end)

TextButton_10.Parent = ScrollingFrame
TextButton_10.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_10.Position = UDim2.new(0, 0, 0.706685603, 0)
TextButton_10.Size = UDim2.new(0, 89, 0, 20)
TextButton_10.Font = Enum.Font.SourceSans
TextButton_10.Text = "Unicorn"
TextButton_10.TextColor3 = Color3.new(0, 0, 0)
TextButton_10.TextSize = 14
TextButton_10.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("Unicorn")
end)

TextButton_11.Parent = ScrollingFrame
TextButton_11.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_11.Position = UDim2.new(0, 0, 0.786050677, 0)
TextButton_11.Size = UDim2.new(0, 89, 0, 20)
TextButton_11.Font = Enum.Font.SourceSans
TextButton_11.Text = "Despacito"
TextButton_11.TextColor3 = Color3.new(0, 0, 0)
TextButton_11.TextSize = 14
TextButton_11.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("Despacito")
end)

TextButton_12.Parent = ScrollingFrame
TextButton_12.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_12.Position = UDim2.new(0, 0, 0.865415752, 0)
TextButton_12.Size = UDim2.new(0, 89, 0, 20)
TextButton_12.Font = Enum.Font.SourceSans
TextButton_12.Text = "GoldDragon"
TextButton_12.TextColor3 = Color3.new(0, 0, 0)
TextButton_12.TextSize = 14
TextButton_12.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("GoldDragon")
end)

TextButton_13.Parent = ScrollingFrame
TextButton_13.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_13.Position = UDim2.new(0, 0, 0.942829549, 0)
TextButton_13.Size = UDim2.new(0, 89, 0, 14)
TextButton_13.Font = Enum.Font.SourceSans
TextButton_13.Text = "KnifePet"
TextButton_13.TextColor3 = Color3.new(0, 0, 0)
TextButton_13.TextSize = 14
TextButton_13.MouseButton1Click:connect(function()
	game.ReplicatedStorage.PetChange:FireServer("KnifePet")
end)

ScrollingFrame_2.Parent = Frame_2
ScrollingFrame_2.BackgroundColor3 = Color3.new(0.619608, 0.619608, 0.619608)
ScrollingFrame_2.Position = UDim2.new(0, 0, 0.206349209, 0)
ScrollingFrame_2.Size = UDim2.new(0, 100, 0, 100)

TextButton_14.Parent = ScrollingFrame_2
TextButton_14.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_14.Position = UDim2.new(0, 0, -0.00760009745, 0)
TextButton_14.Size = UDim2.new(0, 89, 0, 20)
TextButton_14.Font = Enum.Font.SourceSans
TextButton_14.Text = "DoorMat"
TextButton_14.TextColor3 = Color3.new(0, 0, 0)
TextButton_14.TextSize = 14
TextButton_14.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "DoorMat")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "DoorMat")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "DoorMat")
	end
end)

TextButton_15.Parent = ScrollingFrame_2
TextButton_15.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_15.Position = UDim2.new(0, 0, 0.0717649832, 0)
TextButton_15.Size = UDim2.new(0, 89, 0, 20)
TextButton_15.Font = Enum.Font.SourceSans
TextButton_15.Text = "Chimney"
TextButton_15.TextColor3 = Color3.new(0, 0, 0)
TextButton_15.TextSize = 14
TextButton_15.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "Chimney")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "Chimney")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "Chimney")
	end
end)

TextButton_16.Parent = ScrollingFrame_2
TextButton_16.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_16.Position = UDim2.new(0, 0, 0.151130065, 0)
TextButton_16.Size = UDim2.new(0, 89, 0, 20)
TextButton_16.Font = Enum.Font.SourceSans
TextButton_16.Text = "Bell"
TextButton_16.TextColor3 = Color3.new(0, 0, 0)
TextButton_16.TextSize = 14
TextButton_16.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "Bell")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "Bell")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "Bell")
	end
end)

TextButton_17.Parent = ScrollingFrame_2
TextButton_17.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_17.Position = UDim2.new(0, 0, 0.230495155, 0)
TextButton_17.Size = UDim2.new(0, 89, 0, 20)
TextButton_17.Font = Enum.Font.SourceSans
TextButton_17.Text = "Ladder"
TextButton_17.TextColor3 = Color3.new(0, 0, 0)
TextButton_17.TextSize = 14
TextButton_17.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "Ladder")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "Ladder")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "Ladder")
	end
end)

TextButton_18.Parent = ScrollingFrame_2
TextButton_18.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_18.Position = UDim2.new(0, 0, 0.385257035, 0)
TextButton_18.Size = UDim2.new(0, 89, 0, 20)
TextButton_18.Font = Enum.Font.SourceSans
TextButton_18.Text = "FireBlade"
TextButton_18.TextColor3 = Color3.new(0, 0, 0)
TextButton_18.TextSize = 14
TextButton_18.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "FireBlade")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "FireBlade")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "FireBlade")
	end
end)

TextButton_19.Parent = ScrollingFrame_2
TextButton_19.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_19.Position = UDim2.new(0, 0, 0.46462211, 0)
TextButton_19.Size = UDim2.new(0, 89, 0, 20)
TextButton_19.Font = Enum.Font.SourceSans
TextButton_19.Text = "StreetLight"
TextButton_19.TextColor3 = Color3.new(0, 0, 0)
TextButton_19.TextSize = 14
TextButton_19.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "StreetLight")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "StreetLight")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "StreetLight")
	end
end)

TextButton_20.Parent = ScrollingFrame_2
TextButton_20.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_20.Position = UDim2.new(0, 0, 0.543987215, 0)
TextButton_20.Size = UDim2.new(0, 89, 0, 20)
TextButton_20.Font = Enum.Font.SourceSans
TextButton_20.Text = "Soon!"
TextButton_20.TextColor3 = Color3.new(0, 0, 0)
TextButton_20.TextSize = 14
TextButton_20.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "_8bitDuck")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "_8bitDuck")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "_8bitDuck")
	end
end)

TextButton_21.Parent = ScrollingFrame_2
TextButton_21.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_21.Position = UDim2.new(0, 0, 0.623352289, 0)
TextButton_21.Size = UDim2.new(0, 89, 0, 20)
TextButton_21.Font = Enum.Font.SourceSans
TextButton_21.Text = "PostBox"
TextButton_21.TextColor3 = Color3.new(0, 0, 0)
TextButton_21.TextSize = 14
TextButton_21.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "PostBox")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "PostBox")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "PostBox")
	end
end)

TextButton_22.Parent = ScrollingFrame_2
TextButton_22.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_22.Position = UDim2.new(0, 0, 0.706685603, 0)
TextButton_22.Size = UDim2.new(0, 89, 0, 20)
TextButton_22.Font = Enum.Font.SourceSans
TextButton_22.Text = "Beans"
TextButton_22.TextColor3 = Color3.new(0, 0, 0)
TextButton_22.TextSize = 14
TextButton_22.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "Beans")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "Beans")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "Beans")
	end
end)

TextButton_23.Parent = ScrollingFrame_2
TextButton_23.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_23.Position = UDim2.new(0, 0, 0.786050677, 0)
TextButton_23.Size = UDim2.new(0, 89, 0, 20)
TextButton_23.Font = Enum.Font.SourceSans
TextButton_23.Text = "Soon!"
TextButton_23.TextColor3 = Color3.new(0, 0, 0)
TextButton_23.TextSize = 14
TextButton_23.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "Despacito")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "Despacito")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "Despacito")
	end
end)

TextButton_24.Parent = ScrollingFrame_2
TextButton_24.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_24.Position = UDim2.new(0, 0, 0.309860229, 0)
TextButton_24.Size = UDim2.new(0, 89, 0, 20)
TextButton_24.Font = Enum.Font.SourceSans
TextButton_24.Text = "Plant"
TextButton_24.TextColor3 = Color3.new(0, 0, 0)
TextButton_24.TextSize = 14
TextButton_24.MouseButton1Click:connect(function()
	if TextButton_25.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament1", "Plant")
	elseif TextButton_26.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament2", "Plant")
	elseif TextButton_27.Text == "Selected" then
		game.ReplicatedStorage.OrnamentChanged:FireServer("Ornament3", "Plant")
	end
end)

TextButton_25.Parent = Frame_2
TextButton_25.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_25.Position = UDim2.new(0.423835456, 0, 0.206349209, 0)
TextButton_25.Size = UDim2.new(0, 44, 0, 27)
TextButton_25.Font = Enum.Font.SourceSans
TextButton_25.Text = "Slot1"
TextButton_25.TextColor3 = Color3.new(0, 0, 0)
TextButton_25.TextSize = 14
TextButton_25.MouseButton1Click:connect(function()
TextButton_26.Text = "Slot2"
TextButton_25.Text = "Selected"
TextButton_27.Text = "Slot3"
	
	
end)

TextButton_26.Parent = Frame_2
TextButton_26.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_26.Position = UDim2.new(0.423835456, 0, 0.491873115, 0)
TextButton_26.Size = UDim2.new(0, 44, 0, 27)
TextButton_26.Font = Enum.Font.SourceSans
TextButton_26.Text = "Slot2"
TextButton_26.TextColor3 = Color3.new(0, 0, 0)
TextButton_26.TextSize = 14
TextButton_26.MouseButton1Click:connect(function()
TextButton_26.Text = "Selected"
TextButton_25.Text = "Slot1"
TextButton_27.Text = "Slot3"

end)
TextButton_27.Parent = Frame_2
TextButton_27.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_27.Position = UDim2.new(0.423835456, 0, 0.777777791, 0)
TextButton_27.Size = UDim2.new(0, 44, 0, 28)
TextButton_27.Font = Enum.Font.SourceSans
TextButton_27.Text = "Slot3"
TextButton_27.TextColor3 = Color3.new(0, 0, 0)
TextButton_27.TextSize = 14
TextButton_27.MouseButton1Click:connect(function()
TextButton_26.Text = "Slot2"
TextButton_25.Text = "Slot1"
TextButton_27.Text = "Selected"
	
	
end)

TextButton_28.Parent = Frame
TextButton_28.BackgroundColor3 = Color3.new(0.807843, 0, 0.0117647)
TextButton_28.Position = UDim2.new(0.965189874, 0, -1.01725266e-06, 0)
TextButton_28.Size = UDim2.new(0, 11, 0, 15)
TextButton_28.Font = Enum.Font.SourceSans
TextButton_28.Text = "X"
TextButton_28.TextColor3 = Color3.new(0, 0, 0)
TextButton_28.TextSize = 14
TextButton_28.MouseButton1Click:connect(function()
Frame:Destroy()


end)

TextButton_29.Parent = Frame_2
TextButton_29.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_29.Position = UDim2.new(0.363708884, 0, 0, 0)
TextButton_29.Size = UDim2.new(0, 85, 0, 17)
TextButton_29.Font = Enum.Font.SourceSans
TextButton_29.Text = "Random Color"
TextButton_29.TextColor3 = Color3.new(0, 0, 0)
TextButton_29.TextSize = 14
TextButton_29.MouseButton1Click:connect(function()
game.ReplicatedStorage.HouseColour:FireServer(Color3.new(math.random(255), math.random(255), math.random(255)))
	
	
	
end)
Frame_3.Parent = Frame
Frame_3.BackgroundColor3 = Color3.new(0.619608, 0.619608, 0.619608)
Frame_3.Position = UDim2.new(0, 0, 1, 0)
Frame_3.Size = UDim2.new(0, 316, 0, 126)
Frame_3.Visible = false;

TextButton_up.Parent = Frame_2
TextButton_up.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_up.Position = UDim2.new(0.900, 0, 0, 0)
TextButton_up.Size = UDim2.new(0, 32, 0, 11)
TextButton_up.Font = Enum.Font.SourceSans
TextButton_up.Text = "->"
TextButton_up.TextColor3 = Color3.new(0, 0, 0)
TextButton_up.TextSize = 14
TextButton_up.MouseButton1Click:connect(function()
Frame_2.Visible = false;
Frame_3.Visible = true;
	
	
end)


TextButton_30.Parent = Frame_3
TextButton_30.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_30.Size = UDim2.new(0, 76, 0, 20)
TextButton_30.Font = Enum.Font.SourceSans
TextButton_30.Text = "WalkSpeed"
TextButton_30.TextColor3 = Color3.new(0, 0, 0)
TextButton_30.TextSize = 14
TextButton_30.MouseButton1Click:connect(function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = TextBox.Text
	
end)

TextBox.Parent = Frame_3
TextBox.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextBox.Position = UDim2.new(0, 0, 0.158730164, 0)
TextBox.Size = UDim2.new(0, 76, 0, 24)
TextBox.Font = Enum.Font.SourceSans
TextBox.Text = "100"
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.TextSize = 14

TextButton_31.Parent = Frame_3
TextButton_31.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_31.Position = UDim2.new(0.281645566, 0, 0, 0)
TextButton_31.Size = UDim2.new(0, 76, 0, 20)
TextButton_31.Font = Enum.Font.SourceSans
TextButton_31.Text = "JumpPower"
TextButton_31.TextColor3 = Color3.new(0, 0, 0)
TextButton_31.TextSize = 14
TextButton_31.MouseButton1Click:connect(function()
game.Players.LocalPlayer.Character.Humanoid.JumpPower = TextBox_2.Text
	
end)

TextBox_2.Parent = Frame_3
TextBox_2.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextBox_2.Position = UDim2.new(0.281645566, 0, 0.158730164, 0)
TextBox_2.Size = UDim2.new(0, 76, 0, 24)
TextBox_2.Font = Enum.Font.SourceSans
TextBox_2.Text = "100"
TextBox_2.TextColor3 = Color3.new(0, 0, 0)
TextBox_2.TextSize = 14

TextButton_32.Parent = Frame_3
TextButton_32.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
TextButton_32.Position = UDim2.new(0, 0, 0.841269851, 0)
TextButton_32.Size = UDim2.new(0, 76, 0, 20)
TextButton_32.Font = Enum.Font.SourceSans
TextButton_32.Text = "Btools"
TextButton_32.TextColor3 = Color3.new(0, 0, 0)
TextButton_32.TextSize = 14
TextButton_32.MouseButton1Click:connect(function()
local a=Instance.new("Tool")a.RequiresHandle=false;a.Name="Delete"local b=game.Players.LocalPlayer;a.Parent=b:WaitForChild("Backpack")local c=b:GetMouse()local d=false;local e=Instance.new("SelectionBox")e.Color3=Color3.new(0,0.6,0.6,6)e.Parent=b.PlayerGui;local c=b:GetMouse()local e=Instance.new("SelectionBox")e.Color3=Color3.new(0,0.6,0.6,6)e.Parent=b.PlayerGui;e.Name="derp"c.Move:connect(function()if d then local f=c.Target;if not f then e.Adornee=nil else if f:IsA("BasePart")then e.Adornee=f else e.Adornee=nil end end end end)a.Equipped:Connect(function()d=true end)a.Unequipped:Connect(function()e.Adornee=nil;d=false end)a.Activated:Connect(function()if e.Adornee then local g=Instance.new("Explosion")g.Parent=game.Workspace;g.Position=e.Adornee.Position;g.BlastPressure=0;local h=Instance.new("Sound")h.SoundId="http://www.roblox.com/asset/?id=315775189"h.Parent=game.Workspace;h:Play()e.Adornee:Destroy()e.Adornee=nil end end)
	
	
end)

Back.Name = "Back"
Back.Parent = Frame_3
Back.BackgroundColor3 = Color3.new(0.721569, 0.721569, 0.721569)
Back.Position = UDim2.new(0.89851898, 0, 0, 0)
Back.Size = UDim2.new(0, 32, 0, 11)
Back.Font = Enum.Font.SourceSans
Back.Text = "->"
Back.TextColor3 = Color3.new(0, 0, 0)
Back.TextSize = 14
Back.MouseButton1Click:connect(function()
Frame_2.Visible = true;
Frame_3.Visible = false;
	
	
end)
TextLabel.Parent = Frame_3
TextLabel.BackgroundColor3 = Color3.new(0.619608, 0.619608, 0.619608)
TextLabel.Position = UDim2.new(0.522151887, 0, 0.777777553, 0)
TextLabel.Size = UDim2.new(0, 151, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Made by Gogo1000"
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.TextSize = 14






local gogo1000 = 0
local LP = game:service('Players').LocalPlayer
local MOUSE = LP:GetMouse()

MOUSE.KeyDown:connect(function(KEY)
 if KEY:lower() == 'q' then
    local LP = game:service('Players').LocalPlayer
local MOUSE = LP:GetMouse()

    gogo1000 = gogo1000 + 1
    _G.FLYING = false

local T = LP.Character.UpperTorso
local CONTROL = {F = 0, B = 0, L = 0, R = 0}
local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
local SPEED = 5



local function FLY()
    _G.FLYING = true
    local BG = Instance.new('BodyGyro', T)
    local BV = Instance.new('BodyVelocity', T)
    BG.P = 9e4
    BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BG.cframe = T.CFrame
    BV.velocity = Vector3.new(0, 0.1, 0)
    BV.maxForce = Vector3.new(9e9, 9e9, 9e9)


    spawn(function()
      repeat wait()
        LP.Character.Humanoid.PlatformStand = true
        if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
          SPEED = 50
        elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
          SPEED = 0
        end
        if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
          BV.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
          lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
        elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
          BV.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
        else
          BV.velocity = Vector3.new(0, 0.1, 0)
        end
        BG.cframe = game.Workspace.CurrentCamera.CoordinateFrame
      until not _G.FLYING
      CONTROL = {F = 0, B = 0, L = 0, R = 0}
      lCONTROL = {F = 0, B = 0, L = 0, R = 0}
      SPEED = 0
      BG:destroy()
      BV:destroy()
      LP.Character.Humanoid.PlatformStand = false
    end)
  end
  
  MOUSE.KeyDown:connect(function(KEY)
    if KEY:lower() == 'w' then
      CONTROL.F = 1
    elseif KEY:lower() == 's' then
      CONTROL.B = -1
    elseif KEY:lower() == 'a' then
      CONTROL.L = -1 
    elseif KEY:lower() == 'd' then 
      CONTROL.R = 1
    end
  end)
  
  MOUSE.KeyUp:connect(function(KEY)
    if KEY:lower() == 'w' then
      CONTROL.F = 0
    elseif KEY:lower() == 's' then
      CONTROL.B = 0
    elseif KEY:lower() == 'a' then
      CONTROL.L = 0
    elseif KEY:lower() == 'd' then
      CONTROL.R = 0
    end
  end)




  FLY()
    
    if gogo1000 == 2 then
    _G.FLYING = false
    gogo1000 = 0
    
    end
    


end
end)