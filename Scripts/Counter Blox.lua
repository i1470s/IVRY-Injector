-- credits novaghoul and orange doggo
-- cb gui created by brokenszies
-- Instances:
local MainGUI = Instance.new("ScreenGui")
local GUI = Instance.new("Frame")
local showoff = Instance.new("TextLabel")
local close = Instance.new("TextButton")
local getitem = Instance.new("TextButton")
local item = Instance.new("TextBox")
local esp = Instance.new("TextButton")
local infammo = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local PRINTiTEMS = Instance.new("TextButton")
local ope = Instance.new("TextButton")
local dellet = Instance.new("TextButton")
--Properties:
MainGUI.Name = "MainGUI"
MainGUI.Parent = game.CoreGui
 
GUI.Name = "GUI"
GUI.Parent = MainGUI
GUI.BackgroundColor3 = Color3.new(0.27451, 0.27451, 0.27451)
GUI.BackgroundTransparency = 0.090000003576279
GUI.BorderColor3 = Color3.new(0.133333, 0.133333, 0.133333)
GUI.BorderSizePixel = 0
GUI.Position = UDim2.new(0.00439238641, 0, 0.291015625, 0)
GUI.Size = UDim2.new(0, 120, 0, 242)
 
showoff.Name = "showoff"
showoff.Parent = GUI
showoff.BackgroundColor3 = Color3.new(0.356863, 0.356863, 0.356863)
showoff.BackgroundTransparency = 0.090000003576279
showoff.BorderSizePixel = 0
showoff.Size = UDim2.new(0, 120, 0, 19)
showoff.Font = Enum.Font.Highway
showoff.Text = "CB Gui"
showoff.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
showoff.TextSize = 14
 
close.Name = "close"
close.Parent = showoff
close.BackgroundColor3 = Color3.new(0.552941, 0.552941, 0.552941)
close.BorderSizePixel = 0
close.Position = UDim2.new(0.849999964, 0, 0, 0)
close.Size = UDim2.new(0, 18, 0, 19)
close.Font = Enum.Font.SourceSans
close.Text = "X"
close.TextColor3 = Color3.new(0, 0, 0)
close.TextSize = 14
 
getitem.Name = "getitem"
getitem.Parent = GUI
getitem.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
getitem.BackgroundTransparency = 0.090000003576279
getitem.BorderColor3 = Color3.new(0, 0, 0)
getitem.BorderSizePixel = 0
getitem.Position = UDim2.new(0.075000003, 0, 0.118749119, 0)
getitem.Size = UDim2.new(0, 102, 0, 27)
getitem.Font = Enum.Font.Highway
getitem.Text = "Get Item"
getitem.TextColor3 = Color3.new(0.196078, 0.196078, 0.294118)
getitem.TextSize = 14
 
item.Name = "item"
item.Parent = GUI
item.BackgroundColor3 = Color3.new(0.694118, 0.694118, 0.694118)
item.Position = UDim2.new(0.075000003, 0, 0.262816936, 0)
item.Size = UDim2.new(0, 102, 0, 34)
item.Font = Enum.Font.Highway
item.Text = "Item Name"
item.TextColor3 = Color3.new(0, 0, 0)
item.TextScaled = true
item.TextSize = 14
item.TextWrapped = true
 
esp.Name = "esp"
esp.Parent = GUI
esp.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
esp.BackgroundTransparency = 0.090000003576279
esp.BorderColor3 = Color3.new(0, 0, 0)
esp.BorderSizePixel = 0
esp.Position = UDim2.new(0.075000003, 0, 0.441413373, 0)
esp.Size = UDim2.new(0, 102, 0, 27)
esp.Font = Enum.Font.Highway
esp.Text = "ESP"
esp.TextColor3 = Color3.new(0.196078, 0.196078, 0.294118)
esp.TextSize = 14
 
infammo.Name = "infammo"
infammo.Parent = GUI
infammo.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
infammo.BackgroundTransparency = 0.090000003576279
infammo.BorderColor3 = Color3.new(0, 0, 0)
infammo.BorderSizePixel = 0
infammo.Position = UDim2.new(0.075000003, 0, 0.59003365, 0)
infammo.Size = UDim2.new(0, 102, 0, 27)
infammo.Font = Enum.Font.Highway
infammo.Text = "Infinite Ammo"
infammo.TextColor3 = Color3.new(0.196078, 0.196078, 0.294118)
infammo.TextSize = 14
 
