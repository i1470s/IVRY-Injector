--[[
Made by Nev Zandra
--]]
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("ImageLabel")
local ClickTP = Instance.new("TextButton")
local CloseB = Instance.new("TextButton")
local INFJUMP = Instance.new("TextButton")
local OpenB = Instance.new("TextButton")
 
--Properties:
 
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
 
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Position = UDim2.new(0.427115172, 0, 0.298597217, 0)
MainFrame.Size = UDim2.new(0, 219, 0, 201)
MainFrame.Visible = false
MainFrame.Image = "http://www.roblox.com/asset/?id=4695436661"
 
ClickTP.Name = "ClickTP"
ClickTP.Parent = MainFrame
ClickTP.BackgroundColor3 = Color3.fromRGB(85, 0, 255)
ClickTP.Position = UDim2.new(0.14611873, 0, 0.761193991, 0)
ClickTP.Size = UDim2.new(0, 154, 0, 40)
ClickTP.Font = Enum.Font.SciFi
ClickTP.Text = "Ctrl Click TP"
ClickTP.TextColor3 = Color3.fromRGB(255, 0, 0)
ClickTP.TextScaled = true
ClickTP.TextSize = 14.000
ClickTP.TextWrapped = true
ClickTP.MouseButton1Down:connect(function()
local Imput = game:GetService("UserInputService")
local Plr = game.Players.LocalPlayer
local Mouse = Plr:GetMouse()
 
function To(position)
   local Chr = Plr.Character
   if Chr ~= nil then
       Chr:MoveTo(position)
   end
end
 
Imput.InputBegan:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 and Imput:IsKeyDown(Enum.KeyCode.LeftControl) then
       To(Mouse.Hit.p)
   end
end)
end)
 
CloseB.Name = "CloseB"
CloseB.Parent = MainFrame
CloseB.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseB.Position = UDim2.new(0.849315047, 0, 0, 0)
CloseB.Size = UDim2.new(0, 33, 0, 27)
CloseB.Font = Enum.Font.SourceSans
CloseB.Text = "X"
CloseB.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseB.TextScaled = true
CloseB.TextSize = 14.000
CloseB.TextWrapped = true
CloseB.MouseButton1Down:connect(function()
OpenB.Visible = true
MainFrame.Visible = false
end)
 
INFJUMP.Name = "INFJUMP"
INFJUMP.Parent = MainFrame
INFJUMP.BackgroundColor3 = Color3.fromRGB(85, 0, 255)
INFJUMP.Position = UDim2.new(0.146118715, 0, 0.527363181, 0)
INFJUMP.Size = UDim2.new(0, 154, 0, 40)
INFJUMP.Font = Enum.Font.SciFi
INFJUMP.Text = "Inf. Jump"
INFJUMP.TextColor3 = Color3.fromRGB(255, 0, 0)
INFJUMP.TextScaled = true
INFJUMP.TextSize = 14.000
INFJUMP.TextWrapped = true
INFJUMP.MouseButton1Down:connect(function()
local Player = game:GetService'Players'.LocalPlayer;
local UIS = game:GetService'UserInputService';
 
_G.JumpHeight = 50;
 
function Action(Object, Function) if Object ~= nil then Function(Object); end end
 
UIS.InputBegan:connect(function(UserInput)
    if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
        Action(Player.Character.Humanoid, function(self)
            if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                Action(self.Parent.HumanoidRootPart, function(self)
                    self.Velocity = Vector3.new(0, _G.JumpHeight, 0);
                end)
            end
        end)
    end
end)
end)
 
OpenB.Name = "OpenB"
OpenB.Parent = ScreenGui
OpenB.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
OpenB.Position = UDim2.new(0.436289489, 0, 0.905811608, 0)
OpenB.Size = UDim2.new(0, 200, 0, 40)
OpenB.Font = Enum.Font.SciFi
OpenB.Text = "Open"
OpenB.TextColor3 = Color3.fromRGB(85, 0, 255)
OpenB.TextScaled = true
OpenB.TextSize = 14.000
OpenB.TextStrokeColor3 = Color3.fromRGB(85, 0, 255)
OpenB.TextWrapped = true
OpenB.MouseButton1Down:connect(function()
MainFrame.Visible = true
OpenB.Visible = false
end)
 
-- Scripts:
 
local function WSHX_fake_script() -- MainFrame.LocalScript 
    local script = Instance.new('LocalScript', MainFrame)
 
    script.parent.Selectable = true
    script.Parent.Active = true
    script.parent.Draggable = true
end
coroutine.wrap(WSHX_fake_script)()
local function OOTW_fake_script() -- ScreenGui.LocalScript 
    local script = Instance.new('LocalScript', ScreenGui)
 
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title    = "NevZGUI V2",
    Text     = "Created By Nev Zandra",
    text2    = "Gui Created By Nev Zandra",
    Duration = 10,
    })
end
coroutine.wrap(OOTW_fake_script)()