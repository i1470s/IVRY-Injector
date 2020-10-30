local library = loadstring(game:HttpGet("https://pastebin.com/raw/HYcfs6KC", true))()
local player = game.Players.LocalPlayer

local afarm = library:CreateWindow(" Useful Stuff ")
afarm:Section("- cool -")
afarm:Toggle("TP Zombies", {flag = "tpz"})
afarm:Section("Noclip toggle = N")

local cock = afarm:Button("Gun Mods", function()
            local gun = player.Backpack:FindFirstChild("Weapon1")
            local pogs = require(gun)
            pogs["MagSize"] = math.huge
            pogs["StoredAmmo"] = math.huge
            pogs["MaxAmmo"] = math.huge
            pogs["FireTime"] = 0
            pogs["Semi"] = false
            pogs["MoveSpeed"] = 1
            pogs["GunKick"] = 0
            pogs["Damage"] = {Max = 2000, Min = 2000}
            pogs["Spread"] = {Min = 0, Max = 0}
            pogs["ViewKick"] = { Pitch = { Min = 0, Max = 0}, Yaw = { Min = 0, Max = 0}}

            local gun = player.Backpack:FindFirstChild("Weapon2")
            local pogs = require(gun)
            pogs["MagSize"] = math.huge
            pogs["StoredAmmo"] = math.huge
            pogs["MaxAmmo"] = math.huge
            pogs["FireTime"] = 0
            pogs["Semi"] = false
            pogs["MoveSpeed"] = 1
            pogs["GunKick"] = 0
            pogs["Damage"] = {Max = 2000, Min = 2000}
            pogs["Spread"] = {Min = 0, Max = 0}
            pogs["ViewKick"] = { Pitch = { Min = 0, Max = 0}, Yaw = { Min = 0, Max = 0}}
    end)

spawn(function()
    while wait() do
        pcall(function()
        if afarm.flags.tpz then
            for i,v in pairs(game:GetService("Workspace").Baddies:GetChildren()) do
                if v.Name == "Zombie" then
                    v.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(-5,0,0)
                end
            end
        end
    end)
end
end)

local b = afarm:Slider("JumpPower", {
    min = 16,
    max = 100
}, function(v)
    player.Character.Humanoid.JumpPower = v
end)
local z = afarm:Slider("WalkSpeed", {
    min = 16,
    max = 100
}, function(v)
    player.Character.Humanoid.WalkSpeed = v
end)

local noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
local mouse = player:GetMouse()
mouse.KeyDown:connect(function(key)

if key == "n" then
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)