TextLabel.Parent = GUI
TextLabel.BackgroundColor3 = Color3.new(0.701961, 0.701961, 0.701961)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0, 0, 0.902542353, 0)
TextLabel.Size = UDim2.new(0, 120, 0, 23)
TextLabel.Font = Enum.Font.Bodoni
TextLabel.Text = "Credits to Orange Doggo & Novaghoul"
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
 
PRINTiTEMS.Name = "PRINTiTEMS"
PRINTiTEMS.Parent = GUI
PRINTiTEMS.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
PRINTiTEMS.BackgroundTransparency = 0.090000003576279
PRINTiTEMS.BorderColor3 = Color3.new(0, 0, 0)
PRINTiTEMS.BorderSizePixel = 0
PRINTiTEMS.Position = UDim2.new(0.0666666701, 0, 0.742681026, 0)
PRINTiTEMS.Size = UDim2.new(0, 102, 0, 27)
PRINTiTEMS.Font = Enum.Font.Highway
PRINTiTEMS.Text = "Print Items (F9)"
PRINTiTEMS.TextColor3 = Color3.new(0.196078, 0.196078, 0.294118)
PRINTiTEMS.TextSize = 14
 
ope.Name = "ope"
ope.Parent = MainGUI
ope.BackgroundColor3 = Color3.new(0.27451, 0.27451, 0.27451)
ope.BorderColor3 = Color3.new(0.152941, 0.152941, 0.152941)
ope.BorderSizePixel = 3
ope.Position = UDim2.new(0.00439238641, 0, 0.927734375, 0)
ope.Size = UDim2.new(0, 71, 0, 24)
ope.Font = Enum.Font.SourceSans
ope.Text = "OPEN"
ope.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
ope.TextScaled = true
ope.TextSize = 14
ope.TextWrapped = true
ope.Visible = false
 
dellet.Name = "dellet"
dellet.Parent = ope
dellet.BackgroundColor3 = Color3.new(0.27451, 0.27451, 0.27451)
dellet.BorderColor3 = Color3.new(0.152941, 0.152941, 0.152941)
dellet.BorderSizePixel = 3
dellet.Position = UDim2.new(0, 0, -0.555989563, 0)
dellet.Size = UDim2.new(0, 71, 0, 13)
dellet.Font = Enum.Font.SourceSans
dellet.Text = "DEL GUI"
dellet.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
dellet.TextScaled = true
dellet.TextSize = 14
dellet.TextWrapped = true
-- Scripts:
function prints()
   for i,v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
       print(v)
   end
end
function getitemfunction()
   local remote     = game.ReplicatedStorage.Events.Drop
local FireServer = Instance.new("RemoteEvent").FireServer
 
local weapon = item.Text
 
remote:FireServer(game.ReplicatedStorage.Weapons[weapon], game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 150, 300, false, game.Players.LocalPlayer, game.Workspace.Status.Preparation.Value)
end
function infammofunctton()
   local newcclosure = newcclosure or function(f)
   return f
end
 
local getreg = debug.getregistry or getreg
 
if not getreg or not getrawmetatable then
   warn("Your exploit does not support the functions required for this script")
end
 
local remote = game.ReplicatedStorage.Events.RemoteEvent
local mt = getrawmetatable(game)
local oldmt = mt.__namecall
local sro = make_writeable or setreadonly or changereadonly
sro(getrawmetatable(game),false)
 
if PROTOSMASHER_LOADED then
   local backup = debug.getupvalues
   make_writeable(debug)
 
   getgenv().debug.getupvalues = function(f)
       if typeof(f) == "function" then
           local s, e = pcall(backup, f)
           return (typeof(e) == 'table' and e or {})
       else
           return backup(f + 1)
       end
   end
 
   make_readonly(debug)
end
 
