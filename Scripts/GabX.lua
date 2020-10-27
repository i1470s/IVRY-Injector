--//Settings
	Hub_Name = "GabX"
	Hub_UseLogo = true
	Hub_Logo = "rbxassetid://1808283555"
	Hub_InfoPageText = "made by Darion#8863 (Join https://discord.gg/UJeusq9 and DM Darion##8863 if a script is patched, outdated or if you notice a bug) | none of these scripts were made by me | Chebureki#5214 Gave permission to use his GUI ;)"
 
 
categories = {
			  ["Games"]= {
							{"NRPG Fast Shoot",game:HttpGet(('https://pastebin.com/raw/zXCvQxRF'),true)},
							{"The Streets GUI",game:HttpGet(('https://pastebin.com/raw/xZyABVJ1'),true)},
							{"Jailbreak AFK Rob",game:HttpGet(('https://pastebin.com/raw/hhRca3cj'),true)},
							{"Jailbreak GUI",game:HttpGet(('https://pastebin.com/raw/CQFw06tN'),true)},
							{"Lumber Tycoon",game:HttpGet(('https://pastebin.com/raw/33kYAahS'),true)},
							{"PhantomForces",game:HttpGet(('https://pastebin.com/raw/LgQEjvxS'),true)},
							{"RBXF'er(ALotGames)",game:HttpGet(('https://pastebin.com/raw/sqUBUF20'),true)},
							{"Hilton Hotels",game:HttpGet(('https://pastebin.com/raw/QfHywxaZ'),true)},
							{"WorkAtAPizzaPlace",game:HttpGet(('https://pastebin.com/raw/KyfBZCKL'),true)},
							{"Prison Royale",game:HttpGet(('https://pastebin.com/raw/0W4QBB5C'),true)},
							{"Plus Ultra(MustBeVillain)",game:HttpGet(('https://pastebin.com/raw/iCSKEnHH'),true)},
							{"More to come!",'print"A lot more to come! SOON MY BROTHER"'}
 						 },
 
  			  ["GUI's"]= {	
							{"Topk3k",game:HttpGet(('https://pastebin.com/raw/bEmmF8UH'),true)},
							{"Arosia",game:HttpGet(('https://pastebin.com/raw/Nwit6ZqP'),true)},
							{"Equinox",game:HttpGet(('https://pastebin.com/raw/scYFbHQb'),true)},
							{"Ani's (R15)",game:HttpGet(('https://pastebin.com/raw/MenK10Ak'),true)},
							{"Ani's (R6)",game:HttpGet(('https://pastebin.com/raw/Ydt76Kep'),true)},
							{"Rose Hub 3.0.0",game:HttpGet(('https://pastebin.com/raw/1BJj0fB4'),true)},
							{"OPFinality",game:HttpGet(('https://pastebin.com/raw/fG5b1zrM'),true)},
							{"OPHub",game:HttpGet(('https://pastebin.com/raw/chSCgKAJ'),true)},
							{"HyperTotal",game:HttpGet(('https://pastebin.com/raw/aYdepQa0'),true)},
							{"Clown Van",game:HttpGet(('https://pastebin.com/raw/GaNQibJ5'),true)},
							{"Legacy Hub (OP)",game:HttpGet(('https://pastebin.com/raw/dfCF4ib6'),true)},
							{"More to come!",'print"MORE TO COME MY FELLOW NOOB BROTHERS YESA!!!!!a"'}
						 },
 
			["Scripts"]= {
							{"R2S (Remote Spy)",game:HttpGet(('https://pastebin.com/raw/ZAHTikfe'),true)},
							{"Fly",game:HttpGet(('https://pastebin.com/raw/5f9Y0qHr'),true)},
							{"Friend req spam",game:HttpGet(('https://pastebin.com/cG0wRUgH'),true)},
							{"Noclip (press e)",game:HttpGet(('https://pastebin.com/raw/a8c8miri'),true)},
							{"More to come!",'print"A lot more to come! SOON MY FRIENDLY BROTHERS"'}
						}
			 }
 
 
local ScreenGui = Instance.new("ScreenGui")
local Header = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local Body = Instance.new("Frame")
local bar = Instance.new("ScrollingFrame")
local TextButton = Instance.new("TextButton")
local InfoPage = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local Logo = Instance.new("ImageLabel")
 
 
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
 
Header.Name = "Header"
Header.Parent = ScreenGui
Header.Active = true
Header.BackgroundColor3 = Color3.new(0, 0, 0)
Header.BorderSizePixel = 0
Header.Draggable = true
Header.Position = UDim2.new(0.279503107, 0, 0.382530123, 0)
Header.Size = UDim2.new(0, 438, 0, 34)
 
Title.Name = "Title"
Title.Parent = Header
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.332191795, 0, 0, 0)
Title.Size = UDim2.new(0, 147, 0, 34)
Title.Font = Enum.Font.SourceSansLight
Title.Text = Hub_Name
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 21
Title.TextWrapped = true
 
Close.Name = "Close"
Close.Parent = Header
Close.BackgroundColor3 = Color3.new(1, 1, 1)
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(0.928571403, 0, 0, 0)
Close.Size = UDim2.new(0, 27, 0, 22)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 19
 