mt.__namecall = function(self,...)
   local args = {...}
   local method = args[#args]
   if self == remote and method:lower() == "fireserver" then
       if args[1] then
           if args[1][1] == "kick" then
               return true
           end
           return args
       end
       return args
   end
   return oldmt(self,...)
end
 
spawn(function()
   while wait() do
       for _,o in pairs(getreg()) do
           if typeof(o) == "function" then
               local ups = debug.getupvalues(o)
               if ups.ammocount then
                   debug.setupvalue(o, 'ammocount', math.huge)
                   debug.setupvalue(o, 'ammocount2', math.huge)
               end
           end
       end
   end
end)
end
function esps()
   local uis = game:GetService("UserInputService")
local sg = game:GetService("StarterGui")
local wp = game:GetService("Workspace")
local cmr = wp.Camera
local rs =  game:GetService("ReplicatedStorage")
local lgt = game:GetService("Lighting")
local plrs = game:GetService("Players")
local lplr = plrs.LocalPlayer
local mouse = lplr:GetMouse()
 
local faces = {"Back","Bottom","Front","Left","Right","Top"}
 
function enableESPCode()
   for _, o in pairs(plrs:GetPlayers()) do
       o.CharacterAdded:Connect(function(characterModel)
           wait(2)
           if tostring(o.Name) ~= tostring(lplr.Name) then
               if tostring(o.Name) == tostring(wp.Status.HasBomb.Value) then
                   local bgui = Instance.new("BillboardGui",o.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = o.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(o.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(o.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(o.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(o.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(o.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               elseif tostring(o.Team) == "Terrorists" then
                   local bgui = Instance.new("BillboardGui",o.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = o.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(o.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(o.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(o.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(o.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(o.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               elseif tostring(o.Team) == "Counter-Terrorists" then
                   local bgui = Instance.new("BillboardGui",o.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = o.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(o.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(o.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(o.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(o.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(o.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               end
           end
       end)
   end
 
   plrs.PlayerAdded:Connect(function(newPlayer)
       newPlayer.CharacterAdded:Connect(function(characterModel)
           wait(2)
           if tostring(newPlayer.Name) ~= tostring(lplr.Name) then
               if newPlayer.Name == tostring(wp.Status.HasBomb.Value) then
                   local bgui = Instance.new("BillboardGui",newPlayer.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = newPlayer.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(newPlayer.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(newPlayer.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(newPlayer.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == newPlayer.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(newPlayer.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(newPlayer.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == newPlayer.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               elseif tostring(newPlayer.Team) == "Terrorists" then
                   local bgui = Instance.new("BillboardGui",newPlayer.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = newPlayer.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(newPlayer.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(newPlayer.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(newPlayer.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == newPlayer.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(newPlayer.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(newPlayer.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == newPlayer.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               elseif tostring(newPlayer.Team) == "Counter-Terrorists" then
                   local bgui = Instance.new("BillboardGui",newPlayer.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = newPlayer.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(newPlayer.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(newPlayer.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(newPlayer.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == newPlayer.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(newPlayer.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(newPlayer.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == newPlayer.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               end
           end
       end)
   end)
 
   wp.ChildAdded:connect(function(p)
       if p.Name == "C4" then
           local bgui = Instance.new("BillboardGui",p)
           bgui.Name = ("EGUI")
           bgui.AlwaysOnTop = true
           bgui.ExtentsOffset = Vector3.new(0,0,0)
           bgui.Size = UDim2.new(1,0,1,0)
           local nam = Instance.new("TextLabel",bgui)
           nam.Text = p.Name
           nam.BackgroundTransparency = 1
           nam.TextSize = 20
           nam.Font = ("Arial")
           nam.TextColor3 = Color3.fromRGB(75, 151, 75)
           nam.Size = UDim2.new(1,0,1,0)
       end
   end)
 
   wp.Debris.ChildAdded:connect(function(p)
       if p.Name == "C4" then
           local bgui = Instance.new("BillboardGui",p)
           bgui.Name = ("EGUI")
           bgui.AlwaysOnTop = true
           bgui.ExtentsOffset = Vector3.new(0,0,0)
           bgui.Size = UDim2.new(1,0,1,0)
           local nam = Instance.new("TextLabel",bgui)
           nam.Text = p.Name .. " fall here"
           nam.BackgroundTransparency = 1
           nam.TextSize = 20
           nam.Font = ("Arial")
           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
           nam.Size = UDim2.new(1,0,1,0)
       end
   end)
 
   wp["Ray_Ignore"].ChildAdded:connect(function(p)
       for _, v in pairs(wp["Ray_Ignore"]:GetChildren()) do
           if tostring(v) == "Smokes" then
               v:Destroy()
           end
       end
   end)
 
   for _, v in pairs(wp["Ray_Ignore"]:GetChildren()) do
       if tostring(v) == "Smokes" then
           v:Destroy()
       end
   end
end
 
enableESPCode()
 
function espFirst()
   for _, o in pairs(plrs:GetPlayers()) do
       if tostring(o.Name) ~= tostring(lplr.Name) then
           if o.Character ~= nil then
               if tostring(o.Name) == tostring(wp.Status.HasBomb.Value) then
                   local bgui = Instance.new("BillboardGui",o.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = o.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(o.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(o.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(o.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(o.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(o.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               elseif tostring(o.Team) == "Terrorists" then
                   local bgui = Instance.new("BillboardGui",o.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = o.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(o.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(o.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(o.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(o.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(o.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               elseif tostring(o.Team) == "Counter-Terrorists" then
                   local bgui = Instance.new("BillboardGui",o.Character.Head)
                   bgui.Name = ("EGUI")
                   bgui.AlwaysOnTop = true
                   bgui.ExtentsOffset = Vector3.new(0,3,0)
                   bgui.Size = UDim2.new(0,200,0,50)
                   local nam = Instance.new("TextLabel",bgui)
                   nam.Text = o.Name
                   nam.BackgroundTransparency = 1
                   nam.TextSize = 14
                   nam.Font = ("Arial")
                   nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                   nam.Size = UDim2.new(0,200,0,50)
                   for _, p in pairs(o.Character:GetChildren()) do
                       if p.Name == ("Head") then 
                           for _, f in pairs(faces) do
                               local m = Instance.new("SurfaceGui",p)
                               m.Name = ("EGUI")
                               m.Face = f
                               m.Active      = true
                               m.AlwaysOnTop = true
                               local mf = Instance.new("Frame",m)
                               mf.Size = UDim2.new(1,0,1,0)
                               mf.BorderSizePixel = 0
                               mf.BackgroundTransparency = 0.5
                               mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
 
                               wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                                   if tostring(wp.Status.HasBomb.Value) == "" then
                                       if tostring(o.Team) == "Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
                                       elseif tostring(o.Team) == "Counter-Terrorists" then
                                           mf.BackgroundColor3 = Color3.fromRGB(13, 105, 172)
                                       end
                                   elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                                       mf.BackgroundColor3 = Color3.fromRGB(245, 205, 48)
                                   end
                               end)
 
                           end
                       end
                   end
 
                   wp.Status.HasBomb:GetPropertyChangedSignal("Value"):connect(function()
                       if tostring(wp.Status.HasBomb.Value) == "" then
                           if tostring(o.Team) == "Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(196, 40, 28)
                           elseif tostring(o.Team) == "Counter-Terrorists" then
                               nam.TextColor3 = Color3.fromRGB(13, 105, 172)
                           end
                       elseif tostring(wp.Status.HasBomb.Value) == o.Name then
                           nam.TextColor3 = Color3.fromRGB(245, 205, 48)
                       end
                   end)
 
               end
           end
       end
   end
end
 
espFirst()
end
function closeok()
   GUI.Visible= false
ope.Visible=true
end
function oppen()
   ope.Visible=false
GUI.Visible = true
end
function delletee()
   game.CoreGui.MainGUI:Remove()
end
 
getitem.MouseButton1Click:connect(getitemfunction)
esp.MouseButton1Click:connect(esps)
PRINTiTEMS.MouseButton1Click:connect(prints)
infammo.MouseButton1Click:connect(infammo)
dellet.MouseButton1Click:connect(delletee)
ope.MouseButton1Click:connect(oppen)
close.MouseButton1Click:connect(closeok)