Minimize.Name = "Minimize"
Minimize.Parent = Header
Minimize.BackgroundColor3 = Color3.new(1, 1, 1)
Minimize.BackgroundTransparency = 1
Minimize.Position = UDim2.new(0.857142806, 0, 0, 0)
Minimize.Size = UDim2.new(0, 27, 0, 22)
Minimize.Font = Enum.Font.SourceSans
Minimize.Text = "_"
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.TextSize = 19
 
Body.Name = "Body"
Body.Parent = Header
Body.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
Body.BackgroundTransparency = 0.10000000149012
Body.BorderSizePixel = 0
Body.ClipsDescendants = true
Body.Position = UDim2.new(0, 0, 1, 0)
Body.Size = UDim2.new(0, 438, 0, 203)
 
bar.Name = "bar"
bar.Parent = Body
bar.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
bar.BackgroundTransparency = 0.89999997615814
bar.Size = UDim2.new(0, 115, 0, 203)
bar.BottomImage = ""
bar.CanvasSize = UDim2.new(0, 0, 1.20000005, 0)
bar.ScrollBarThickness = 6
bar.TopImage = ""
 
TextButton.Parent = bar
TextButton.BackgroundColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.108999997, 0, 0.0199999996, 0)
TextButton.Size = UDim2.new(0, 90, 0, 31)
TextButton.Visible = false
TextButton.Font = Enum.Font.SourceSans
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.TextSize = 14
 
InfoPage.Name = "InfoPage"
InfoPage.Parent = Body
InfoPage.BackgroundColor3 = Color3.new(1, 1, 1)
InfoPage.BackgroundTransparency = 1
InfoPage.BorderSizePixel = 0
InfoPage.Position = UDim2.new(0.262557089, 0, 0, 0)
InfoPage.Size = UDim2.new(0, 323, 0, 203)
 
TextLabel.Parent = InfoPage
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.0340557247, 0, 0.0886699483, 0)
TextLabel.Size = UDim2.new(0, 298, 0, 151)
TextLabel.Font = Enum.Font.SourceSansLight
TextLabel.Text = Hub_InfoPageText
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextScaled = true
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
 
TextButton_2.Parent = ScreenGui
TextButton_2.BackgroundColor3 = Color3.new(0, 0, 0)
TextButton_2.BorderSizePixel = 0
TextButton_2.Position = UDim2.new(0.0309597515, 0, 0.0443349741, 0)
TextButton_2.Size = UDim2.new(0, 91, 0, 31)
TextButton_2.Visible = false
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.TextColor3 = Color3.new(1, 1, 1)
TextButton_2.TextSize = 14
 
Logo.Parent = Header
Logo.BackgroundColor3 = Color3.new(1, 1, 1)
Logo.BackgroundTransparency = 1
Logo.BorderSizePixel = 0
Logo.Position = UDim2.new(0.0182648413, 0, 0, 0)
Logo.Size = UDim2.new(0, 34, 0, 34)
Logo.Image = Hub_Logo
 
if not Hub_UseLogo then
	Logo.Visible = false
end
 
 
offset = 0.02
for i,v in pairs(categories)do
 
	local button = TextButton:Clone()
	button.Parent = bar
	button.Position = UDim2.new(0.109, 0,offset, 0)
	button.Visible = true
	button.Text = i
	offset = offset + 0.16
 
	local page = Instance.new("Frame")
	page.Parent = Body
	page.Position = UDim2.new(0.263, 0,0, 0)
	page.Size = UDim2.new(0, 323,0, 203)
	page.BackgroundTransparency = 1
	page.Name = "Page"..i
	page.Visible = false
 
	local xoffset = 0.031
	local yoffset = 0.044
 
	for i,content in pairs(v)do
		local scriptbutton = TextButton:Clone()
		scriptbutton.Parent = page
		scriptbutton.Visible = true
		scriptbutton.Text = content[1]
		scriptbutton.Position = UDim2.new(xoffset,0,yoffset,0)
		xoffset = xoffset + 0.325
		if i%3 == 0 then
			xoffset	= 0.031
			yoffset = yoffset + 0.206
		end
 
		if i == 12 then
			break
		end
 
		scriptbutton.MouseButton1Click:Connect(function()
			if type(content[2]) == "function" then
				content[2]()
			end
			if type(content[2]) == "string" then
				loadstring(content[2])()
			end
		end)
	end
 
	button.MouseButton1Click:Connect(function()
		for _,pages in pairs(Body:GetChildren())do
			if pages ~= page and pages.Name ~= "bar" then
				pages.Visible = false
			end
 
			if pages == page then
				pages.Visible = true
			end
		end
	end)
 
 
end
 
local minimized = false
 
Minimize.MouseButton1Click:Connect(function()
	if not minimized then
		Body:TweenSize(UDim2.new(0, 438,0, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2)
		minimized = true
	else
		Body:TweenSize(UDim2.new(0, 438,0, 203),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2)
		minimized = false
	end
end)
 
Close.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)