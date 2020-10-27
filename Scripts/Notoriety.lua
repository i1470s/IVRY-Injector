--Decompiled using SirHurt V2 (www.asshurthosting.pw)
 
local player = game.Players.LocalPlayer
local UI = script.Parent
local playerGui = player.PlayerGui
local SFX = playerGui:WaitForChild("SFX")
local menuMain = UI:WaitForChild("frame_mainMenu")
local playerScripts = player:WaitForChild("PlayerScripts")
local cameraRun = require(playerScripts:WaitForChild("CameraRun"))
local Data = require(playerScripts:WaitForChild("LocalStatsModule"))
local RomanNumerals = require(playerScripts:WaitForChild("ToRomanNumerals"))
local chat = UI:WaitForChild("frame_chat")
local infoStats = UI:WaitForChild("frame_infoStats")
local musicPlayer = require(playerGui:WaitForChild("MusicPlayer"))
local heistInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("HeistInfo"))
local msgBox = UI:WaitForChild("frame_messageBox")
local canChat = false
musicPlayer:PlayTrack("MainTheme")
local timer = tick()
local function printTimeTaken(loadName)
    print("Loaded " .. loadName .. " in: " .. tostring(tick() - timer) .. " seconds")
end
difficultycolors = {
    Normal = Color3.new(0, 0.6666666666666666, 1),
    Hard = Color3.new(0, 1, 0.4980392156862745),
    ["Very Hard"] = Color3.new(1, 1, 0.4980392156862745),
    Extreme = Color3.new(1, 0.6666666666666666, 0),
    Anarchy = Color3.new(0.6666666666666666, 0, 0),
    Nightmare = Color3.new(0.6666666666666666, 0.3333333333333333, 1)
}
quality_colors = {
    Common = Color3.new(0.39215686274509803, 0.39215686274509803, 0.39215686274509803),
    Uncommon = Color3.new(0, 0.807843137254902, 0),
    Rare = Color3.new(0, 0.6666666666666666, 1),
    Epic = Color3.new(1, 0.22745098039215686, 0.3411764705882353),
    Infamous = Color3.new(0.6666666666666666, 0.3333333333333333, 1)
}
function convertToCommas(number)
    local decimals = tostring(number):match("%.%d*")
    local negative = number < 0
    number = math.abs(number)
    if decimals then
        number = math.floor(number)
    end
    number = tostring(number)
    local rev = number:reverse()
    local maxmatches = number:len() / 3
    local matches = 0
    local newstring, matchnum = string.gsub(rev, "%d%d%d", function(s)
        matches = matches + 1
        if s ~= rev and matches ~= maxmatches then
            return s .. ","
        else
            return s
        end
    end)
    local finalString = newstring:reverse()
    if decimals then
        finalString = finalString .. decimals
    end
    if negative then
        finalString = "-" .. finalString
    end
    return finalString
end
function bindChat(topFrame)
    local chatFinder = topFrame:FindFirstChild(chat.Name)
    local statsFinder = topFrame:FindFirstChild(infoStats.Name)
    if chatFinder and canChat then
        chat.Position = chatFinder.Position
        chat.Visible = true
    else
        chat.Visible = false
    end
    if statsFinder then
        infoStats.Position = statsFinder.Position
        infoStats.Visible = true
    else
        infoStats.Visible = false
    end
end
fadeTransition = player.PlayerGui.UI.frame_transitionFade
function doTransition()
    fadeTransition.Visible = true
    for i = 0, 1, 0.1 do
        fadeTransition.BackgroundTransparency = i
        wait(0.02)
    end
    fadeTransition.Visible = false
end
menuMain:GetPropertyChangedSignal("Visible"):connect(function()
    if menuMain.Visible then
        bindChat(menuMain)
    end
    doTransition()
end)
do
    local reward = msgBox:WaitForChild("frame_dailyReward")
    local view = reward:WaitForChild("img_rewardImage")
    local con
    game:GetService("ReplicatedStorage"):WaitForChild("SendBonusCards").OnClientEvent:connect(function(number, total, safeType)
        repeat
            wait()
        until Data.Inventory and Data.Inventory.OwnedSafes
        Data.Inventory.OwnedSafes[safeType] = total
        local mySafe = game:GetService("ReplicatedStorage"):WaitForChild("Safes"):FindFirstChild(safeType)
        if mySafe then
            do
                local safe = mySafe:clone()
                safe.Parent = view
                local cam = Instance.new("Camera")
                cam.CFrame = CFrame.new(safe.PrimaryPart.CFrame.p + Vector3.new(0, 2, 0) + safe.PrimaryPart.CFrame.lookVector * 8, safe.PrimaryPart.CFrame.p + Vector3.new(0, 2, 0))
                cam.Parent = view
                view.CurrentCamera = cam
                local angle = 0
                con = game:GetService("RunService").RenderStepped:connect(function()
                    angle = angle + 1
                    if angle >= 360 then
                        angle = angle - 360
                    end
                    safe:SetPrimaryPartCFrame(CFrame.new(safe.PrimaryPart.Position) * CFrame.Angles(0, math.rad(angle), 0))
                end)
            end
        end
        reward.text_rewardLabel.Text = convertToCommas(number) .. " " .. safeType .. (number == 1 and "" or "s")
        reward.Visible = true
        msgBox.Visible = true
    end)
    reward:WaitForChild("button_rewardAccept").MouseButton1Click:connect(function()
        local canClose = true
        for _, v in pairs(msgBox:GetChildren()) do
            if v.Visible and v ~= reward then
                canClose = false
            end
        end
        reward.Visible = false
        if canClose then
            msgBox.Visible = false
        end
        SFX.ChaChing:Play()
        if con then
            con:Disconnect()
        end
    end)
    printTimeTaken("Bonus Safes")
end
do
    local playerCount = UI:WaitForChild("text_playerCount")
    local version = UI:WaitForChild("text_version")
    version:WaitForChild("versionNumber").Text = workspace:WaitForChild("Version").Value
    playerCount:WaitForChild("playerCount").Text = game.Players.NumPlayers
    spawn(function()
        while true do
            wait(1)
            playerCount:WaitForChild("playerCount").Text = game.Players.NumPlayers
        end
    end)
    printTimeTaken("Players Online/Version")
end
do
    local getNeededXp = function(lvl)
        return lvl * 1025 + lvl ^ 1.3
    end
    repeat
        wait()
    until Data.Inventory.Cash
    local infoExp = infoStats:WaitForChild("frame_infoExp")
    local progressBar = infoExp:WaitForChild("frame_progressBar")
    local infoLevel = infoExp:WaitForChild("text_infoLevel")
    local infoProgressAmt = infoExp:WaitForChild("text_progressAmount")
    local infoCash = infoStats:WaitForChild("text_infoCash"):WaitForChild("text_cashAmount")
    local infoSkillPoints = infoStats:WaitForChild("text_infoSkillPoints"):WaitForChild("text_infoSkillAmount")
    local infoPlayerName = infoStats:WaitForChild("text_playerName")
    local storeCash = UI:WaitForChild("frame_Store"):WaitForChild("frame_container"):WaitForChild("frame_titleBar"):WaitForChild("text_playerCash")
    infoPlayerName.Text = player.Name
    local function updateStats()
        infoCash.Text = "$" .. convertToCommas(math.floor(Data.Inventory.Cash))
        infoSkillPoints.Text = convertToCommas(Data.Inventory.Skill)
        infoProgressAmt.Text = convertToCommas(Data.Inventory.XP) .. "/" .. convertToCommas(math.ceil(getNeededXp(Data.Inventory.Level)))
        infoLevel.Text = "Rank: " .. (#Data.Inventory.Infamy > 0 and RomanNumerals(#Data.Inventory.Infamy) .. "-" or "") .. tostring(Data.Inventory.Level)
        progressBar.Size = UDim2.new(Data.Inventory.XP / getNeededXp(Data.Inventory.Level), 0, 1, 0)
        storeCash.Text = "Cash: $" .. convertToCommas(Data.Inventory.Cash)
    end
    playerGui:WaitForChild("StatsChange").Event:connect(updateStats)
    updateStats()
    printTimeTaken("Stats")
end
do
    local ChatFrame = chat:WaitForChild("ChatFrame")
    local colors = {
        "Deep orange",
        "Toothpaste",
        "Lime green",
        "Hot pink",
        "Cyan"
    }
    local nameColor = BrickColor.new(colors[math.random(1, #colors)]).Color
    local messageColor = BrickColor.new("Institutional white").Color
    local messageBox = chat:WaitForChild("Type")
    local UIS = game:GetService("UserInputService")
    local event = game:GetService("ReplicatedStorage"):WaitForChild("Chatted")
    local ChatService = game:GetService("Chat")
    local lastMsg = tick()
    local spamCount = 0
    local elite = player:IsInGroup(2710476)
    if player.Name == "HeadlessCanadian" then
        nameColor = BrickColor.new("Gold").Color
    elseif player.Name == "Brick_man" then
        nameColor = BrickColor.new("Gold").Color
    end
    local function onInput(Input, GPE)
        if GPE then
            return
        end
        if Input.KeyCode == Enum.KeyCode.Slash then
            messageBox:CaptureFocus()
        end
    end
    function onFocus()
        if messageBox.Text == "Press '/' to type a message..." or messageBox.Text == "/" then
            messageBox.Text = ""
        end
    end
    local spamCountdownActive = false
    local offenses = 0
    function onFocusLost(EnterPressed)
        if EnterPressed then
            if messageBox.Text ~= "" and messageBox.Text:len() < 200 then
                local isSpam = false
                if tick() - lastMsg < 5 then
                    spamCount = spamCount + 1
                    if spamCount >= 5 or spamCountdownActive then
                        isSpam = true
                    end
                else
                    lastMsg = tick()
                    spamCount = 0
                end
                if not isSpam and not spamCountdownActive then
                    event:FireServer(nameColor, messageBox.Text, messageColor, elite)
                elseif not spamCountdownActive then
                    spamCountdownActive = true
                    offenses = offenses + 1
                    for i = 20 + (offenses - 1) * 10, 1, -1 do
                        messageBox.Text = "Please stop spamming the chat, please wait " .. i .. " second" .. (i > 1 and "s" or "") .. " before typing again..."
                        wait(1)
                    end
                    spamCountdownActive = false
                end
                messageBox.Text = "Press '/' to type a message..."
            else
                messageBox.Text = "Press '/' to type a message..."
            end
        elseif messageBox.Text == "" then
            messageBox.Text = "Press '/' to type a message..."
        end
    end
    local function addLine(message, Label)
        local newMessage = Instance.new("Frame")
        newMessage.Size = UDim2.new(1, -10, 0, 20)
        newMessage.Position = UDim2.new(0, 5, 1, -25)
        newMessage.BackgroundTransparency = 1
        newMessage.ClipsDescendants = true
        newMessage.ZIndex = 5
        newMessage.Parent = ChatFrame
        local lineMessage = ""
        while Label.TextFits == false do
            lineMessage = string.sub(message, -1) .. lineMessage
            message = string.sub(message, 1, string.len(message) - 1)
            Label.Text = message
        end
        for _, oldMessage in pairs(ChatFrame:GetChildren()) do
            if oldMessage ~= newMessage then
                oldMessage.Position = oldMessage.Position + UDim2.new(0, 0, 0, -newMessage.AbsoluteSize.Y + 5)
            end
        end
        local messageLabel = Instance.new("TextLabel")
        messageLabel.AutoLocalize = false
        messageLabel.Parent = newMessage
        messageLabel.BackgroundTransparency = 1
        messageLabel.Font = "SourceSansBold"
        messageLabel.TextColor3 = messageColor
        messageLabel.FontSize = "Size18"
        messageLabel.TextXAlignment = "Left"
        messageLabel.Text = lineMessage
        messageLabel.Size = UDim2.new(1, -10, 0, 20)
        messageLabel.TextStrokeTransparency = 0.6
        messageLabel.Position = UDim2.new(0, 5, 0, 0)
        messageLabel.ZIndex = 5
        local LineTag = Instance.new("StringValue", messageLabel.Parent)
        LineTag.Name = "LineTag"
        local LineTag2 = Instance.new("StringValue", Label.Parent)
        LineTag2.Name = "LineTag"
        if messageLabel.TextFits ~= true then
            addLine(lineMessage, messageLabel)
        else
            for _, oldMessage in pairs(ChatFrame:GetChildren()) do
                if not oldMessage:FindFirstChild("LineTag") then
                    oldMessage.Position = oldMessage.Position + UDim2.new(0, 0, 0, -newMessage.AbsoluteSize.Y + 5)
                end
            end
        end
        LineTag:Destroy()
        LineTag2:Destroy()
    end
    local function onEvent(sender, nameColor, levelString, message, messageColor, titleInfo)
        local shouldShow = game:GetService("ReplicatedStorage"):WaitForChild("CanSeeChat"):InvokeServer(sender)
        if shouldShow then
            local newMessage = Instance.new("Frame")
            newMessage.Size = UDim2.new(1, -10, 0, 20)
            newMessage.Position = UDim2.new(0, 5, 1, -25)
            newMessage.BackgroundTransparency = 1
            newMessage.ClipsDescendants = true
            newMessage.ZIndex = 5
            newMessage.Parent = ChatFrame
            local nameLabel = Instance.new("TextLabel", newMessage)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Font = "SourceSansBold"
            nameLabel.FontSize = "Size18"
            nameLabel.TextXAlignment = "Left"
            nameLabel.ZIndex = 5
            if titleInfo then
                nameLabel.Text = "[" .. (titleInfo[1] or "error") .. "] " .. levelString .. sender.Name .. ":"
                nameLabel.TextColor3 = titleInfo[2] or Color3.new()
                if titleInfo[3] then
                    nameLabel.TextStrokeTransparency = 0
                    nameLabel.TextStrokeColor3 = titleInfo[3]
                end
            else
                nameLabel.Text = levelString .. sender.Name .. ":"
                nameLabel.TextColor3 = nameColor
            end
            nameLabel.Size = UDim2.new(0, nameLabel.TextBounds.X + 5, 0, 20)
            nameLabel.TextStrokeTransparency = 0.6
            local messageLabel = Instance.new("TextLabel")
            messageLabel.AutoLocalize = false
            messageLabel.Parent = newMessage
            messageLabel.BackgroundTransparency = 1
            messageLabel.Font = "SourceSansBold"
            messageLabel.TextColor3 = messageColor
            messageLabel.FontSize = "Size18"
            messageLabel.TextXAlignment = "Left"
            messageLabel.Text = message
            messageLabel.Size = UDim2.new(1, -nameLabel.AbsoluteSize.X, 0, 20)
            messageLabel.Position = nameLabel.Position + UDim2.new(0, nameLabel.AbsoluteSize.X, 0, 0)
            messageLabel.TextStrokeTransparency = 0.6
            messageLabel.ZIndex = 5
            if messageLabel.TextFits ~= true then
                addLine(message, messageLabel)
            else
                for _, oldMessage in pairs(ChatFrame:GetChildren()) do
                    if oldMessage ~= newMessage then
                        oldMessage.Position = oldMessage.Position + UDim2.new(0, 0, 0, -newMessage.AbsoluteSize.Y + 5)
                        if oldMessage.AbsolutePosition.Y < ChatFrame.AbsolutePosition.Y then
                            oldMessage:Destroy()
                        end
                    end
                end
            end
        end
    end
    spawn(function()
        for _, v in pairs(chat:GetChildren()) do
            v.Visible = false
        end
        local success, message = pcall(function()
            canChat = ChatService:CanUserChatAsync(player.UserId)
        end)
        if not success or not canChat then
            for _, v in pairs(chat:GetChildren()) do
                v.Visible = false
            end
        else
            for _, v in pairs(chat:GetChildren()) do
                v.Visible = true
            end
        end
    end)
    UIS.InputBegan:connect(onInput)
    event.OnClientEvent:connect(onEvent)
    messageBox.Focused:connect(onFocus)
    messageBox.FocusLost:connect(onFocusLost)
    printTimeTaken("Chat")
end
do
    local adSystem = menuMain:WaitForChild("frame_adSystem")
    local adPlay = adSystem:WaitForChild("button_adPlay")
    local adPurchaseButton = adSystem:WaitForChild("button_adPurchase")
    local gameImg = adSystem:WaitForChild("gameImg")
    local gameTitle = adSystem:WaitForChild("gameTitle")
    local adPurchase = menuMain:WaitForChild("frame_adPurchase")
    local adPurchaseConfirmation = adPurchase:WaitForChild("adPurchaseConfirmation")
    local adPurchaseDesc = adPurchase:WaitForChild("adPurchaseDesc")
    local adPurchaseOptions = adPurchase:WaitForChild("adPurchaseOptions")
    local adPurchaseReview = adPurchase:WaitForChild("adPurchaseReview")
    local urlEntry = adPurchaseDesc:WaitForChild("urlEntry")
    local acceptAdVisit = msgBox:WaitForChild("frame_joinPlaceConfirmation")
    spawn(function()
        local adList
        local currentAdID = 0
        local adShown = 1
        adSystem.Visible = false
        repeat
            wait()
            adList = game:GetService("ReplicatedStorage"):WaitForChild("GetAds"):InvokeServer()
        until adList ~= nil
        game:GetService("ReplicatedStorage"):WaitForChild("UpdateAds").OnClientEvent:connect(function(list)
            adList = list
        end)
        local function showNewAd()
            if #adList == 0 then
                print("Ad bug avoided")
                return
            end
            local ID = adList[math.random(1, #adList)]
            local info = game:GetService("MarketplaceService"):GetProductInfo(ID)
            local isGame = info.AssetTypeId == 9
            local itemName = info.Name
            local creatorName = info.Creator.Name
            currentAdID = ID
            gameTitle.Text = itemName .. " by " .. creatorName
            gameImg.Image = "http://www.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid=" .. ID .. "&fmt=png&wd=420&ht=420"
        end
        adPlay.MouseButton1Click:connect(function()
            if currentAdID ~= 0 then
                acceptAdVisit.Visible = true
                msgBox.Visible = true
            end
        end)
        acceptAdVisit:WaitForChild("button_decline").MouseButton1Click:connect(function()
            local canClose = true
            for _, v in pairs(msgBox:GetChildren()) do
                if v.Visible and v ~= acceptAdVisit then
                    canClose = false
                end
            end
            acceptAdVisit.Visible = false
            if canClose then
                msgBox.Visible = false
            end
        end)
        acceptAdVisit:WaitForChild("button_confirm").MouseButton1Click:connect(function()
            game:GetService("TeleportService"):Teleport(currentAdID, game.Players.LocalPlayer)
            acceptAdVisit:WaitForChild("button_confirm").Visible = false
            delay(30, function()
                acceptAdVisit:WaitForChild("button_confirm").Visible = true
            end)
        end)
        adPurchaseButton.MouseButton1Click:connect(function()
            adPurchase.Visible = true
            adPurchaseReview.Visible = false
            adPurchaseOptions.Visible = false
            adPurchaseDesc.Visible = true
        end)
        showNewAd()
        adSystem.Visible = true
        menuMain:GetPropertyChangedSignal("Visible"):connect(function()
            if menuMain.Visible then
                adShown = adShown + 1
                if adShown >= 2 then
                    adShown = 0
                    showNewAd()
                end
            end
        end)
    end)
    local currentGameID = 0
    local purchasedID = 0
    local paymentId = 0
    local function glowURL(Color, reset)
        urlEntry.TextColor3 = Color
        delay(2, function()
            urlEntry.TextColor3 = Color3.new(0, 1, 1)
            if reset and urlEntry.Text == "Invalid URL" then
                urlEntry.Text = ""
            end
        end)
    end
    adPurchaseDesc:WaitForChild("button_adPurchaseNext").Visible = false
    urlEntry.FocusLost:connect(function(entered)
        local text = urlEntry.Text
        local s, e = text:find("roblox.com/games/%d*")
        if s and e then
            local ID = text:sub(s, e):match("%d+")
            if ID and ID ~= "" then
                currentGameID = ID
                glowURL(Color3.new(0, 1, 0))
                adPurchaseDesc:WaitForChild("gameImg").Image = "http://www.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid=" .. ID .. "&fmt=png&wd=420&ht=420"
                adPurchaseReview:WaitForChild("gameImg").Image = "http://www.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid=" .. ID .. "&fmt=png&wd=420&ht=420"
                local info = game:GetService("MarketplaceService"):GetProductInfo(ID)
                if info and info.AssetTypeId == 9 then
                    adPurchaseDesc:WaitForChild("gameTitle").Text = info.Name
                    adPurchaseDesc:WaitForChild("gameCreator").Text = info.Creator.Name
                    adPurchaseReview:WaitForChild("gameTitle").Text = info.Name
                    adPurchaseReview:WaitForChild("gameCreator").Text = info.Creator.Name
                    adPurchaseDesc:WaitForChild("button_adPurchaseNext").Visible = true
                else
                    currentGameID = 0
                    adPurchaseDesc:WaitForChild("gameImg").Image = ""
                    adPurchaseDesc:WaitForChild("gameTitle").Text = ""
                    adPurchaseDesc:WaitForChild("gameCreator").Text = ""
                    adPurchaseDesc:WaitForChild("button_adPurchaseNext").Visible = false
                    urlEntry.Text = "Invalid URL"
                    glowURL(Color3.new(1, 0, 0), true)
                end
                return
            end
        end
        currentGameID = 0
        adPurchaseDesc:WaitForChild("gameImg").Image = ""
        adPurchaseDesc:WaitForChild("gameTitle").Text = ""
        adPurchaseDesc:WaitForChild("gameCreator").Text = ""
        urlEntry.Text = "Invalid URL"
        adPurchaseDesc:WaitForChild("button_adPurchaseNext").Visible = false
        glowURL(Color3.new(1, 0, 0), true)
    end)
    adPurchaseDesc:WaitForChild("button_adPurchaseNext").MouseButton1Click:connect(function()
        if currentGameID ~= 0 then
            adPurchaseDesc.Visible = false
            adPurchaseOptions.Visible = true
        end
    end)
    adPurchaseDesc:WaitForChild("button_adPurchaseBack").MouseButton1Click:connect(function()
        adPurchase.Visible = false
        currentGameID = 0
    end)
    adPurchaseOptions:WaitForChild("button_adPricingBack").MouseButton1Click:connect(function()
        adPurchaseDesc.Visible = true
        adPurchaseOptions.Visible = false
    end)
    local function updateAdReview(length, price)
        adPurchaseReview:WaitForChild("adLength").Text = length
        adPurchaseReview:WaitForChild("adPrice").Text = price
        adPurchaseReview.Visible = true
        adPurchaseOptions.Visible = false
    end
    adPurchaseOptions:WaitForChild("button_paymentOption01").MouseButton1Click:connect(function()
        purchasedID = currentGameID
        updateAdReview("1 Day", "R$150")
        paymentId = 270425686
    end)
    adPurchaseOptions:WaitForChild("button_paymentOption02").MouseButton1Click:connect(function()
        purchasedID = currentGameID
        updateAdReview("1 Week", "R$1000")
        paymentId = 270426067
    end)
    adPurchaseOptions:WaitForChild("button_paymentOption03").MouseButton1Click:connect(function()
        purchasedID = currentGameID
        updateAdReview("1 Month", "R$4500")
        paymentId = 270426574
    end)
    adPurchaseReview:WaitForChild("button_adPurchaseNext").MouseButton1Click:connect(function()
        game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer, paymentId)
    end)
    adPurchaseReview:WaitForChild("button_adPurchaseBack").MouseButton1Click:connect(function()
        adPurchaseReview.Visible = false
        adPurchaseOptions.Visible = true
    end)
    game:GetService("ReplicatedStorage"):WaitForChild("GotAd").OnClientEvent:connect(function(yes)
        if yes then
            adPurchase.Visible = false
            SFX.ChaChing:Play()
        end
    end)
    local GetTargettedID = game:GetService("ReplicatedStorage"):WaitForChild("GetTargettedID")
    function GetTargettedID.OnClientInvoke()
        return purchasedID
    end
    printTimeTaken("Ads")
end
do
    local container = menuMain:WaitForChild("frame_buttonContainer")
    for _, v in pairs(container:GetChildren()) do
        if v:IsA("ImageButton") then
            v.MouseEnter:connect(function()
                SFX.Hover:Play()
                v.ImageColor3 = Color3.new(0.1, 0.75, 1)
            end)
            v.MouseLeave:connect(function()
                v.ImageColor3 = Color3.new(0, 0, 0)
            end)
            v.MouseButton1Click:connect(function()
                SFX.Click:Play()
            end)
        end
    end
    printTimeTaken("Transitions")
end
do
    local lobbyBrowser = UI:WaitForChild("frame_lobbyBrowser")
    local lobbyCreate = UI:WaitForChild("frame_lobbyCreate")
    local contractInfo = lobbyCreate:WaitForChild("frame_contractInfo")
    local heistContainer = lobbyCreate:WaitForChild("frame_heistContainer")
    local lobbies = game:GetService("ReplicatedStorage"):WaitForChild("Lobbies")
    local entryContainer = lobbyBrowser:WaitForChild("frame_entryContainer")
    local myLevel = Data.Inventory.Level
    if 0 < #Data.Inventory.Infamy then
        myLevel = myLevel + 100
    end
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_playGame").MouseButton1Click:connect(function()
        menuMain.Visible = false
        lobbyBrowser.Visible = true
        bindChat(lobbyBrowser)
        cameraRun:SetCameraByPart(workspace.cam_browser)
    end)
    lobbyBrowser:WaitForChild("button_browserBack").MouseButton1Click:connect(function()
        lobbyBrowser.Visible = false
        menuMain.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_Main)
    end)
    local sampleEntry = entryContainer:WaitForChild("browserEntry")
    sampleEntry.Parent = nil
    local heistList = {}
    for k, v in pairs(heistInfo) do
        if k ~= "NotAllowedHeist" and v.CanPlay then
            table.insert(heistList, k)
        elseif not v.CanPlay and game.Players.LocalPlayer:GetRankInGroup(288052) > 200 then
            do
                local s, m = pcall(function()
                    local itemDesc = game:GetService("MarketplaceService"):GetProductInfo(2270104058, Enum.InfoType.Asset).Description
                    if itemDesc == "true" or game.Players.LocalPlayer.UserId == 5283599 then
                        table.insert(heistList, k)
                    end
                end)
                if not s then
                    spawn(function()
                        error(m)
                    end)
                end
            end
        end
    end
    local heistselected = heistList[1]
    local ds, ks, ps, ts, tms = 1, 1, 1, 1, 1
    local function getMapCost(heist)
        return math.floor(heistInfo[heist].Cost * ds + (heistInfo[heist].Cost * ds * 0.1 + 1000 * (ds - 1)))
    end
    local MyLobby
    local Ready = false
    local lobbyFrame = UI:WaitForChild("frame_lobby")
    local heistInfoFrame = lobbyFrame:WaitForChild("frame_heistContainer")
    local function updateReadyButton(isGreen)
        for _, v in pairs(lobbyFrame:WaitForChild("button_lobbyReady"):GetChildren()) do
            if v:IsA("Frame") then
                v.BackgroundColor3 = isGreen and Color3.new(0.3333333333333333, 1, 0.4980392156862745) or Color3.new(1, 0, 0)
            end
        end
    end
    local difficultyworth = {
        Normal = 1,
        Hard = 2,
        ["Very Hard"] = 3,
        Extreme = 4,
        Anarchy = 5,
        Nightmare = 6
    }
    local function myLobbyChanged(lobby)
        heistInfoFrame.text_cashAmount.Text = "$" .. convertToCommas(heistInfo[lobby.Heist.Value].EstimatedCash * difficultyworth[lobby.Difficulty.Value])
        heistInfoFrame.text_diffSetting.Text = lobby.Difficulty.Value
        heistInfoFrame.text_diffSetting.TextColor3 = difficultycolors[lobby.Difficulty.Value]
        heistInfoFrame.text_expAmount.Text = convertToCommas(heistInfo[lobby.Heist.Value].EstimatedXP * (1 + (difficultyworth[lobby.Difficulty.Value] - 1) / 10))
        heistInfoFrame.text_heistContractor.Text = heistInfo[lobby.Heist.Value].Contractor
        heistInfoFrame.text_heistName.Text = lobby.Heist.Value
        heistInfoFrame.text_lengthSetting.Text = "1 Day"
    end
    local function writeplayer(otherPlayer, slot, isHost)
        slot = slot:sub(-1)
        if not otherPlayer then
            lobbyFrame["frame_playerContainer0" .. slot].text_playerName.Text = "Empty Player Slot"
            lobbyFrame["frame_playerContainer0" .. slot].text_playerTitle.Text = ""
            lobbyFrame["frame_playerContainer0" .. slot].text_playerLevel.Text = ""
            lobbyFrame["frame_playerContainer0" .. slot].text_playerReady.Text = "NOT READY"
            lobbyFrame["frame_playerContainer0" .. slot].text_playerReady.TextColor3 = Color3.new(1, 0, 0)
            lobbyFrame["frame_playerContainer0" .. slot].Visible = false
            local kickSlot = lobbyFrame["frame_playerContainer0" .. slot]:FindFirstChild("button_playerKick")
            if kickSlot then
                kickSlot.Visible = false
            end
        else
            lobbyFrame["frame_playerContainer0" .. slot].text_playerName.Text = otherPlayer.Name
            lobbyFrame["frame_playerContainer0" .. slot].text_playerLevel.Text = game:GetService("ReplicatedStorage"):WaitForChild("RequestPlayerLevel"):InvokeServer(otherPlayer.Name)
            local tag = ""
            local tagcolor = Color3.new(1, 1, 1)
            if otherPlayer:IsA("Player") then
                local tagData = game:GetService("ReplicatedStorage"):WaitForChild("GetTagInfo"):InvokeServer(otherPlayer.Name)
                if tagData then
                    tag = tagData[1]
                    tagcolor = tagData[2]
                end
            end
            lobbyFrame["frame_playerContainer0" .. slot].text_playerTitle.Text = tag
            lobbyFrame["frame_playerContainer0" .. slot].text_playerTitle.TextColor3 = tagcolor
            local kickSlot = lobbyFrame["frame_playerContainer0" .. slot]:FindFirstChild("button_playerKick")
            if kickSlot and isHost then
                kickSlot.Visible = true
            elseif kickSlot then
                kickSlot.Visible = false
            end
            lobbyFrame["frame_playerContainer0" .. slot].Visible = true
        end
    end
    local inlobbycons = {}
    local function makeLobby(heistname, difficulty, kicking, permission, tactic, teammates, contract, exists)
        if not exists then
            do
                local lobby = game:GetService("ReplicatedStorage"):WaitForChild("MakeLobby"):InvokeServer(heistname, difficulty, kicking, permission, tactic, teammates, contract)
                MyLobby = lobby
                Ready = false
                for _, v in pairs(lobby:GetChildren()) do
                    v.Changed:connect(function()
                        myLobbyChanged(lobby)
                    end)
                end
                myLobbyChanged(lobby)
                cameraRun:JoinLobby(lobby)
                for _, v in pairs(lobby.Members:GetChildren()) do
                    do
                        local con = v.Changed:connect(function(m)
                            writeplayer(m, "PLAYER" .. v.Name, true)
                        end)
                        local playerNumber = v.Name:sub(-1)
                        local con2 = v.Ready.Changed:connect(function(r)
                            lobbyFrame["frame_playerContainer0" .. playerNumber].text_playerReady.Text = r and "READY" or "NOT READY"
                            lobbyFrame["frame_playerContainer0" .. playerNumber].text_playerReady.TextColor3 = r and Color3.new(0.3333333333333333, 1, 0.4980392156862745) or Color3.new(1, 0, 0)
                        end)
                        lobbyFrame["frame_playerContainer0" .. playerNumber].text_playerReady.Text = v.Ready.Value and "READY" or "NOT READY"
                        lobbyFrame["frame_playerContainer0" .. playerNumber].text_playerReady.TextColor3 = v.Ready.Value and Color3.new(0.3333333333333333, 1, 0.4980392156862745) or Color3.new(1, 0, 0)
                        writeplayer(v.Value, "PLAYER" .. playerNumber, true)
                        table.insert(inlobbycons, con)
                        table.insert(inlobbycons, con2)
                    end
                end
                lobbyFrame.frame_playerContainer01.text_playerReady.Text = "READY"
                lobbyFrame.frame_playerContainer01.text_playerReady.TextColor3 = Color3.new(0.3333333333333333, 1, 0.4980392156862745)
                writeplayer(lobby.Owner.Value, "PLAYER1", true)
            end
        else
            game:GetService("ReplicatedStorage"):WaitForChild("ChangeLobby"):FireServer(MyLobby, heistname, difficulty, kicking, permission, tactic, teammates, contract)
        end
        lobbyFrame.frame_playerInvite.Visible = false
        lobbyFrame.button_contractChange.Visible = true
        lobbyFrame.button_friendInvite.Visible = true
        lobbyFrame.button_lobbyReady.buttonText.Text = "START HEIST"
        updateReadyButton(true)
    end
    for i = 2, 4 do
        do
            local slot = lobbyFrame:WaitForChild("frame_playerContainer0" .. tostring(i))
            local kick = slot:FindFirstChild("button_playerKick")
            if kick then
                kick.MouseButton1Click:connect(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("KickFromLobby"):FireServer(MyLobby, i)
                end)
            end
        end
    end
    for _, v in pairs(lobbyFrame:GetChildren()) do
        if v:IsA("ImageButton") and v.Name ~= "button_lobbyReady" then
            v.MouseEnter:connect(function()
                SFX.Hover:Play()
                v.ImageColor3 = Color3.new(0.1, 0.75, 1)
            end)
            v.MouseLeave:connect(function()
                v.ImageColor3 = Color3.new(0, 0, 0)
            end)
            v.MouseButton1Click:connect(function()
                SFX.Click:Play()
            end)
        end
    end
    lobbyFrame:WaitForChild("button_lobbyBack").MouseButton1Click:connect(function()
        lobbyFrame.Visible = false
        lobbyBrowser.Visible = true
        bindChat(lobbyBrowser)
        cameraRun:LeaveLobby()
        for _, v in pairs(inlobbycons) do
            v:Disconnect()
        end
        game:GetService("ReplicatedStorage"):WaitForChild("LeaveLobby"):FireServer(MyLobby)
        MyLobby = nil
    end)
    lobbyFrame:WaitForChild("button_contractChange").MouseButton1Click:connect(function()
        lobbyFrame.Visible = false
        lobbyCreate.Visible = true
        lobbyCreate:WaitForChild("button_lobbyCreateBack"):WaitForChild("ReturnTo").Value = lobbyFrame
        bindChat(lobbyCreate)
    end)
    local Invite = lobbyFrame:WaitForChild("frame_playerInvite")
    local inviteInfoContainer = Invite:WaitForChild("frame_infoContainer")
    local invitePlayerContainer = inviteInfoContainer:WaitForChild("frame_playersContainer")
    local Search = inviteInfoContainer:WaitForChild("textBox_playerSearch")
    local ListLayout = invitePlayerContainer:WaitForChild("UIListLayout")
    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        invitePlayerContainer.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
    end)
    local User = invitePlayerContainer:WaitForChild("playerEntry")
    User.Parent = nil
    local function filterSearch()
        local lookFor = Search.Text
        for _, v in pairs(invitePlayerContainer:GetChildren()) do
            if v and v:IsA("TextLabel") then
                if v.Name:lower():find(lookFor:lower()) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            end
        end
    end
    local function addToNameList(playerName)
        if not invitePlayerContainer:FindFirstChild(playerName) and playerName ~= player.Name then
            do
                local listItem = User:clone()
                listItem.Name = playerName
                listItem.Text = playerName
                listItem:WaitForChild("button_playerAdd").MouseButton1Click:connect(function()
                    if listItem:WaitForChild("button_playerAdd").ImageTransparency <= 0.1 then
                        listItem:WaitForChild("button_playerAdd").ImageTransparency = 0.9
                        game:GetService("ReplicatedStorage"):WaitForChild("SendLobbyInvite"):FireServer(listItem.Name, MyLobby)
                        delay(30, function()
                            listItem:WaitForChild("button_playerAdd").ImageTransparency = 0
                        end)
                    end
                end)
                listItem.Parent = invitePlayerContainer
                filterSearch()
            end
        end
    end
    local function removeNameFromList(playerName)
        if invitePlayerContainer:FindFirstChild(playerName) then
            invitePlayerContainer:FindFirstChild(playerName):Destroy()
        end
    end
    game:GetService("Players").PlayerAdded:connect(function(player)
        addToNameList(player.Name)
    end)
    game:GetService("Players").PlayerRemoving:connect(function(player)
        removeNameFromList(player.Name)
    end)
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player then
            addToNameList(player.Name)
        end
    end
    Search:GetPropertyChangedSignal("Text"):connect(function()
        filterSearch()
    end)
    lobbyFrame:WaitForChild("button_friendInvite").MouseButton1Click:connect(function()
        Invite.Visible = true
    end)
    lobbyFrame:WaitForChild("frame_playerInvite"):WaitForChild("button_toLobby").MouseButton1Click:connect(function()
        Invite.Visible = false
    end)
    lobbyFrame:WaitForChild("button_inventory").MouseButton1Click:connect(function()
        lobbyFrame.Visible = false
        UI.frame_Inventory.Visible = true
        UI.frame_Inventory.FromLobby.Value = lobbyFrame
        bindChat(UI.frame_Inventory)
        cameraRun:SetCameraByPart(workspace.cam_Inventory)
    end)
    local difficultysels = {
        "Normal",
        "Hard",
        "Very Hard",
        "Extreme",
        "Anarchy",
        "Nightmare"
    }
    local infoContainer = contractInfo:WaitForChild("frame_infoContainer")
    local gameOptions = infoContainer:WaitForChild("text_gameOptions")
    local contractCreate = infoContainer:WaitForChild("button_contractCreate")
    local function updatepurchase(heist)
        local cost = getMapCost(heist)
        for _, v in pairs(difficultysels) do
            if Data.Inventory.Contracts[heist] and Data.Inventory.Contracts[heist][v] then
                contractInfo:WaitForChild("frame_safeContracts"):WaitForChild("text_contract" .. v).text_contractAmount.Text = convertToCommas(math.max(0, Data.Inventory.Contracts[heist][v]))
            else
                contractInfo:WaitForChild("frame_safeContracts"):WaitForChild("text_contract" .. v).text_contractAmount.Text = "0"
            end
        end
        local hasContract = false
        if Data.Inventory.Contracts[heist] and Data.Inventory.Contracts[heist][difficultysels[ds]] and Data.Inventory.Contracts[heist][difficultysels[ds]] > 0 then
            hasContract = true
        end
        infoContainer.text_contractCost.Text = "CONTRACT COST: " .. (cost < 0 and "FREE" or "$" .. convertToCommas(cost))
        if hasContract then
            infoContainer.text_contractCost.Text = "USING FREE CONTRACT"
        end
        infoContainer.text_contractDesc.Text = heistInfo[heist].ShortDesc
        infoContainer.text_estimateCash.Text = "ESTIMATED CASH: $" .. convertToCommas(heistInfo[heist].EstimatedCash * ds)
        infoContainer.text_estimateXP.Text = "ESTIMATED XP: " .. convertToCommas(heistInfo[heist].EstimatedXP * (1 + (ds - 1) / 2.5))
        infoContainer.mapImage.Image = heistInfo[heist].Image
        local stealthBonus = 10
        infoContainer.text_stealthBonus.Text = heistInfo[heist].CanStealth and "POTENTIAL STEALTH BONUS: " .. convertToCommas(stealthBonus) .. "%" or "STEALTH NOT POSSIBLE"
        if heistInfo[heist].CanStealth then
            infoContainer.text_stealthBonus.TextColor3 = Color3.new(0, 0.6666666666666666, 1)
        else
            infoContainer.text_stealthBonus.TextColor3 = Color3.new(1, 0.043137254901960784, 0.26666666666666666)
        end
        local buyText = "BUY CONTRACT: "
        if cost <= 0 or hasContract then
            buyText = "CONTRACT: "
        end
        contractInfo.text_contractLabel.Text = buyText .. heist:upper()
        if cost <= Data.Inventory.Cash or hasContract then
            contractCreate.buttonText.TextColor3 = Color3.new(1, 1, 1)
            contractCreate.buttonText.Text = "CREATE CONTRACT"
        else
            contractCreate.buttonText.TextColor3 = Color3.new(1, 0, 0)
            contractCreate.buttonText.Text = "CANNOT AFFORD CONTRACT"
        end
        if not hasContract and heistInfo[heistselected].MappackID and not game:GetService("ReplicatedStorage"):WaitForChild("OwnsDLC"):InvokeServer(heistInfo[heistselected].MappackID) then
            contractCreate.buttonText.TextColor3 = Color3.new(1, 0, 0)
            contractCreate.buttonText.Text = "REQUIRES MAP PACK"
        end
    end
    local kickingsels = {"DISABLED", "ENABLED"}
    local permissionsels = {
        "PUBLIC",
        "FRIENDS",
        "PRIVATE"
    }
    local myLevel = Data.Inventory.Level
    local isInfamy = 0 < Data.Inventory.Infamy:len()
    if isInfamy then
        myLevel = 100
    end
    for i = 1, math.floor(myLevel / 10) do
        table.insert(permissionsels, #permissionsels + 1, "MIN LEVEL " .. i * 10)
    end
    local tacticsels = {
        "ANY",
        "STEALTH",
        "LOUD"
    }
    local teammatesels = {"ENABLED", "DISABLED"}
    local function updatedifficulty(n)
        ds = ds + n
        if ds > #difficultysels then
            ds = 1
        elseif ds < 1 then
            ds = #difficultysels
        end
        updatepurchase(heistselected)
        return difficultysels[ds]
    end
    local function updatekicking(n)
        ks = ks + n
        if ks > #kickingsels then
            ks = 1
        elseif ks < 1 then
            ks = #kickingsels
        end
        updatepurchase(heistselected)
        return kickingsels[ks]
    end
    local function updatepermission(n)
        ps = ps + n
        if ps > #permissionsels then
            ps = 1
        elseif ps < 1 then
            ps = #permissionsels
        end
        return permissionsels[ps]
    end
    local function updatetactic(n)
        ts = ts + 1
        if ts > #tacticsels then
            ts = 1
        elseif ts < 1 then
            ts = #tacticsels
        end
        return tacticsels[ts]
    end
    local function updateteammate(n)
        tms = tms + 1
        if tms > #teammatesels then
            tms = 1
        elseif tms < 1 then
            tms = #teammatesels
        end
        return teammatesels[tms]
    end
    gameOptions.option_difficulty.button_settingRight.MouseButton1Click:connect(function()
        gameOptions.option_difficulty.optionSetting.Text = updatedifficulty(1):upper()
        gameOptions.option_difficulty.optionSetting.TextColor3 = difficultycolors[difficultysels[ds]]
    end)
    gameOptions.option_difficulty.button_settingLeft.MouseButton1Click:connect(function()
        gameOptions.option_difficulty.optionSetting.Text = updatedifficulty(-1):upper()
        gameOptions.option_difficulty.optionSetting.TextColor3 = difficultycolors[difficultysels[ds]]
    end)
    gameOptions.option_kicking.button_settingRight.MouseButton1Click:connect(function()
        gameOptions.option_kicking.optionSetting.Text = updatekicking(1):upper()
    end)
    gameOptions.option_kicking.button_settingLeft.MouseButton1Click:connect(function()
        gameOptions.option_kicking.optionSetting.Text = updatekicking(-1):upper()
    end)
    gameOptions.option_permission.button_settingRight.MouseButton1Click:connect(function()
        gameOptions.option_permission.optionSetting.Text = updatepermission(1):upper()
    end)
    gameOptions.option_permission.button_settingLeft.MouseButton1Click:connect(function()
        gameOptions.option_permission.optionSetting.Text = updatepermission(-1):upper()
    end)
    gameOptions.option_tactic.button_settingRight.MouseButton1Click:connect(function()
        gameOptions.option_tactic.optionSetting.Text = updatetactic(1):upper()
    end)
    gameOptions.option_tactic.button_settingLeft.MouseButton1Click:connect(function()
        gameOptions.option_tactic.optionSetting.Text = updatetactic(-1):upper()
    end)
    gameOptions.option_AI.button_settingRight.MouseButton1Click:connect(function()
        gameOptions.option_AI.optionSetting.Text = updateteammate(1):upper()
    end)
    gameOptions.option_AI.button_settingLeft.MouseButton1Click:connect(function()
        gameOptions.option_AI.optionSetting.Text = updateteammate(-1):upper()
    end)
    local function resetContractOptions()
        ds, ks, ps, ts, tms = 1, 1, 1, 1, 1
        updatepurchase(heistselected)
        gameOptions.option_difficulty.optionSetting.Text = "NORMAL"
        gameOptions.option_kicking.optionSetting.Text = "DISABLED"
        gameOptions.option_permission.optionSetting.Text = "PUBLIC"
        gameOptions.option_tactic.optionSetting.Text = "ANY"
        gameOptions.option_AI.optionSetting.Text = "ENABLED"
        gameOptions.option_difficulty.optionSetting.TextColor3 = difficultycolors[difficultysels[ds]]
    end
    infoContainer.button_contractCreate.MouseButton1Click:connect(function()
        local hasContract = false
        if Data.Inventory.Contracts[heistselected] and Data.Inventory.Contracts[heistselected][difficultysels[ds]] and Data.Inventory.Contracts[heistselected][difficultysels[ds]] > 0 then
            hasContract = true
        end
        if not hasContract and heistInfo[heistselected].MappackID and not game:GetService("ReplicatedStorage"):WaitForChild("OwnsDLC"):InvokeServer(heistInfo[heistselected].MappackID) then
            game:GetService("MarketplaceService"):PromptPurchase(player, heistInfo[heistselected].MappackID)
            SFX.Cant:Play()
            return
        end
        local alreadyExists = lobbyCreate.button_lobbyCreateBack.ReturnTo.Value and true or false
        if getMapCost(heistselected) > Data.Inventory.Cash and not hasContract then
            SFX.Cant:Play()
            return
        end
        SFX.TerminalClick:Play()
        local isKicking = true
        if ks == 1 then
            isKicking = false
        end
        local isTeammates = false
        if tms == 1 then
            isTeammates = true
        end
        if heistselected == "Test_Server" then
            ps = 2
            updatepermission(1)
            ps = 3
        end
        lobbyCreate.Visible = false
        makeLobby(heistselected, difficultysels[ds], isKicking, permissionsels[ps], tacticsels[ts], isTeammates, hasContract, alreadyExists)
        bindChat(lobbyFrame)
        lobbyFrame.Visible = true
    end)
    game:GetService("ReplicatedStorage"):WaitForChild("KickFromLobby").OnClientEvent:connect(function(lobbyName, reason)
        if UI.frame_Inventory.FromLobby.Value then
            UI.frame_Inventory.FromLobby.Value = lobbyBrowser
        else
            lobbyFrame.Visible = false
            lobbyBrowser.Visible = true
            bindChat(lobbyBrowser)
        end
        cameraRun:LeaveLobby()
        for _, v in pairs(inlobbycons) do
            v:Disconnect()
        end
        MyLobby = nil
        if lobbyBrowser:WaitForChild("Explain").Visible then
            return
        end
        lobbyBrowser:WaitForChild("Explain").Position = UDim2.new(1.5, 0, 0.5, 0)
        lobbyBrowser:WaitForChild("Explain"):WaitForChild("title").Text = reason and reason or "Kicked from \"" .. lobbyName .. "\""
        lobbyBrowser:WaitForChild("Explain").Visible = true
        local Tween = game:GetService("TweenService"):Create(lobbyBrowser:WaitForChild("Explain"), TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        Tween:Play()
    end)
    lobbyBrowser:WaitForChild("Explain"):WaitForChild("Ok").MouseButton1Click:connect(function()
        lobbyBrowser:WaitForChild("Explain").Visible = false
    end)
    local defaultHeist = heistContainer:WaitForChild("01_rbBank")
    defaultHeist.Parent = nil
    entryContainer.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        entryContainer.CanvasSize = UDim2.new(0, 0, 0, entryContainer.UIListLayout.AbsoluteContentSize.Y)
    end)
    heistContainer.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        heistContainer.CanvasSize = UDim2.new(0, 0, 0, heistContainer.UIListLayout.AbsoluteContentSize.Y)
    end)
    for _, name in pairs(heistList) do
        do
            local data = heistInfo[name]
            local heist = defaultHeist:clone()
            heist.Name = name
            heist.mapImage.Image = data.Image
            heist.mapContractor.Text = data.Contractor
            heist.mapStealth.Text = data.CanStealth and "STEALTH POSSIBLE" or "LOUD ONLY"
            heist.mapStealth.TextColor3 = data.CanStealth and Color3.new(0, 0.6666666666666666, 1) or Color3.new(1, 0.043137254901960784, 0.26666666666666666)
            heist.mapStealth.TextStrokeColor3 = data.CanStealth and Color3.new(0.29411764705882354, 0.29411764705882354, 0.29411764705882354) or Color3.new(0, 0, 0)
            if name == "Shadow Raid" then
                heist.mapStealth.Text = "STEALTH ONLY"
            end
            heist.mapTitle.Text = name:upper()
            if data.MappackID then
                heist.mapTitle.TextColor3 = Color3.new(1, 0.8509803921568627, 0.10196078431372549)
            end
            heist.MouseButton1Click:connect(function()
                heistContainer.Visible = false
                lobbyCreate.frame_titleBar.Visible = false
                lobbyCreate.Frame.Visible = false
                lobbyCreate.text_heistSelection.Visible = false
                lobbyCreate.button_lobbyCreateBack.Visible = false
                SFX.Gun:Play()
                heistselected = name
                resetContractOptions()
                contractInfo.Visible = true
            end)
            heist.LayoutOrder = data.Cost + (data.MappackID and 999999999 or 0)
            heist.Parent = heistContainer
        end
    end
    local function joinLobby(thisLobby)
        cameraRun:JoinLobby(thisLobby)
        MyLobby = thisLobby
        Ready = false
        for _, v in pairs(thisLobby:GetChildren()) do
            v.Changed:connect(function()
                myLobbyChanged(thisLobby)
            end)
        end
        myLobbyChanged(thisLobby)
        for _, v in pairs(thisLobby.Members:GetChildren()) do
            do
                local con = v.Changed:connect(function(m)
                    writeplayer(m, "PLAYER" .. v.Name)
                end)
                local playerNumber = v.Name:sub(-1)
                local con2 = v.Ready.Changed:connect(function(r)
                    lobbyFrame["frame_playerContainer0" .. playerNumber].text_playerReady.Text = r and "READY" or "NOT READY"
                    lobbyFrame["frame_playerContainer0" .. playerNumber].text_playerReady.TextColor3 = r and Color3.new(0.3333333333333333, 1, 0.4980392156862745) or Color3.new(1, 0, 0)
                end)
                lobbyFrame["frame_playerContainer0" .. playerNumber].text_playerReady.Text = v.Ready.Value and "READY" or "NOT READY"
                lobbyFrame["frame_playerContainer0" .. playerNumber].text_playerReady.TextColor3 = v.Ready.Value and Color3.new(0.3333333333333333, 1, 0.4980392156862745) or Color3.new(1, 0, 0)
                lobbyFrame.frame_playerContainer01.text_playerReady.Text = "READY"
                lobbyFrame.frame_playerContainer01.text_playerReady.TextColor3 = Color3.new(0.3333333333333333, 1, 0.4980392156862745)
                writeplayer(v.Value, "PLAYER" .. v.Name)
                table.insert(inlobbycons, con)
                table.insert(inlobbycons, con2)
            end
        end
        lobbyBrowser.Visible = false
        lobbyFrame.frame_playerContainer01.text_playerReady.Text = "NOT READY"
        lobbyFrame.frame_playerContainer01.text_playerReady.TextColor3 = Color3.new(1, 0, 0)
        writeplayer(thisLobby.Owner.Value, "PLAYER1")
        game:GetService("ReplicatedStorage"):WaitForChild("JoinLobby"):FireServer(thisLobby)
        updateReadyButton(false)
        lobbyFrame.frame_playerInvite.Visible = false
        lobbyFrame.button_contractChange.Visible = false
        lobbyFrame.button_friendInvite.Visible = false
        lobbyFrame.button_lobbyReady.buttonText.Text = "READY UP"
        bindChat(lobbyFrame)
        lobbyFrame.Visible = true
    end
    local function lobbyAdded(lobby)
        local permissionLevel = lobby:WaitForChild("PermissionLevel").Value
        if permissionLevel == -2 then
            return
        end
        if permissionLevel == -1 and (not player:IsFriendsWith(lobby:WaitForChild("Owner").Value.UserId) or not lobby:WaitForChild("Owner").Value:IsFriendsWith(player.UserId)) then
            return
        end
        if permissionLevel > myLevel then
            return
        end
        local entry = sampleEntry:clone()
        local function updateLobby()
            entry.LobbyLink.Value = lobby
            entry.heistTactic.Image = ({
                ANY = "rbxassetid://2578036964",
                LOUD = "rbxassetid://2393831078",
                STEALTH = "rbxassetid://2578036832"
            })[lobby:WaitForChild("Tactic").Value]
            entry.heistName.Text = lobby:FindFirstChild("Heist").Value
            entry.lobbyName.Text = lobby:FindFirstChild("Owner").Value.Name
            entry.lobbyPlayers.Text = "1 / 4"
            entry.heistDifficulty.Text = lobby:FindFirstChild("Difficulty").Value
            entry.heistDifficulty.TextColor3 = difficultycolors[lobby:FindFirstChild("Difficulty").Value]
        end
        lobby:FindFirstChild("Heist").Changed:connect(function()
            updateLobby()
        end)
        updateLobby()
        entry.MouseButton1Click:connect(function()
            local thisLobby = entry.LobbyLink.Value
            joinLobby(thisLobby)
        end)
        entry.Parent = entryContainer
        spawn(function()
            while entry and entry.Parent and lobby and lobby.Parent do
                local count = 1
                local members = lobby:WaitForChild("Members")
                for _, member in pairs(members:GetChildren()) do
                    if member and member.Value then
                        count = count + 1
                    end
                end
                if count == 4 then
                    entry.Visible = false
                else
                    entry.Visible = true
                end
                entry.lobbyPlayers.Text = tostring(count) .. " / 4"
                wait()
            end
        end)
    end
    for _, v in pairs(lobbies:GetChildren()) do
        lobbyAdded(v)
    end
    lobbies.ChildAdded:connect(lobbyAdded)
    lobbies.ChildRemoved:connect(function(lobby)
        for _, v in pairs(entryContainer:GetChildren()) do
            if v and v:FindFirstChild("LobbyLink") and (v:FindFirstChild("LobbyLink").Value == lobby or v:FindFirstChild("LobbyLink").Value == nil) then
                v:Destroy()
            end
        end
    end)
    lobbyBrowser:WaitForChild("button_lobbyCreate").MouseButton1Click:connect(function()
        lobbyBrowser.Visible = false
        lobbyCreate.Visible = true
        lobbyCreate:WaitForChild("button_lobbyCreateBack"):WaitForChild("ReturnTo").Value = nil
        chat.Visible = false
        infoStats.Visible = false
    end)
    contractInfo:WaitForChild("button_contractBack").MouseButton1Click:connect(function()
        contractInfo.Visible = false
        heistContainer.Visible = true
        lobbyCreate.frame_titleBar.Visible = true
        lobbyCreate.Frame.Visible = true
        lobbyCreate.text_heistSelection.Visible = true
        lobbyCreate.button_lobbyCreateBack.Visible = true
    end)
    lobbyCreate:WaitForChild("button_lobbyCreateBack").MouseButton1Click:connect(function()
        local returnTo = lobbyCreate.button_lobbyCreateBack.ReturnTo.Value
        if returnTo == nil then
            lobbyBrowser.Visible = true
            lobbyCreate.Visible = false
            chat.Visible = true
            infoStats.Visible = true
            bindChat(lobbyBrowser)
        else
            lobbyCreate.button_lobbyCreateBack.ReturnTo.Value = nil
            lobbyCreate.Visible = false
            returnTo.Visible = true
            if returnTo:FindFirstChild("frame_chat") then
                bindChat(returnTo)
            end
        end
    end)
    local readyDebounce = false
    lobbyFrame:WaitForChild("button_lobbyReady").MouseButton1Click:connect(function()
        if readyDebounce then
            return
        end
        readyDebounce = true
        if lobbyFrame:WaitForChild("button_lobbyReady"):WaitForChild("buttonText").Text == "START HEIST" then
            local canTeleport = true
            for _, m in pairs(MyLobby.Members:GetChildren()) do
                if m and m.Value and not m.Ready.Value then
                    canTeleport = false
                    break
                end
            end
            if canTeleport then
                lobbyFrame:WaitForChild("button_lobbyReady"):WaitForChild("buttonText").Text = "Starting..."
                game:GetService("ReplicatedStorage"):WaitForChild("StartGame"):FireServer(MyLobby)
            end
            wait(10)
            delay(1, function()
                lobbyFrame:WaitForChild("button_lobbyReady"):WaitForChild("buttonText").Text = "START HEIST"
            end)
        else
            Ready = not Ready
            updateReadyButton(Ready)
            if Ready then
                lobbyFrame:WaitForChild("button_lobbyReady"):WaitForChild("buttonText").Text = "READY"
            else
                lobbyFrame:WaitForChild("button_lobbyReady"):WaitForChild("buttonText").Text = "READY UP"
            end
            game:GetService("ReplicatedStorage"):WaitForChild("ReadyUp"):FireServer(MyLobby, Ready)
        end
        wait(1)
        readyDebounce = false
    end)
    local function callback(text, lobby)
        print(text, lobby)
        if text == "Accept" then
            print("Joining...")
            local success = game:GetService("ReplicatedStorage"):WaitForChild("JoinLobbyInvite"):InvokeServer(lobby, MyLobby)
            if success then
                if MyLobby then
                    cameraRun:LeaveLobby()
                end
                lobbyFrame.Visible = true
                bindChat(lobbyFrame)
                chat.Visible = true
                menuMain.Visible = false
                lobbyBrowser.Visible = false
                lobbyCreate.Visible = false
                joinLobby(lobby)
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Join Failed!",
                    Text = "The lobby might be full or missing...",
                    Icon = "rbxassetid://1795283606",
                    Duration = 5
                })
            end
        elseif text == "Decline" then
        end
    end
    game:GetService("ReplicatedStorage"):WaitForChild("SendLobbyInvite").OnClientEvent:connect(function(lobby, inviter)
        local bindableFunction = Instance.new("BindableFunction")
        function bindableFunction.OnInvoke(text)
            callback(text, lobby)
            bindableFunction:Destroy()
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Lobby Invite",
            Text = inviter .. " invited you to join a lobby",
            Icon = "rbxassetid://1795283606",
            Duration = 20,
            Callback = bindableFunction,
            Button1 = "Accept",
            Button2 = "Decline"
        })
        game.Debris:AddItem(bindableFunction, 22)
    end)
    printTimeTaken("Lobby")
end
do
    local controls = UI:WaitForChild("frame_Controls")
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_controls").MouseButton1Click:connect(function()
        menuMain.Visible = false
        bindChat(controls)
        controls.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_Skills)
    end)
    controls:WaitForChild("button_controlsBack").MouseButton1Click:connect(function()
        menuMain.Visible = true
        bindChat(menuMain)
        controls.Visible = false
        cameraRun:SetCameraByPart(workspace.cam_Main)
    end)
    printTimeTaken("Controls")
end
do
    local credits = UI:WaitForChild("frame_Credits")
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_credits").MouseButton1Click:connect(function()
        menuMain.Visible = false
        bindChat(credits)
        credits.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_Skills)
    end)
    credits:WaitForChild("button_creditsBack").MouseButton1Click:connect(function()
        menuMain.Visible = true
        credits.Visible = false
        bindChat(menuMain)
        cameraRun:SetCameraByPart(workspace.cam_Main)
    end)
    credits:GetPropertyChangedSignal("Visible"):connect(function()
        if credits.Visible then
            musicPlayer:PlayTrack("CreditsTheme")
        else
            musicPlayer:PlayTrack("MainTheme")
        end
    end)
    printTimeTaken("Credits")
end
do
    local store = UI:WaitForChild("frame_Store")
    local container = store:WaitForChild("frame_container")
    local twitterCodes = store:WaitForChild("frame_twitterCodes")
    local deal = store:WaitForChild("DEAL")
    local listings = UI:WaitForChild("frame_storeListings")
    local list = listings:WaitForChild("Frame")
    local regContainer = listings:WaitForChild("frame_infoContainer"):WaitForChild("containerRegular")
    local lootboxContainer = listings:WaitForChild("frame_infoContainer"):WaitForChild("containerLootboxes")
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_store").MouseButton1Click:connect(function()
        store.Visible = true
        bindChat(store)
        menuMain.Visible = false
        twitterCodes.Visible = false
        deal.Visible = false
        listings.Visible = false
        regContainer.Visible = false
        lootboxContainer.Visible = false
        cameraRun:SetCameraByPart(workspace.cam_Skills)
    end)
    container:WaitForChild("button_storeBack").MouseButton1Click:connect(function()
        store.Visible = false
        bindChat(menuMain)
        menuMain.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_Main)
    end)
    local marketplaceService = game:GetService("MarketplaceService")
    local gamepassService = game:GetService("GamePassService")
    local tweenService = game:GetService("TweenService")
    local spinner = UI:WaitForChild("frame_lootboxSpinner")
    local MoneyList = store:WaitForChild("frame_robux"):WaitForChild("MoneyList")
    local microtransactionIDs = require(game:GetService("ReplicatedStorage"):WaitForChild("Transactions"))
    local safeInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("SafeInfo"))
    local materialInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("MaterialInfo"))
    local maskInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("MaskInfo"))
    local RandomItemGenerator = require(game:GetService("ReplicatedStorage"):WaitForChild("RandomItemGenerator"))
    local quality_names = require(game:GetService("ReplicatedStorage"):WaitForChild("QualityInfo"))
    local safeModules = {}
    for _, v in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Safes"):GetChildren()) do
        if v:FindFirstChild("CrateModule") then
            safeModules[v.Name] = require(v:FindFirstChild("CrateModule"))
        end
    end
    local function callPurchase(frame)
        local transactionID = microtransactionIDs[frame.Name]
        if transactionID then
            marketplaceService:PromptProductPurchase(player, transactionID)
        else
            error("Microtransaction ID for " .. frame.Name .. " not found!")
        end
    end
    local dealTween = tweenService:Create(deal, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.25, 0, 0.35, 0)
    })
    local transactionIds = {
        BigBank = 732739,
        GoldenMask = 1088492,
        Wasted = 1137409,
        Grenades = 782554,
        Overkill = 1062931,
        Sniper = 972848,
        Tips = 329897,
        DoubleXP = 1258911,
        DoubleCash = 1247045,
        CheaperInfamy = 748016
    }
    local transactionListings = {
        BigBank = {
            Name = "Brick Bank Heist",
            Description = "A large bank full of loot guarded behind several layers of security.",
            Image = "rbxassetid://1560136757",
            Category = "Map",
            Price = "R$1000"
        },
        GoldenMask = {
            Name = "Golden Mask Casino Heist",
            Description = "A massive casino which stores its profits deep within.",
            Image = "rbxassetid://1560137596",
            Category = "Map",
            Price = "R$900"
        },
        Wasted = {
            Name = "Wasted Shotgun Pack",
            Description = "Unlocks 3 powerful shotguns: The Vepr 12, KSG 12, and the DAO 12. Use these weapons to clear large groups of enemies!",
            Image = "rbxassetid://2054039039",
            Category = "Weapon",
            Price = "R$350"
        },
        Grenades = {
            Name = "Grenade Throwable",
            Description = "Things getting tough? Grenades ought to do the trick. Every heist you play you will have three grenades. Once you use all 3, you are out. Use them wisely!",
            Image = "rbxassetid://1560138313",
            Category = "Weapon",
            Price = "R$150"
        },
        Overkill = {
            Name = "Overkill Weapon Pack",
            Description = "Unlocks two deadly weapons that will surely aid you in your survival against the blue onslaught. The minigun fires at an astounding rate. The RPG can eliminate entire crowds easily.",
            Image = "rbxassetid://1560137945",
            Category = "Weapon",
            Price = "R$400"
        },
        Sniper = {
            Name = "Marksman Weapon Pack",
            Description = "Unlocks 4 powerful sniper rifles, the L96, M95, M96, and the M110. Use these to deal massive damage to stronger enemies!",
            Image = "rbxassetid://1560137461",
            Category = "Weapon",
            Price = "R$500"
        },
        Tips = {
            Name = "Tip Jar",
            Description = "This will help me out so much in the development of this game. I need money for badges, audio, and animations that will make this place work.",
            Image = "rbxassetid://1560140295",
            Category = "Gamepass",
            Price = "R$10"
        },
        DoubleXP = {
            Name = "Double Experience",
            Description = "Earn experience from heists twice as fast with this gamepass. Useful for leveling up to get skill points, or making quick runs to infamy.",
            Image = "rbxassetid://1560139574",
            Category = "Gamepass",
            Price = "R$1000"
        },
        DoubleCash = {
            Name = "Double Cash",
            Description = "Through well planned investments, you earn twice as much cash (After a successful Heist) than you would normally. This applies after difficulty bonuses.",
            Image = "rbxassetid://1560139404",
            Category = "Gamepass",
            Price = "R$750"
        },
        CheaperInfamy = {
            Name = "Cheaper Infamy",
            Description = "This gamepass makes infamy cost 50% cheaper!",
            Image = "rbxassetid://1560139175",
            Category = "Gamepass",
            Price = "R$200"
        }
    }
    local safeImages = {
        ["Cardboard 'Safe'"] = "http://www.roblox.com/asset/?id=1186376383",
        ["Metal Safe"] = "http://www.roblox.com/asset/?id=1186376493",
        ["Infamous Safe"] = "http://www.roblox.com/asset/?id=1251942645",
        ["Outlaw Safe"] = "http://www.roblox.com/asset/?id=1260008024",
        ["Ruby Safe"] = "rbxassetid://3314095960"
    }
    local GetDayOfWeek
    do
        local days = {
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        }
        function GetDayOfWeek()
            return days[os.date("*t", os.time()).wday]
        end
    end
    local day = GetDayOfWeek()
    local deal_table = require(game:GetService("ReplicatedStorage"):WaitForChild("DealOfTheDay"))[day]
    for _, v in pairs(MoneyList:GetChildren()) do
        if v:IsA("Frame") then
            v:WaitForChild("TextButton").MouseButton1Click:connect(function()
                callPurchase(v)
            end)
        end
    end
    MoneyList:WaitForChild("DailyDeal").MouseButton1Click:connect(function()
        deal.Position = UDim2.new(-1, 0, 0.35, 0)
        dealTween:Play()
        store:WaitForChild("frame_robux").Visible = false
        deal.Visible = true
    end)
    store:WaitForChild("frame_robux"):WaitForChild("button_storeBack").MouseButton1Click:connect(function()
        store:WaitForChild("frame_robux").Visible = false
        container.Visible = true
    end)
    container:WaitForChild("buttonRobux").MouseButton1Click:connect(function()
        store:WaitForChild("frame_robux").Visible = true
        container.Visible = false
    end)
    deal:WaitForChild("Frame"):WaitForChild("TextLabel").Text = day:upper() .. " DEAL! " .. deal_table[1]:sub(5)
    deal:WaitForChild("Frame"):WaitForChild("TextButton").MouseButton1Click:connect(function()
        marketplaceService:PromptProductPurchase(player, deal_table[2])
    end)
    deal:WaitForChild("Frame"):WaitForChild("TextButton").Text = "[PURCHASE TODAY FOR " .. tostring(deal_table[3]) .. "% OFF]"
    deal:WaitForChild("X").MouseButton1Click:connect(function()
        deal.Visible = false
        store:WaitForChild("frame_robux").Visible = true
    end)
    local sampleListing = list:WaitForChild("itemEntry01")
    sampleListing.Parent = nil
    local category = ""
    local function showListing(id, data, isOwned)
        regContainer.ID.Value = id
        regContainer.frame_infoItem.itemDesc.Text = data.Description
        regContainer.frame_infoItem.itemName.Text = data.Name
        regContainer.itemImage.Image = data.Image
        regContainer.button_itemPurchase.Visible = true
        if isOwned then
            regContainer.button_itemPurchase.buttonText.Text = "OWNED"
        else
            regContainer.button_itemPurchase.buttonText.Text = "BUY"
        end
    end
    local function updateListings()
        for _, v in pairs(list:GetChildren()) do
            if v:IsA("ImageButton") then
                v:Destroy()
            end
        end
        local lowest = math.huge
        local lowestListing, lowestData
        local lowestOwned = false
        for id, data in pairs(transactionListings) do
            if data.Category == category then
                do
                    local newListing = sampleListing:Clone()
                    newListing.Name = id
                    newListing.itemImage.Image = data.Image
                    newListing.itemName.Text = data.Name
                    local isOwned = marketplaceService:UserOwnsGamePassAsync(player.UserId, transactionIds[id])
                    local val = data.Price:match("%d+")
                    newListing.LayoutOrder = val
                    if val and lowest > tonumber(val) then
                        lowest = tonumber(val)
                        lowestListing = newListing
                        lowestData = data
                        lowestOwned = isOwned
                    end
                    if isOwned then
                        newListing.itemPrice.Text = "[OWNED]"
                    else
                        newListing.itemPrice.Text = data.Price
                    end
                    newListing.MouseButton1Click:connect(function()
                        showListing(id, data, isOwned)
                    end)
                    newListing.Parent = list
                end
            end
        end
        showListing(lowestListing.Name, lowestData, lowestOwned)
    end
    list:WaitForChild("UIListLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        list.CanvasSize = UDim2.new(0, 0, 0, list:WaitForChild("UIListLayout").AbsoluteContentSize.Y)
    end)
    regContainer:WaitForChild("button_itemPurchase").MouseButton1Click:connect(function()
        marketplaceService:PromptGamePassPurchase(player, transactionIds[regContainer.ID.Value])
    end)
    container:WaitForChild("buttonWeapons").MouseButton1Click:connect(function()
        deal.Visible = false
        listings.Visible = true
        regContainer.Visible = true
        lootboxContainer.Visible = false
        store.Visible = false
        category = "Weapon"
        updateListings()
    end)
    container:WaitForChild("buttonMaps").MouseButton1Click:connect(function()
        deal.Visible = false
        listings.Visible = true
        regContainer.Visible = true
        lootboxContainer.Visible = false
        store.Visible = false
        category = "Map"
        updateListings()
    end)
    container:WaitForChild("buttonPasses").MouseButton1Click:connect(function()
        deal.Visible = false
        listings.Visible = true
        regContainer.Visible = true
        lootboxContainer.Visible = false
        store.Visible = false
        category = "Gamepass"
        updateListings()
    end)
    marketplaceService.PromptPurchaseFinished:connect(function(user, passId, purchased)
        if user == player and purchased then
            updateListings()
            playerGui:WaitForChild("StatsChange"):Fire()
        end
    end)
    listings:WaitForChild("button_listingsBack").MouseButton1Click:connect(function()
        listings.Visible = false
        store.Visible = true
    end)
    game:GetService("ReplicatedStorage"):WaitForChild("GiveMoney").OnClientEvent:connect(function(money)
        Data.Inventory.Cash = Data.Inventory.Cash + money
        playerGui:WaitForChild("StatsChange"):Fire()
    end)
    local function updateLooks()
        wait()
        MoneyList.CanvasSize = UDim2.new(0, 0, 0, MoneyList:WaitForChild("UIListLayout").AbsoluteContentSize.Y + 20)
    end
    local selectedSafe = ""
    local selectedSafeModel
    repeat
        wait()
    until Data.Inventory.OwnedSafes
    updateLooks()
    for _, v in pairs(container:GetChildren()) do
        if v:IsA("ImageButton") and v:FindFirstChild("cant") == nil then
            do
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local tweenIn = tweenService:Create(v, tweenInfo, {
                    ImageColor3 = Color3.new(0.0784313725490196, 0.8470588235294118, 1)
                })
                local tweenOut = tweenService:Create(v, tweenInfo, {
                    ImageColor3 = Color3.new(1, 1, 1)
                })
                v.MouseEnter:connect(function()
                    SFX.Hover:Play()
                    tweenIn:Play()
                end)
                v.MouseLeave:connect(function()
                    tweenOut:Play()
                end)
                v.MouseButton1Click:connect(function()
                    SFX.Click:Play()
                    tweenOut:Play()
                end)
            end
        end
    end
    local safeList = {
        ["Cardboard 'Safe'"] = {
            cost = 50000,
            description = "A cheap safe made of cardboard. Contains contracts and blank white masks.",
            oddDescription = "Odds: 35% Common, 30% Rare, 20% Epic, 10% Elite, 5% Infamous",
            devID = 1514411853,
            canBuy = true
        },
        ["Metal Safe"] = {
            cost = 250000,
            description = "A durable safe that is hard to get into. Contains contracts and blank colored masks.",
            oddDescription = "Odds: 25% Common, 30% Rare, 30% Epic, 10% Elite, 5% Infamous",
            devID = 1514412449,
            canBuy = true
        },
        ["Gold Safe"] = {
            cost = 500000,
            description = "gold desc.",
            oddDescription = "Odds: 5% Common, 5% Rare, 25% Epic, 30% Elite, 35% Infamous",
            devID = 1514412227,
            canBuy = false
        },
        ["Diamond Safe"] = {
            cost = 750000,
            description = "A ridiculously expensive safe forged from diamonds. Contains textured and colored masks.",
            oddDescription = "Odds: 35% Common, 30% Rare, 20% Epic, 10% Elite, 5% Infamous",
            devID = 1514412045,
            canBuy = true
        },
        ["Infamous Safe"] = {
            cost = 1000000,
            description = "Infamous desc.",
            oddDescription = "Odds: 25% Common, 30% Rare, 30% Epic, 10% Elite, 5% Infamous",
            devID = 1514412337,
            canBuy = false
        },
        ["Ruby Safe"] = {
            cost = 1250000,
            description = "An extravagant safe that contains  valuable ruby red masks",
            oddDescription = "Odds: 20% Common, 30% Rare, 30% Epic, 15% Elite, 5% Infamous",
            devID = 1514412551,
            canBuy = true
        }
    }
    local function showSafeListing(id, data)
        lootboxContainer.ID.Value = id
        lootboxContainer.frame_infoItem.itemDesc.Text = data.description
        lootboxContainer.frame_infoItem.itemName.Text = id
        lootboxContainer.itemImage.Image = safeInfo[id].Image
        lootboxContainer.frame_infoItem.rarities.Text = data.oddDescription
        lootboxContainer.button_itemPurchase.Visible = true
        lootboxContainer.numowned.Text = "Owned: " .. (Data.Inventory.OwnedSafes[id] or 0)
    end
    local function updateSafeListings()
        for _, v in pairs(list:GetChildren()) do
            if v:IsA("ImageButton") then
                v:Destroy()
            end
        end
        local lowest = math.huge
        local lowestListing, lowestData
        for id, data in pairs(safeList) do
            if data.canBuy then
                local newListing = sampleListing:Clone()
                newListing.Name = id
                newListing.itemImage.Image = safeInfo[id].Image
                newListing.itemName.Text = id
                newListing.itemPrice.Text = convertToCommas(safeInfo[id].Cost)
                newListing.LayoutOrder = safeInfo[id].Cost
                local val = safeInfo[id].Cost
                if val and lowest > val then
                    lowest = val
                    lowestListing = newListing
                    lowestData = data
                end
                newListing.MouseButton1Click:connect(function()
                    showSafeListing(id, data)
                end)
                newListing.Parent = list
            end
        end
        showSafeListing(lowestListing.Name, lowestData)
    end
    container:WaitForChild("buttonSafes").MouseButton1Click:connect(function()
        store.Visible = false
        listings.Visible = true
        regContainer.Visible = false
        updateSafeListings()
        lootboxContainer.Visible = true
    end)
    lootboxContainer:WaitForChild("button_itemPurchase").MouseButton1Click:connect(function()
        local safe = safeInfo[lootboxContainer.ID.Value]
        if safe then
            if safe.Cost <= Data.Inventory.Cash then
                SFX.ChaChing:Play()
                Data.Inventory.Cash = Data.Inventory.Cash - safe.Cost
                playerGui.StatsChange:Fire()
                if Data.Inventory.OwnedSafes[lootboxContainer.ID.Value] then
                    Data.Inventory.OwnedSafes[lootboxContainer.ID.Value] = Data.Inventory.OwnedSafes[lootboxContainer.ID.Value] + 1
                else
                    Data.Inventory.OwnedSafes[lootboxContainer.ID.Value] = 1
                end
                game:GetService("ReplicatedStorage").BuySafe:FireServer(lootboxContainer.ID.Value)
                lootboxContainer.numowned.Text = "Owned: " .. Data.Inventory.OwnedSafes[lootboxContainer.ID.Value]
            else
                SFX.Cant:Play()
            end
        end
    end)
    container:WaitForChild("button_storeCodes").MouseButton1Click:connect(function()
        twitterCodes.Visible = true
        container.Visible = false
    end)
    twitterCodes:WaitForChild("button_codesBack").MouseButton1Click:connect(function()
        twitterCodes.Visible = false
        container.Visible = true
    end)
    local CodeBox = twitterCodes:WaitForChild("codeEntry")
    local Enter = twitterCodes:WaitForChild("button_redeemCode")
    local codeStatus = twitterCodes:WaitForChild("codeStatus")
    Enter.MouseButton1Click:connect(function()
        local txt = CodeBox.Text
        Enter.Visible = false
        CodeBox.Text = ""
        local rewardText = game:GetService("ReplicatedStorage"):WaitForChild("RedeemCode"):InvokeServer(txt)
        if rewardText and rewardText ~= "x" then
            codeStatus.Text = rewardText
            codeStatus.TextColor3 = Color3.new(0, 1, 0)
            delay(5, function()
                for i = 1, 10 do
                    codeStatus.TextTransparency = i / 10
                    wait()
                end
                codeStatus.Text = ""
                codeStatus.TextTransparency = 0
            end)
            SFX.TerminalClick:Play()
            Data.Inventory = game:GetService("ReplicatedStorage"):WaitForChild("RequestData"):InvokeServer()
            playerGui:WaitForChild("StatsChange"):Fire()
        elseif rewardText and rewardText == "x" then
            SFX.Cant:Play()
            codeStatus.Text = "You have redeemed that code before. Follow @realEvanPickett on Twitter for more codes!"
            codeStatus.TextColor3 = Color3.new(0, 1, 1)
            delay(5, function()
                for i = 1, 10 do
                    codeStatus.TextTransparency = i / 10
                    wait()
                end
                codeStatus.Text = ""
                codeStatus.TextTransparency = 0
            end)
        else
            SFX.Cant:Play()
            codeStatus.TextColor3 = Color3.new(1, 1, 0)
            codeStatus.Text = "That code is not valid. Follow @realEvanPickett on Twitter for codes!"
            delay(5, function()
                for i = 1, 10 do
                    codeStatus.TextTransparency = i / 10
                    wait()
                end
                codeStatus.Text = ""
                codeStatus.TextTransparency = 0
            end)
        end
        wait(5)
        Enter.Visible = true
    end)
    printTimeTaken("Store")
end
do
    local achievements = UI:WaitForChild("frame_Achievements")
    local container = achievements:WaitForChild("frame_achievementContainer")
    local info = achievements:WaitForChild("frame_infoContainer")
    local progress = info:WaitForChild("frame_achievementProgress")
    local titleName = info:WaitForChild("Frame"):WaitForChild("frame_infoAchievement"):WaitForChild("frame_rewardContainer"):WaitForChild("titleName")
    container:WaitForChild("UIListLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        container.CanvasSize = UDim2.new(0, 0, 0, container.UIListLayout.AbsoluteContentSize.Y)
    end)
    container.CanvasSize = UDim2.new(0, 0, 0, container:WaitForChild("UIListLayout").AbsoluteContentSize.Y)
    local rewards = {}
    local selectedButton
    local function updateInfoContainer(button)
        selectedButton = button
        local tracker = require(button.Tracker)
        local id = tracker:GetTitleId()
        local reward = rewards[button.Name]
        if reward then
            titleName.Text = reward[1]
            titleName.TextColor3 = reward[2]
            titleName.TextStrokeTransparency = reward[3] and 0.5 or 1
            titleName.TextStrokeColor3 = reward[3] and reward[3] or Color3.new()
        else
            titleName.Text = "error loading title"
            titleName.TextColor3 = Color3.new(0.5, 0.1, 0.1)
            titleName.TextStrokeTransparency = 1
        end
        tracker:UpdateProgress()
        info:WaitForChild("Frame"):WaitForChild("frame_infoAchievement"):WaitForChild("achievementDesc").Text = tracker:GetDescription()
        info:WaitForChild("Frame"):WaitForChild("frame_infoAchievement"):WaitForChild("achievementTitle").Text = button:WaitForChild("achievementTitle").Text
        if tracker:HasAchievement() then
            info:WaitForChild("Frame"):WaitForChild("buttonEquipTitle").Visible = true
            if Data.Inventory.Title == id then
                info:WaitForChild("Frame"):WaitForChild("buttonEquipTitle"):WaitForChild("buttonText").Text = "UNEQUIP TITLE"
            else
                info:WaitForChild("Frame"):WaitForChild("buttonEquipTitle"):WaitForChild("buttonText").Text = "EQUIP TITLE"
            end
        else
            info:WaitForChild("Frame"):WaitForChild("buttonEquipTitle").Visible = false
        end
    end
    spawn(function()
        local has, total = 0, 0
        for _, v in pairs(container:GetChildren()) do
            if v:IsA("ImageButton") then
                total = total + 1
                local module = require(v:WaitForChild("Tracker"))
                rewards[v.Name] = game:GetService("ReplicatedStorage"):WaitForChild("GetTitleInfo"):InvokeServer(module:GetTitleId())
                v.MouseButton1Click:connect(function()
                    updateInfoContainer(v)
                end)
                if module:HasAchievement() then
                    has = has + 1
                    v:WaitForChild("achievementStatus").Text = "unlocked"
                    v:WaitForChild("achievementStatus").TextColor3 = Color3.new(0, 1, 0)
                else
                    v:WaitForChild("achievementStatus").Text = "locked"
                    v:WaitForChild("achievementStatus").TextColor3 = Color3.new(0.85, 0, 0)
                end
            end
        end
        achievements:WaitForChild("text_achievementsUnlocked").Text = "Achievements unlocked: " .. has .. " / " .. total
    end)
    spawn(function()
        updateInfoContainer(container:WaitForChild("01_notoElite"))
    end)
    info:WaitForChild("Frame"):WaitForChild("buttonEquipTitle").MouseButton1Click:connect(function()
        if selectedButton == nil then
            return
        end
        local module = require(selectedButton:WaitForChild("Tracker"))
        local id = module:GetTitleId()
        if module:HasAchievement() then
            if Data.Inventory.Title == id then
                game:GetService("ReplicatedStorage"):WaitForChild("SetTitle"):FireServer()
                info:WaitForChild("Frame"):WaitForChild("buttonEquipTitle"):WaitForChild("buttonText").Text = "EQUIP TITLE"
                Data.Inventory.Title = ""
            else
                game:GetService("ReplicatedStorage"):WaitForChild("SetTitle"):FireServer(id)
                info:WaitForChild("Frame"):WaitForChild("buttonEquipTitle"):WaitForChild("buttonText").Text = "UNEQUIP TITLE"
                Data.Inventory.Title = id
            end
        end
    end)
    local heistTracker = UI:WaitForChild("frame_heistTracker")
    local heistContainer = heistTracker:WaitForChild("frame_heistContainer")
    local heistInfoContainer = heistTracker:WaitForChild("frame_infoContainer")
    local heistDiffList = heistInfoContainer:WaitForChild("Frame"):WaitForChild("frame_infoAchievement"):WaitForChild("frame_difficultyContainer")
    local heistEntry = heistContainer:WaitForChild("01_rbBank")
    heistEntry.Parent = nil
    heistContainer:WaitForChild("UIListLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        heistContainer.CanvasSize = UDim2.new(0, 0, 0, heistContainer.UIListLayout.AbsoluteContentSize.Y)
    end)
    local function getHeistInformation(heistName)
        local heistData = Data.Inventory.Wins[heistName]
        heistInfoContainer:WaitForChild("contractImage").Image = heistInfo[heistName].Image
        heistInfoContainer:WaitForChild("Frame"):WaitForChild("frame_infoAchievement"):WaitForChild("contractName").Text = heistName:upper()
        if heistData == nil then
            for _, v in pairs(heistDiffList:GetChildren()) do
                if v:FindFirstChild("difficultyProgress") then
                    v.difficultyProgress.Text = "no"
                    v.difficultyProgress.TextColor3 = Color3.new(0.85, 0, 0)
                end
            end
        else
            for _, v in pairs(heistDiffList:GetChildren()) do
                if v:FindFirstChild("CheckFor") then
                    local val = heistData[v.CheckFor.Value]
                    v.difficultyProgress.Text = val and val > 0 and "yes" or "no"
                    v.difficultyProgress.TextColor3 = (val == nil or val == 0) and Color3.new(0.85, 0, 0) or Color3.new(0, 1, 0)
                    if not heistInfo[heistName].CanStealth and v.CheckFor.Value == "Stealth" then
                        v.difficultyProgress.Text = "n/a"
                        v.difficultyProgress.TextColor3 = Color3.new(0, 1, 0)
                    end
                elseif v.Name == "10_loud" then
                    local val = heistData.Wins > heistData.Stealth
                    v.difficultyProgress.Text = val and "yes" or "no"
                    v.difficultyProgress.TextColor3 = val and Color3.new(0, 1, 0) or Color3.new(0.85, 0, 0)
                end
            end
        end
    end
    local lowestCost, lowestName = math.huge, nil
    local total, completed = 0, 0
    for heistName, v in pairs(heistInfo) do
        if v.CanPlay then
            total = total + 1
            local newEntry = heistEntry:Clone()
            newEntry.Name = heistName
            newEntry.LayoutOrder = v.Cost
            newEntry.achievementImage.Image = v.Image
            newEntry.achievementTitle.Text = heistName:upper()
            newEntry.Parent = heistContainer
            if lowestCost > v.Cost then
                lowestCost = v.Cost
                lowestName = heistName
            end
            newEntry.MouseButton1Click:connect(function()
                getHeistInformation(heistName)
            end)
            local thisInfo = Data.Inventory.Wins[heistName]
            if thisInfo then
                local valid = true
                for _, d in pairs({
                    "Normal",
                    "Hard",
                    "Very Hard",
                    "Extreme",
                    "Anarchy",
                    "Nightmare",
                    "Stealth"
                }) do
                    if not thisInfo[d] or thisInfo[d] <= 0 then
                        if d ~= "Stealth" then
                            valid = false
                            break
                        elseif heistInfo.CanStealth then
                            valid = false
                            break
                        end
                    end
                end
                if valid and thisInfo.Wins and thisInfo.Wins > thisInfo.Stealth then
                    newEntry.BackgroundColor3 = Color3.new(0, 0.3333333333333333, 0)
                    completed = completed + 1
                end
            end
        end
    end
    heistTracker:WaitForChild("text_heistsCompleted").Text = "Heists Completed: " .. completed .. "/" .. total
    getHeistInformation(lowestName)
    heistTracker:WaitForChild("button_trackerBack").MouseButton1Click:connect(function()
        achievements.Visible = true
        heistTracker.Visible = false
    end)
    achievements:WaitForChild("button_achieveBack").MouseButton1Click:connect(function()
        menuMain.Visible = true
        achievements.Visible = false
        bindChat(menuMain)
        cameraRun:SetCameraByPart(workspace.cam_Main)
    end)
    info:WaitForChild("Frame"):WaitForChild("buttonHeistTracker").MouseButton1Click:connect(function()
        achievements.Visible = false
        heistTracker.Visible = true
    end)
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_achievements").MouseButton1Click:connect(function()
        menuMain.Visible = false
        achievements.Visible = true
        bindChat(achievements)
        cameraRun:SetCameraByPart(workspace.cam_Skills)
    end)
    printTimeTaken("Achievements")
end
do
    local leaderboards = script.Parent:WaitForChild("frame_Leaderboards")
    local entries = leaderboards:WaitForChild("frame_entryContainer")
    local infoContainer = leaderboards:WaitForChild("frame_infoContainer")
    local infoHeist = infoContainer:WaitForChild("Frame"):WaitForChild("frame_infoHeist")
    local speedRunInfo = leaderboards:WaitForChild("frame_speedrunInfo")
    local updated = leaderboards:WaitForChild("lastUpdated")
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_leaderboards").MouseButton1Click:connect(function()
        leaderboards.Visible = true
        bindChat(leaderboards)
        menuMain.Visible = false
        speedRunInfo.Visible = false
        cameraRun:SetCameraByPart(workspace.cam_Skills)
    end)
    leaderboards:WaitForChild("button_leaderBack").MouseButton1Click:connect(function()
        leaderboards.Visible = false
        bindChat(menuMain)
        menuMain.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_Main)
    end)
    local hn = 1
    local heistList = {}
    for k, v in pairs(heistInfo) do
        if k ~= "NotAllowedHeist" and v.CanPlay then
            table.insert(heistList, k)
        end
    end
    table.sort(heistList, function(a, b)
        local aValue = heistInfo[a].Cost
        local bValue = heistInfo[b].Cost
        if a.MappackID then
            aValue = aValue + 100000
        end
        if b.MappackID then
            bValue = bValue + 100000
        end
        if aValue < bValue then
            return true
        end
    end)
    local function updateSelectedHeist()
        infoHeist:WaitForChild("contractName").Text = heistList[hn]:upper()
        infoContainer:WaitForChild("contractImage").Image = heistInfo[heistList[hn]].Image
    end
    entries:WaitForChild("UIListLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        entries.CanvasSize = UDim2.new(0, 0, 0, entries:WaitForChild("UIListLayout").AbsoluteContentSize.Y)
    end)
    updateSelectedHeist()
    local clockTime = function(seconds)
        local decimal = seconds / 10
        seconds = math.floor(decimal)
        decimal = decimal - math.floor(decimal)
        local minsleft = math.floor(seconds / 60)
        local secsleft = tostring(math.floor(seconds % 60))
        if string.len(secsleft) == 1 then
            secsleft = "0" .. secsleft
        end
        return minsleft .. " : " .. secsleft .. "." .. math.floor(decimal * 10)
    end
    local function clearLeaderboard()
        for _, v in pairs(entries:GetChildren()) do
            if v:IsA("ImageButton") and v:FindFirstChild("playerName") then
                v:FindFirstChild("playerName").Text = "----"
                v:FindFirstChild("playerTime").Text = "--:--"
                v:FindFirstChild("playerPosition"):FindFirstChild("positionValue").Text = ""
            end
        end
        updated.Text = "please wait, the server is waiting for data..."
    end
    local function updateLeaderboard(data, secondsAgo)
        local place = 0
        local lastValue = -1
        for k, v in pairs(data) do
            local name, timeTaken = v[1], v[2]
            local formattedK = tostring(k)
            if #formattedK == 1 then
                formattedK = "0" .. formattedK
            end
            if lastValue < timeTaken then
                lastValue = timeTaken
                place = place + 1
            end
            local slot = entries:FindFirstChild("leaderboardEntry" .. formattedK)
            slot:FindFirstChild("playerName").Text = name
            if name == player.Name then
                slot:FindFirstChild("playerName").TextColor3 = Color3.new(1, 0.6666666666666666, 0)
            else
                slot:FindFirstChild("playerName").TextColor3 = Color3.new(1, 1, 1)
            end
            slot:FindFirstChild("playerTime").Text = clockTime(timeTaken)
            slot:FindFirstChild("playerPosition"):FindFirstChild("positionValue").Text = tostring(place)
            if place == 1 then
                slot:FindFirstChild("playerPosition").ImageColor3 = Color3.new(0.9803921568627451, 0.8666666666666667, 0)
            elseif place == 2 then
                slot:FindFirstChild("playerPosition").ImageColor3 = Color3.new(0.7843137254901961, 0.7843137254901961, 0.7843137254901961)
            elseif place == 3 then
                slot:FindFirstChild("playerPosition").ImageColor3 = Color3.new(0.6666666666666666, 0.4235294117647059, 0)
            else
                slot:FindFirstChild("playerPosition").ImageColor3 = Color3.new(0.2901960784313726, 0.2901960784313726, 0.2901960784313726)
            end
        end
        updated.Text = "Last updated: " .. tostring(secondsAgo) .. " second" .. (secondsAgo ~= 1 and "s" or "") .. " ago"
    end
    local function getLeaderboardFor(heistName)
        clearLeaderboard()
        local myHn = hn
        local data, secondsAgo = game:GetService("ReplicatedStorage"):WaitForChild("RequestLeaderboardInfo"):InvokeServer(heistList[hn])
        if data and hn == myHn then
            updateLeaderboard(data, secondsAgo)
        else
            warn("Could not fetch data")
        end
    end
    infoHeist:WaitForChild("button_optionRight").MouseButton1Down:connect(function()
        hn = hn + 1
        if hn > #heistList then
            hn = 1
        end
        updateSelectedHeist()
        getLeaderboardFor()
    end)
    infoHeist:WaitForChild("button_optionLeft").MouseButton1Down:connect(function()
        hn = hn - 1
        if hn < 1 then
            hn = #heistList
        end
        updateSelectedHeist()
        getLeaderboardFor()
    end)
    spawn(function()
        getLeaderboardFor()
    end)
    leaderboards:WaitForChild("button_speedrunInfo").MouseButton1Click:connect(function()
        speedRunInfo.Visible = true
    end)
    speedRunInfo:WaitForChild("frame_messageBox"):WaitForChild("button_runInfoBack").MouseButton1Click:connect(function()
        speedRunInfo.Visible = false
    end)
    printTimeTaken("Leaderboards")
end
do
    local infamy = UI:WaitForChild("frame_Infamy")
    local warning = infamy:WaitForChild("frame_infamyWarning")
    local container = infamy:WaitForChild("frame_tierContainer")
    local desc = infamy:WaitForChild("frame_tierDesc")
    local infamyInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("InfamyInfo"))
    local cashRequired, levelRequired = 20000000, 100
    if game:GetService("MarketplaceService"):PlayerOwnsAsset(player, 271095523) then
        cashRequired = cashRequired / 2
        print("user owns half-infamy price gamepass")
    end
    local OWNED_COLOR = "rbxassetid://1811795439"
    local LOCKED_COLOR = "rbxassetid://1811795791"
    local AVAILABLE_COLOR = "rbxassetid://1811796152"
    local romanNumerals = {
        "I",
        "II",
        "III",
        "IV",
        "V",
        "VI",
        "VII",
        "VIII",
        "IX",
        "X",
        "XI",
        "XII",
        "XIII",
        "XIV",
        "XV",
        "XVI",
        "XVII",
        "XVIII",
        "XIX",
        "XX",
        "XXI",
        "XXII",
        "XXIII",
        "XXIV",
        "XXV"
    }
    local function hasInfamyTier(tier)
        if Data.Inventory.Infamy:find(tier) then
            return true
        end
        return false
    end
    local function canHaveInfamyTier(tier)
        if hasInfamyTier(tier) then
            return false
        else
            local v = infamyInfo.InfamyUpgradeList[tier]
            if v == nil then
                return false
            end
            if v.Requires:len() > 0 then
                local has = false
                for i = 1, v.Requires:len() do
                    if hasInfamyTier(v.Requires:sub(i, i)) then
                        return true
                    end
                end
                if not has then
                    return false
                end
            else
                return true
            end
        end
    end
    local function update()
        local hasCash = Data.Inventory.Cash >= cashRequired
        local hasLevel = Data.Inventory.Level >= levelRequired
        desc:WaitForChild("infamyRequirements"):WaitForChild("cash").Text = "$" .. convertToCommas(cashRequired)
        desc:WaitForChild("infamyRequirements"):WaitForChild("cash").TextColor3 = hasCash and Color3.new(0.3333333333333333, 1, 0) or Color3.new(0.8156862745098039, 0, 0)
        desc:WaitForChild("infamyRequirements"):WaitForChild("level").TextColor3 = hasLevel and Color3.new(0, 1, 1) or Color3.new(0.8156862745098039, 0, 0)
        for k, v in pairs(infamyInfo.InfamyUpgradeList) do
            local subject = container:FindFirstChild(k)
            if subject then
                if hasInfamyTier(k) then
                    subject.Image = OWNED_COLOR
                    subject:FindFirstChild("tierAcquired").Visible = true
                    subject:FindFirstChild("tierLock").Visible = false
                else
                    subject:FindFirstChild("tierAcquired").Visible = false
                    if 0 < v.Requires:len() then
                        local has = false
                        for i = 1, v.Requires:len() do
                            if hasInfamyTier(v.Requires:sub(i, i)) then
                                subject.Image = AVAILABLE_COLOR
                                subject:FindFirstChild("tierLock").Visible = false
                                has = true
                                break
                            end
                        end
                        if not has then
                            subject.Image = LOCKED_COLOR
                            subject:FindFirstChild("tierLock").Visible = true
                        end
                    else
                        subject.Image = AVAILABLE_COLOR
                        subject:FindFirstChild("tierLock").Visible = false
                    end
                end
            end
        end
    end
    infamy:GetPropertyChangedSignal("Visible"):connect(function()
        if infamy.Visible then
            update()
        end
    end)
    local selected
    local function setTier(button)
        selected = button
        local hasCash = Data.Inventory.Cash >= cashRequired
        local hasLevel = Data.Inventory.Level >= levelRequired
        local canHave = canHaveInfamyTier(button.Name)
        desc:WaitForChild("button_infamyPurchase").Visible = hasCash and hasLevel and canHave
        desc:WaitForChild("tierLock").Visible = not hasInfamyTier(button.Name) and not canHave
        button.ImageColor3 = Color3.new(0.13333333333333333, 1, 1)
        for _, q in pairs(container:GetChildren()) do
            if q:IsA("ImageButton") and q ~= button then
                q.ImageColor3 = Color3.new(1, 1, 1)
            end
        end
        local rewards = {}
        local v = infamyInfo.InfamyUpgradeList[button.Name]
        if v.SkillPoints > 0 then
            table.insert(rewards, v.SkillPoints .. " permanent skill points")
        end
        if v.MaskUnlock ~= "" then
            table.insert(rewards, "'" .. v.MaskUnlock:upper() .. "' mask")
        end
        if 0 < v.XPbonus then
            table.insert(rewards, v.XPbonus .. "% XP bonus")
        end
        if 0 < v.CashBonus then
            table.insert(rewards, v.CashBonus .. "% cash bonus")
        end
        if v.Safe then
            table.insert(rewards, "Infamous-tier safe")
        end
        for i = 1, 3 do
            local txt = desc:WaitForChild("reward0" .. i .. "Text")
            local img = desc:WaitForChild("reward0" .. i .. "Image")
            if rewards[i] then
                txt.Visible = true
                img.Visible = true
                txt.Text = rewards[i]
            else
                txt.Visible = false
                img.Visible = false
            end
        end
    end
    for _, v in pairs(container:GetChildren()) do
        if v:IsA("ImageButton") then
            v.MouseButton1Click:connect(function()
                setTier(v)
            end)
        end
    end
    game:GetService("MarketplaceService").PromptPurchaseFinished:connect(function(user, passId, purchased)
        if user == player and purchased and passId == 271095523 then
            cashRequired = cashRequired / 2
            update()
            setTier(container:WaitForChild("a"))
        end
    end)
    setTier(container:WaitForChild("a"))
    desc:WaitForChild("button_infamyPurchase").MouseButton1Click:connect(function()
        container.Visible = false
        desc.Visible = false
        infamy:WaitForChild("frame_titleBar").Visible = false
        warning.Visible = true
        if #Data.Inventory.Infamy < 5 then
            warning.Frame.text_warning01.Text = "By becoming infamous, you will lose all Level progress, acquired Skill Points, Cash and Weapons. Everything else will be kept."
        else
            warning.Frame.text_warning01.Text = "By becoming infamous, you will lose all Level progress, acquired Skill Points, $" .. convertToCommas(cashRequired) .. " and all Weapons. Everything else will be kept."
        end
        SFX.LoadGun:Play()
    end)
    infamy:WaitForChild("button_infamyBack").MouseButton1Click:connect(function()
        container.Visible = true
        desc.Visible = true
        infamy:WaitForChild("frame_titleBar").Visible = true
        warning.Visible = false
        menuMain.Visible = true
        infamy.Visible = false
        bindChat(menuMain)
        cameraRun:SetCameraByPart(workspace.cam_Main)
    end)
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_infamy").MouseButton1Click:connect(function()
        bindChat(infamy)
        infamy.Visible = true
        menuMain.Visible = false
        cameraRun:SetCameraByPart(workspace.cam_Skills)
    end)
    warning:WaitForChild("Frame"):WaitForChild("button_infamyAccept").MouseButton1Click:connect(function()
        warning.Visible = false
        Data.Inventory.Infamy = Data.Inventory.Infamy .. selected.Name
        if #Data.Inventory.Infamy >= 6 then
            Data.Inventory.Cash = Data.Inventory.Cash - cashRequired
        else
            Data.Inventory.Cash = 0
        end
        Data.Inventory.Level = 1
        Data.Inventory.XP = 0
        for i = 1, 3 do
            for k, v in pairs(Data.Inventory.Classes["Class " .. tostring(i)].Skills) do
                Data.Inventory.Classes["Class " .. tostring(i)].Skills[k] = ""
            end
        end
        Data.Inventory.OwnedWeapons = {
            ["(M16)0"] = {
                Skin = "",
                Attachments = {},
                ID = 0
            },
            ["(G17)0"] = {
                Skin = "",
                Attachments = {},
                ID = 0
            },
            ["(Suit)0"] = {
                Skin = "",
                Attachments = {},
                ID = 0
            },
            ["(Knife)0"] = {
                Skin = "",
                Attachments = {},
                ID = 0
            }
        }
        for k, v in pairs(Data.Inventory.Classes) do
            v.Primary = {
                "M16",
                0,
                ""
            }
            v.Secondary = {
                "G17",
                0,
                ""
            }
            v.Attach1 = {}
            v.Attach2 = {}
            v.Armor = "Suit"
            v.Melee = "Knife"
            v.Equipment = ""
            v.Detection = game:GetService("ReplicatedStorage"):WaitForChild("UpdateConcealment"):InvokeServer(k)
        end
        if infamyInfo.InfamyUpgradeList[selected.Name].MaskUnlock ~= "" then
            table.insert(Data.Inventory.OwnedCustomMasks, {
                infamyInfo.InfamyUpgradeList[selected.Name].MaskUnlock,
                "Really black",
                "Blank"
            })
        end
        if infamyInfo.InfamyUpgradeList[selected.Name].Safe then
            if Data.Inventory.OwnedSafes["Infamous Safe"] then
                Data.Inventory.OwnedSafes["Infamous Safe"] = Data.Inventory.OwnedSafes["Infamous Safe"] + 1
            else
                Data.Inventory.OwnedSafes["Infamous Safe"] = 1
            end
        end
        SFX.Gun:Play()
        container.Visible = true
        desc.Visible = true
        infamy:WaitForChild("frame_titleBar").Visible = true
        update()
        setTier(selected)
        game:GetService("ReplicatedStorage"):WaitForChild("BecomeInfamous"):FireServer(selected.Name)
        playerGui:WaitForChild("StatsChange"):Fire()
        musicPlayer:PlayTrack("BecameInfamous")
        local newLevel = infamy:WaitForChild("newLevel")
        newLevel.Text = romanNumerals[Data.Inventory.Infamy:len()]
        newLevel.Position = UDim2.new(-1, 0, 0, 0)
        newLevel.TextColor3 = Color3.new(1, 0, 0)
        newLevel.Visible = true
        local tween = game:GetService("TweenService"):Create(newLevel, TweenInfo.new(5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            TextColor3 = Color3.new(1, 1, 1),
            Position = UDim2.new(0, 0, 0, 0)
        })
        tween:Play()
        wait(10)
        local tween2 = game:GetService("TweenService"):Create(newLevel, TweenInfo.new(3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, 0, 0, 0)
        })
        tween2:Play()
        wait(3)
        newLevel.Visible = false
    end)
    warning:WaitForChild("Frame"):WaitForChild("button_infamyDecline").MouseButton1Click:connect(function()
        container.Visible = true
        desc.Visible = true
        infamy:WaitForChild("frame_titleBar").Visible = true
        warning.Visible = false
        SFX.Click:Play()
    end)
    printTimeTaken("Infamy")
end
do
    local inventory = UI:WaitForChild("frame_Inventory")
    local gunInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("GunInfo"))
    local maskInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("MaskInfo"))
    local mainButtons = inventory:WaitForChild("frame_buttonContainer")
    local mainStats = inventory:WaitForChild("frame_statsContainer")
    local CollectionService = game:GetService("CollectionService")
    local TweenService = game:GetService("TweenService")
    local selectedProfile = -1
    local function hasSkill(tree, name)
        return Data.Inventory.Classes["Class " .. selectedProfile].Skills[tree .. "Tree"]:find(name)
    end
    local getNameFromOwned = function(ownedName)
        return ownedName:match("%b()"):sub(2, ownedName:len() - 2), ownedName:sub(ownedName:find("%)d*") + 1)
    end
    local calculatedetectionfromconcealment = function(concealment)
        return math.min(75, math.floor(3.4346 * 1.2183 ^ ((119 - concealment) / 1.7949) + 0.5))
    end
    local calculateBaseAccuracy = function(data)
        local firemode = data.FireMode
        local base = 95
        if firemode == "AutoShotgun" then
            base = 30
        elseif firemode == "Shotgun" then
            base = 40
        elseif firemode == "Burst" then
            base = 80
        elseif firemode == "Auto" then
            base = 75
        end
        if data.BulletsPerBurstOrShotgun > 0 then
            base = base / (data.BulletsPerBurstOrShotgun * data.PushBack)
        end
        return base
    end
    local calculateBaseStability = function(data)
        return data.AimSpeed * (100 - data.AimFOV) * data.FireDelay / 2
    end
    local calculateBaseFireRate = function(data)
        local firemode = data.FireMode
        local base = 10 / data.FireDelay
        if data.BulletsPerBurstOrShotgun > 0 and firemode ~= "AutoShotgun" and firemode ~= "Shotgun" then
            base = 10 / (data.BulletsPerBurstOrShotgun * data.FireDelay)
        end
        return base
    end
    local function calculateBaseConcealment(gunName)
        return gunInfo.weaponConcealment[gunName]
    end
    local silencers = {
        ["Oil Filter"] = true,
        ["Osprey .45"] = true,
        ["Interceptor .45"] = true,
        ["Micro-9mm"] = true,
        Jungle = true
    }
    local function calculateAttachmentAccuracy(data, attachments)
        local base = calculateBaseAccuracy(data)
        local modified = 0
        for attachmentName, t in pairs(attachments) do
            if t then
                local info = gunInfo.AttachmentInfo[attachmentName]
                if info then
                    local change = 0
                    if info.Accuracy then
                        if info.Accuracy[2] then
                            change = change + base * info.Accuracy[1]
                        else
                            change = info.Accuracy[1]
                        end
                    end
                    modified = modified + change
                end
            end
        end
        return modified
    end
    local function calculateAttachmentStability(data, attachments)
        local base = calculateBaseStability(data)
        local modified = 0
        for attachmentName, t in pairs(attachments) do
            if t then
                local info = gunInfo.AttachmentInfo[attachmentName]
                if info then
                    local change = 0
                    if info.Stability then
                        if info.Stability[2] then
                            change = change + base * info.Stability[1]
                        else
                            change = info.Stability[1]
                        end
                    end
                    modified = modified + change
                end
            end
        end
        return modified
    end
    local function calculateAttachmentFireRate(data, attachments)
        local base = calculateBaseFireRate(data)
        local modified = 0
        for attachmentName, t in pairs(attachments) do
            if t then
                local info = gunInfo.AttachmentInfo[attachmentName]
                if info then
                    local change = 0
                    if info.FireRate then
                        if info.FireRate[2] then
                            change = change + base * info.FireRate[1]
                        else
                            change = info.FireRate[1]
                        end
                    end
                    modified = modified + change
                end
            end
        end
        return modified
    end
    local function calculateAttachmentConcealment(baseName, attachments)
        local base = calculateBaseConcealment(baseName)
        local modified = 0
        for attachmentName, t in pairs(attachments) do
            if t then
                local info = gunInfo.AttachmentInfo[attachmentName]
                if info then
                    local change = 0
                    if info.Concealment then
                        if info.Concealment[2] then
                            change = change + base * info.Concealment[1]
                        else
                            change = info.Concealment[1]
                        end
                    end
                    modified = modified + change
                end
            end
        end
        return modified
    end
    local function calculateAttachmentDamage(data, attachments)
        local base = data.Damage
        local modified = 0
        for attachmentName, t in pairs(attachments) do
            if t then
                local info = gunInfo.AttachmentInfo[attachmentName]
                if info then
                    local change = 0
                    if info.Damage then
                        if info.Damage[2] then
                            change = change + base * info.Damage[1]
                        else
                            change = info.Damage[1]
                        end
                    end
                    modified = modified + change
                end
            end
        end
        return modified
    end
    local function calculateSkillAccuracy(baseName, data, attachments)
        local base = calculateBaseAccuracy(data)
        local modified = 0
        local classes = {}
        for _, v in pairs(gunInfo.weaponClass[baseName]) do
            classes[v] = true
        end
        local hasSilencer = false
        for attachmentName, t in pairs(attachments) do
            if t and silencers[attachmentName] then
                hasSilencer = true
                break
            end
        end
        return modified
    end
    local calculateSkillStability = function(baseName, data, attachments)
        local modified = 0
        return 0
    end
    local calculateSkillFireRate = function(baseName, data, attachments)
        local modified = 0
        return 0
    end
    local function calculateSkillMagazine(baseName, data, attachments)
        local base = data.MagazineSize
        local modified = 0
        local classes = {}
        for _, v in pairs(gunInfo.weaponClass[baseName]) do
            classes[v] = true
        end
        if hasSkill("E", "P") and classes.Shotgun == true and data.FireMode ~= "AutoShotgun" then
            modified = modified + 15
        end
        if hasSkill("E", "s") and baseName ~= "RPG-7" then
            modified = modified + base * 0.25
        end
        return math.floor(modified)
    end
    local function calculateSkillReserve(baseName, data, attachments)
        local base = data.AmmoMax
        local modified = 0
        local classes = {}
        for _, v in pairs(gunInfo.weaponClass[baseName]) do
            classes[v] = true
        end
        if baseName == "SAW" and hasSkill("E", "T") then
            modified = modified + base * 0.5
        end
        if hasSkill("E", "j") and data.AmmoClass == "Primary" then
            modified = modified + 25
        elseif hasSkill("E", "J") and data.AmmoClass == "Secondary" and baseName ~= "RPG-7" then
            modified = modified + 25
        end
        return math.floor(modified)
    end
    local function calculateSkillConcealment(baseName, data, attachments)
        local base = calculateBaseConcealment(baseName)
        local modified = 0
        local classes = {}
        if gunInfo.weaponClass[baseName] then
            for _, v in pairs(gunInfo.weaponClass[baseName]) do
                classes[v] = true
            end
            local hasSilencer = false
            for attachmentName, t in pairs(attachments) do
                if t and silencers[attachmentName] then
                    hasSilencer = true
                    break
                end
            end
            if hasSilencer and hasSkill("G", "C") then
                modified = modified + 3
            elseif hasSilencer and hasSkill("G", "c") then
                modified = modified + 1
            end
        end
        if data and data.WeaponType == "Melee" and hasSkill("G", "g") then
            modified = modified + 2
        end
        if baseName == "Lightweight Vest" and hasSkill("G", "G") then
            modified = modified + 4
        end
        return modified
    end
    local function calculateSkillDamage(baseName, data, attachments)
        local base = data.Damage
        local modified = 0
        local classes = {}
        if data.WeaponType == "Melee" and hasSkill("E", "l") then
            modified = modified + base
        end
        if data.FireMode and data.FireMode == "Semi" and hasSkill("T", "d") then
            modified = modified + base * 0.05
        end
        if gunInfo.weaponClass[baseName] then
            for _, v in pairs(gunInfo.weaponClass[baseName]) do
                classes[v] = true
            end
            local hasSilencer = false
            for attachmentName, t in pairs(attachments) do
                if t and silencers[attachmentName] then
                    hasSilencer = true
                    break
                end
            end
            if classes.Pistol then
                if hasSkill("M", "l") then
                    modified = modified + 20
                end
                if hasSkill("M", "L") then
                    modified = modified + 20
                end
            end
            if hasSilencer then
                if hasSkill("G", "Q") then
                    modified = modified + base * 0.3
                elseif hasSkill("G", "q") then
                    modified = modified + base * 0.15
                end
            end
            if classes.Shotgun then
                if hasSkill("E", "H") then
                    modified = modified + base * 0.1
                elseif hasSkill("E", "h") then
                    modified = modified + base * 0.05
                end
            end
        end
        return modified
    end
    local shortenDecimals = function(number)
        local stringNum = tostring(number)
        local decimals = stringNum:match("%.%d*")
        if decimals then
            return stringNum:sub(1, stringNum:find("%.%d*") - 1) .. decimals:sub(1, 2)
        end
        return number
    end
    inventory:WaitForChild("button_invBack").MouseButton1Click:connect(function()
        if inventory.FromLobby.Value then
            if inventory.FromLobby.Value == UI.frame_lobbyBrowser then
                cameraRun:SetCameraByPart(workspace.cam_browser)
            else
                cameraRun:SetCameraByPart(workspace.LobbyView)
                workspace.CurrentCamera.FieldOfView = 50
            end
            inventory.FromLobby.Value.Visible = true
            bindChat(inventory.FromLobby.Value)
            inventory.FromLobby.Value = nil
            inventory.Visible = false
        else
            bindChat(menuMain)
            menuMain.Visible = true
            inventory.Visible = false
            cameraRun:SetCameraByPart(workspace.cam_Main)
        end
    end)
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_inventory").MouseButton1Click:connect(function()
        menuMain.Visible = false
        inventory.Visible = true
        bindChat(inventory)
        cameraRun:SetCameraByPart(workspace.cam_Inventory)
    end)
    local function getClass()
        return Data.Inventory.Classes["Class " .. selectedProfile]
    end
    local function updateMainButtons()
        local class = getClass(selectedProfile)
        mainButtons.button_slotArmor.Image = gunInfo.weaponGFX[class.Armor] or ""
        mainButtons.button_slotEquipment.Image = gunInfo.weaponGFX[class.Equipment] or ""
        local maskStats = Data.Inventory.MyMaskStats
        mainButtons.button_slotMask.preview.Handle.Mesh.MeshId = maskStats[3] or ""
        local cam = mainButtons.button_slotMask.preview:FindFirstChild("cam")
        if cam == nil then
            cam = Instance.new("Camera")
            cam.Name = "cam"
            cam.Parent = mainButtons.button_slotMask.preview
            mainButtons.button_slotMask.preview.CurrentCamera = cam
        end
        cam.CFrame = CFrame.new(mainButtons.button_slotMask.preview.Handle.Position + mainButtons.button_slotMask.preview.Handle.CFrame.lookVector * 2.5, mainButtons.button_slotMask.preview.Handle.Position)
        mainButtons.button_slotMelee.Image = gunInfo.weaponGFX[class.Melee] or ""
        mainButtons.button_slotPrimary.Image = gunInfo.weaponGFX[class.Primary[1]] or ""
        mainButtons.button_slotSecondary.Image = gunInfo.weaponGFX[class.Secondary[1]] or ""
    end
    playerGui:WaitForChild("StatsChange").Event:connect(function()
        updateMainButtons()
    end)
    local function changeProfile(n)
        if selectedProfile == n then
            return
        end
        selectedProfile = n
        for i = 1, 3 do
            local button = inventory:WaitForChild("button_profile0" .. i)
            for _, v in pairs(button:GetChildren()) do
                if v.Name == "buttonBorder" then
                    v.BackgroundColor3 = n == i and Color3.new(0.3333333333333333, 1, 0) or Color3.new(0, 0.6666666666666666, 1)
                end
            end
        end
        updateMainButtons()
    end
    changeProfile(1)
    local wepSelect = UI:WaitForChild("frame_weaponSelect")
    local wepSelectStats = wepSelect:WaitForChild("frame_weaponStats")
    local wepSelectContainer = wepSelect:WaitForChild("frame_weaponsContainer")
    local wepSelectTitle = wepSelect:WaitForChild("frame_titleBar")
    local wepPurchase = UI:WaitForChild("frame_weaponPurchase")
    local wepPurchaseWeaponStats = wepPurchase:WaitForChild("frame_weaponStats")
    local wepPurchaseWeaponContainer = wepPurchase:WaitForChild("frame_weaponsContainer")
    local wepPurchaseListing = wepPurchaseWeaponContainer:WaitForChild("weaponListing01")
    wepPurchaseListing.Parent = nil
    local wepSelectListing = wepSelectContainer:WaitForChild("weaponListing01")
    wepSelectListing.Parent = nil
    local currentCategory = "Primary"
    local selectedButton
    local modCategory = "Silencer"
    local modTypes = {
        Jungle = "Silencers",
        ["Interceptor .45"] = "Silencers",
        ["Micro-9mm"] = "Silencers",
        ["Osprey .45"] = "Silencers",
        ["Oil Filter"] = "Silencers",
        ["Kobra Scope"] = "Sights",
        ["ACOG Scope"] = "Sights",
        ["Reflex Scope"] = "Sights",
        ["HAMR Scope"] = "Sights",
        ["EOTech Scope"] = "Sights"
    }
    local wepMod = UI:WaitForChild("frame_weaponModify")
    local wepModContainer = wepMod:WaitForChild("frame_modContainer")
    local wepModStats = wepMod:WaitForChild("frame_statsContainer")
    local addZeroes = function(commanumber)
        local n = false
        if commanumber:sub(1, 1) == "-" then
            n = true
            commanumber = commanumber:sub(2)
        end
        while commanumber:len() < 3 do
            commanumber = "0" .. commanumber
        end
        return n and "-" .. commanumber or commanumber
    end
    local function numberDisplay(n)
        return addZeroes(shortenDecimals(convertToCommas(n)))
    end
    local function updateConcealment()
        local dtect, conceal = game:GetService("ReplicatedStorage"):WaitForChild("UpdateConcealment"):InvokeServer("Class " .. selectedProfile)
        local progress = dtect / 75 * 60
        local color = Color3.new(progress * 4 / 255, 0.6666666666666666, (255 - progress * 5) / 255)
        wepSelectStats.text_labelDetection.text_detectionAmount.Text = dtect
        wepPurchaseWeaponStats.text_labelDetection.text_detectionAmount.Text = dtect
        wepMod.frame_riskContainer.text_labelDetection.text_detectionAmount.Text = dtect
        wepSelectStats.text_labelDetection.text_detectionAmount.TextColor3 = color
        wepPurchaseWeaponStats.text_labelDetection.text_detectionAmount.TextColor3 = color
        wepMod.frame_riskContainer.text_labelDetection.text_detectionAmount.TextColor3 = color
        mainStats.text_labelDetection.text_detectionAmount.Text = dtect
        mainStats.text_labelDetection.text_detectionAmount.TextColor3 = color
        local withoutUniversal = conceal
        if hasSkill("G", "O") then
            withoutUniversal = withoutUniversal - 2
            mainStats.text_statConcealment.text_statSkill.Text = numberDisplay(2)
        else
            mainStats.text_statConcealment.text_statSkill.Text = numberDisplay(0)
        end
        mainStats.text_statConcealment.text_statBase.Text = numberDisplay(withoutUniversal)
        mainStats.text_statConcealment.text_statTotal.Text = numberDisplay(conceal)
        return dtect, conceal
    end
    local function showWeaponStats(frame, baseName, mods, toPurchase)
        local isGun = currentCategory == "Primary" or currentCategory == "Secondary"
        local gunData
        if game:GetService("ReplicatedStorage"):WaitForChild("NewWeapons"):FindFirstChild(baseName) then
            gunData = require(game:GetService("ReplicatedStorage"):WaitForChild("NewWeapons"):FindFirstChild(baseName):WaitForChild("Data"))
        end
        if isGun then
            local baseAccuracy = calculateBaseAccuracy(gunData)
            local baseFireRate = calculateBaseFireRate(gunData)
            local baseReserve = gunData.AmmoMax
            local baseStability = calculateBaseStability(gunData)
            local baseMagazine = gunData.MagazineSize
            frame.text_statAccuracy.text_statBase.Text = numberDisplay(baseAccuracy)
            frame.text_statFireRate.text_statBase.Text = numberDisplay(baseFireRate)
            frame.text_statReserve.text_statBase.Text = numberDisplay(baseReserve)
            frame.text_statStability.text_statBase.Text = numberDisplay(baseStability)
            frame.text_statMagazine.text_statBase.Text = numberDisplay(baseMagazine)
            local modAccuracy = calculateAttachmentAccuracy(gunData, mods)
            local modFireRate = calculateAttachmentFireRate(gunData, mods)
            local modReserve = 0
            local modStability = calculateAttachmentStability(gunData, mods)
            local modMagazine = 0
            frame.text_statAccuracy.text_statMod.Text = numberDisplay(modAccuracy)
            frame.text_statFireRate.text_statMod.Text = numberDisplay(modFireRate)
            frame.text_statReserve.text_statMod.Text = numberDisplay(modReserve)
            frame.text_statStability.text_statMod.Text = numberDisplay(modStability)
            frame.text_statMagazine.text_statMod.Text = numberDisplay(modMagazine)
            local skillAccuracy = calculateSkillAccuracy(baseName, gunData, mods)
            local skillFireRate = calculateSkillFireRate(baseName, gunData, mods)
            local skillReserve = calculateSkillReserve(baseName, gunData, mods)
            local skillStability = calculateSkillStability(baseName, gunData, mods)
            local skillMagazine = calculateSkillMagazine(baseName, gunData, mods)
            frame.text_statAccuracy.text_statSkill.Text = numberDisplay(skillAccuracy)
            frame.text_statFireRate.text_statSkill.Text = numberDisplay(skillFireRate)
            frame.text_statReserve.text_statSkill.Text = numberDisplay(skillReserve)
            frame.text_statStability.text_statSkill.Text = numberDisplay(skillStability)
            frame.text_statMagazine.text_statSkill.Text = numberDisplay(skillMagazine)
            frame.text_statAccuracy.text_statTotal.Text = numberDisplay(baseAccuracy + modAccuracy + skillAccuracy)
            frame.text_statFireRate.text_statTotal.Text = numberDisplay(baseFireRate + modFireRate + skillFireRate)
            frame.text_statReserve.text_statTotal.Text = numberDisplay(baseReserve + modReserve + skillReserve)
            frame.text_statStability.text_statTotal.Text = numberDisplay(baseStability + modStability + skillStability)
            frame.text_statMagazine.text_statTotal.Text = numberDisplay(baseMagazine + modMagazine + skillMagazine)
        else
            frame.text_statAccuracy.text_statBase.Text = "---"
            frame.text_statFireRate.text_statBase.Text = "---"
            frame.text_statReserve.text_statBase.Text = "---"
            frame.text_statStability.text_statBase.Text = "---"
            frame.text_statMagazine.text_statBase.Text = "---"
            frame.text_statAccuracy.text_statMod.Text = "---"
            frame.text_statFireRate.text_statMod.Text = "---"
            frame.text_statReserve.text_statMod.Text = "---"
            frame.text_statStability.text_statMod.Text = "---"
            frame.text_statMagazine.text_statMod.Text = "---"
            frame.text_statAccuracy.text_statSkill.Text = "---"
            frame.text_statFireRate.text_statSkill.Text = "---"
            frame.text_statReserve.text_statSkill.Text = "---"
            frame.text_statStability.text_statSkill.Text = "---"
            frame.text_statMagazine.text_statSkill.Text = "---"
            frame.text_statAccuracy.text_statTotal.Text = "---"
            frame.text_statFireRate.text_statTotal.Text = "---"
            frame.text_statReserve.text_statTotal.Text = "---"
            frame.text_statStability.text_statTotal.Text = "---"
            frame.text_statMagazine.text_statTotal.Text = "---"
        end
        if gunData then
            local baseDamage = gunData.Damage
            frame.text_statDamage.text_statBase.Text = numberDisplay(baseDamage)
            local modDamage = calculateAttachmentDamage(gunData, mods)
            frame.text_statDamage.text_statMod.Text = numberDisplay(modDamage)
            local skillDamage = calculateSkillDamage(baseName, gunData, mods)
            frame.text_statDamage.text_statSkill.Text = numberDisplay(skillDamage)
            frame.text_statDamage.text_statTotal.Text = numberDisplay(baseDamage + modDamage + skillDamage)
        else
            frame.text_statDamage.text_statBase.Text = "---"
            frame.text_statDamage.text_statMod.Text = "---"
            frame.text_statDamage.text_statSkill.Text = "---"
            frame.text_statDamage.text_statTotal.Text = "---"
        end
        if currentCategory == "Equipment" then
            frame.text_statConcealment.text_statBase.Text = "---"
            frame.text_statConcealment.text_statMod.Text = "---"
            frame.text_statConcealment.text_statSkill.Text = "---"
            frame.text_statConcealment.text_statTotal.Text = "---"
        else
            local baseConcealment = calculateBaseConcealment(baseName)
            frame.text_statConcealment.text_statBase.Text = numberDisplay(baseConcealment)
            local modConcealment = calculateAttachmentConcealment(baseName, mods)
            frame.text_statConcealment.text_statMod.Text = numberDisplay(modConcealment)
            local skillConcealment = calculateSkillConcealment(baseName, gunData, mods)
            frame.text_statConcealment.text_statSkill.Text = numberDisplay(skillConcealment)
            frame.text_statConcealment.text_statTotal.Text = numberDisplay(baseConcealment + modConcealment + skillConcealment)
        end
        frame.weaponTitle.Text = baseName
        frame.weaponValue.Text = toPurchase and "$" .. convertToCommas(gunInfo.weaponPrices[baseName]) or "$" .. convertToCommas(math.ceil(gunInfo.weaponPrices[baseName] * 0.4) + 0 + 0)
    end
    local modSample = wepModContainer:WaitForChild("01_sample")
    modSample.Parent = nil
    local function showGun(ownedWeaponEntryName)
        local name, id = getNameFromOwned(ownedWeaponEntryName)
        for _, v in pairs(CollectionService:GetTagged("WeaponPreview")) do
            v:Destroy()
        end
        local gun = game:GetService("ReplicatedStorage"):WaitForChild("NewWeapons"):FindFirstChild(name):Clone()
        local model = Instance.new("Model")
        for _, v in pairs(gun:GetChildren()) do
            if v:IsA("BasePart") then
                local removed = false
                if CollectionService:HasTag(v, "Attachment") and not Data.Inventory.OwnedWeapons[ownedWeaponEntryName].Attachments[v.Name] then
                    v:Destroy()
                    removed = true
                end
                if not removed then
                    v.Parent = model
                    v.Anchored = true
                end
            end
        end
        model.PrimaryPart = model:FindFirstChild("Handle")
        model.Parent = workspace
        gun:Destroy()
        CollectionService:AddTag(model, "WeaponPreview")
        local con
        local angle = 0
        con = game:GetService("RunService").RenderStepped:connect(function()
            if model and model.Parent then
                model:SetPrimaryPartCFrame((workspace.CurrentCamera.CFrame + workspace.CurrentCamera.CFrame.LookVector * 5) * CFrame.Angles(0, math.rad(angle), 0))
                angle = angle + 1
                if angle >= 360 then
                    angle = angle - 360
                end
            else
                con:Disconnect()
            end
        end)
    end
    local function displayModStats(modName, base, change, highIsGood)
        local label = wepModStats["text_stat" .. modName]
        label.modValue.Text = shortenDecimals(convertToCommas(change))
        if change > 0 then
            label.modValue.Text = "+" .. label.modValue.Text
        end
        if change > 0 and highIsGood then
            label.modValue.TextColor3 = Color3.new(0, 1, 0)
        elseif change < 0 and highIsGood then
            label.modValue.TextColor3 = Color3.new(1, 0, 0)
        elseif change > 0 and not highIsGood then
            label.modValue.TextColor3 = Color3.new(1, 0, 0)
        elseif change < 0 and not highIsGood then
            label.modValue.TextColor3 = Color3.new(0, 1, 0)
        else
            label.modValue.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        end
        label.statValue.Text = shortenDecimals(convertToCommas(base + change))
    end
    local function updateModButtons(currentEquipped)
        for _, v in pairs(CollectionService:GetTagged("Mods")) do
            if v == currentEquipped then
                v.button_modEquip.Visible = true
                v.button_modEquip.buttonText.Text = "REMOVE"
                v.button_modEquip.BackgroundColor3 = Color3.new(0.6666666666666666, 0, 0)
                v.modTick.Visible = true
            elseif currentEquipped then
                v.button_modEquip.Visible = false
                v.modTick.Visible = false
            else
                v.button_modEquip.Visible = true
                v.modTick.Visible = false
                if Data.Inventory.OwnedMods[v.Name] and Data.Inventory.OwnedMods[v.Name] then
                    v.button_modEquip.buttonText.Text = "EQUIP"
                    v.button_modEquip.BackgroundColor3 = Color3.new(0, 1, 0.4980392156862745)
                else
                    v.button_modEquip.buttonText.Text = "PURCHASE [$" .. convertToCommas(gunInfo.AttachmentInfo[v.Name].Price) .. "]"
                    v.button_modEquip.BackgroundColor3 = Color3.new(0, 0.49019607843137253, 0.23529411764705882)
                end
            end
        end
        local gunData
        if game:GetService("ReplicatedStorage"):WaitForChild("NewWeapons"):FindFirstChild(selectedButton.Name) then
            gunData = require(game:GetService("ReplicatedStorage"):WaitForChild("NewWeapons"):FindFirstChild(selectedButton.Name):WaitForChild("Data"))
        end
        if gunData then
            local mods = Data.Inventory.OwnedWeapons["(" .. selectedButton.Name .. ")" .. selectedButton.ID.Value].Attachments
            local baseAccuracy = calculateBaseAccuracy(gunData) + calculateSkillAccuracy(selectedButton.Name, gunData, mods)
            local baseStability = calculateBaseStability(gunData) + calculateSkillStability(selectedButton.Name, gunData, mods)
            local baseDamage = gunData.Damage + calculateSkillDamage(selectedButton.Name, gunData, mods)
            local baseMagazine = gunData.MagazineSize + calculateSkillMagazine(selectedButton.Name, gunData, mods)
            local baseReserve = gunData.AmmoMax + calculateSkillReserve(selectedButton.Name, gunData, mods)
            local baseConcealment = calculateBaseConcealment(selectedButton.Name) + calculateSkillConcealment(selectedButton.Name, gunData, mods)
            local baseFireRate = calculateBaseFireRate(gunData) + calculateSkillFireRate(selectedButton.Name, gunData, mods)
            local modAccuracy = calculateAttachmentAccuracy(gunData, mods)
            local modStability = calculateAttachmentStability(gunData, mods)
            local modDamage = calculateAttachmentDamage(gunData, mods)
            local modMagazine = 0
            local modReserve = 0
            local modConcealment = calculateAttachmentConcealment(selectedButton.Name, mods)
            local modFireRate = calculateAttachmentFireRate(gunData, mods)
            displayModStats("Accuracy", baseAccuracy, modAccuracy, true)
            displayModStats("Stability", baseStability, modStability, true)
            displayModStats("Damage", baseDamage, modDamage, true)
            displayModStats("Mag", baseMagazine, modMagazine, true)
            displayModStats("Reserve", baseReserve, modReserve, true)
            displayModStats("Conceal", baseConcealment, modConcealment, true)
            displayModStats("RPM", baseFireRate, modFireRate, true)
        end
    end
    local modImages = {
        ["ACOG Scope"] = "rbxassetid://2867282280",
        ["EOTech Scope"] = "rbxassetid://2867282506",
        ["HAMR Scope"] = "rbxassetid://2867282776",
        ["Kobra Scope"] = "rbxassetid://2867283033",
        ["Reflex Scope"] = "rbxassetid://2867283314",
        Jungle = "rbxassetid://2867281310",
        ["Micro-9mm"] = "rbxassetid://2867281551",
        ["Osprey .45"] = "rbxassetid://2867282042",
        ["Oil Filter"] = "rbxassetid://2867281812",
        ["Interceptor .45"] = "rbxassetid://2867280976"
    }
    local function setModCategory(category)
        if selectedButton == nil then
            return
        end
        wepModContainer.text_modCategory.Text = category
        local name = selectedButton.Name
        local id = selectedButton.ID.Value
        local reference = Data.Inventory.OwnedWeapons["(" .. name .. ")" .. id].Attachments
        local gunModel = game:GetService("ReplicatedStorage"):WaitForChild("NewWeapons"):FindFirstChild(name)
        modCategory = category
        for _, v in pairs(CollectionService:GetTagged("Mods")) do
            v:Destroy()
        end
        local n = 0
        local currentEquipped
        for k, v in pairs(modTypes) do
            if v == modCategory and gunModel:FindFirstChild(k) then
                do
                    local entry = modSample:Clone()
                    entry.Position = UDim2.new(0.02 + 0.192 * n, 0, 0, 0)
                    entry.modImage.Image = modImages[k]
                    local isEquipped = reference[k]
                    entry.modTick.Visible = isEquipped
                    entry.Name = k
                    if isEquipped then
                        currentEquipped = entry
                    end
                    local price = gunInfo.AttachmentInfo[k].Price
                    entry.modName.Text = k
                    CollectionService:AddTag(entry, "Mods")
                    entry.Parent = wepModContainer
                    entry.button_modEquip.MouseButton1Click:Connect(function()
                        if currentEquipped == entry then
                            currentEquipped = nil
                            Data.Inventory.OwnedWeapons["(" .. name .. ")" .. id].Attachments[k] = nil
                            if Data.Inventory.OwnedMods[k] == nil then
                                Data.Inventory.OwnedMods[k] = 1
                            else
                                Data.Inventory.OwnedMods[k] = Data.Inventory.OwnedMods[k] + 1
                            end
                            for className, contents in pairs(Data.Inventory.Classes) do
                                if contents.Primary[1] == name and contents.Primary[2] == id then
                                    Data.Inventory.Classes[className].Attach1 = Data.Inventory.OwnedWeapons["(" .. name .. ")" .. id].Attachments
                                elseif contents.Secondary[1] == name and contents.Secondary[2] == id then
                                    Data.Inventory.Classes[className].Attach2 = Data.Inventory.OwnedWeapons["(" .. name .. ")" .. id].Attachments
                                end
                            end
                            game:GetService("ReplicatedStorage").RemoveModFromWeapon:FireServer(name, id, k)
                            updateModButtons(currentEquipped)
                            showGun("(" .. name .. ")" .. id)
                            delay(0.25, function()
                                updateConcealment()
                            end)
                        elseif currentEquipped == nil then
                            if Data.Inventory.OwnedMods[k] and Data.Inventory.OwnedMods[k] > 0 then
                                currentEquipped = entry
                                Data.Inventory.OwnedMods[k] = Data.Inventory.OwnedMods[k] - 1
                                if Data.Inventory.OwnedMods[k] <= 0 then
                                    Data.Inventory.OwnedMods[k] = nil
                                end
                                Data.Inventory.OwnedWeapons["(" .. name .. ")" .. id].Attachments[k] = true
                                for className, contents in pairs(Data.Inventory.Classes) do
                                    if contents.Primary[1] == name and contents.Primary[2] == id then
                                        Data.Inventory.Classes[className].Attach1 = Data.Inventory.OwnedWeapons["(" .. name .. ")" .. id].Attachments
                                    elseif contents.Secondary[1] == name and contents.Secondary[2] == id then
                                        Data.Inventory.Classes[className].Attach2 = Data.Inventory.OwnedWeapons["(" .. name .. ")" .. id].Attachments
                                    end
                                end
                                game:GetService("ReplicatedStorage").AddModToWeapon:FireServer(name, id, k)
                                updateModButtons(currentEquipped)
                                showGun("(" .. name .. ")" .. id)
                                delay(0.25, function()
                                    updateConcealment()
                                end)
                            elseif Data.Inventory.Cash >= price then
                                Data.Inventory.Cash = Data.Inventory.Cash - price
                                if Data.Inventory.OwnedMods[k] == nil then
                                    Data.Inventory.OwnedMods[k] = 1
                                else
                                    Data.Inventory.OwnedMods[k] = Data.Inventory.OwnedMods[k] + 1
                                end
                                game:GetService("ReplicatedStorage").PurchaseWeaponMod:FireServer(k)
                                updateModButtons(currentEquipped)
                            end
                        end
                    end)
                    n = n + 1
                end
            end
        end
        updateModButtons(currentEquipped)
    end
    local modCats = {"Silencers", "Sights"}
    local myCat = 1
    wepModContainer:WaitForChild("text_modCategory"):WaitForChild("button_catLeft").MouseButton1Click:connect(function()
        myCat = myCat - 1
        if myCat <= 0 then
            myCat = #modCats
        end
        setModCategory(modCats[myCat])
    end)
    wepModContainer:WaitForChild("text_modCategory"):WaitForChild("button_catRight").MouseButton1Click:connect(function()
        myCat = myCat + 1
        if myCat > #modCats then
            myCat = 1
        end
        setModCategory(modCats[myCat])
    end)
    wepSelectContainer:WaitForChild("UIGridLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        local frameAbsoluteSize = wepSelectContainer.AbsoluteSize
        wepSelectContainer.UIGridLayout.CellSize = UDim2.new(0, frameAbsoluteSize.X / 5 - 30 + 0.015 * frameAbsoluteSize.X / 2, 0, 92)
        wepSelectContainer.CanvasSize = UDim2.new(0, 0, 0, wepSelectContainer.UIGridLayout.AbsoluteContentSize.Y)
    end)
    local equippedString = ""
    local equippedId = -1
    local function updateWeaponSelectionView(category)
        currentCategory = category
        wepSelectTitle:WaitForChild("text_menuTitle").Text = "Inventory: " .. category
        for _, v in pairs(CollectionService:GetTagged("WepSelectListing")) do
            v:Destroy()
        end
        local isGun = category == "Primary" or category == "Secondary"
        equippedString = isGun and Data.Inventory.Classes["Class " .. selectedProfile][category][1] or Data.Inventory.Classes["Class " .. selectedProfile][category]
        equippedId = isGun and Data.Inventory.Classes["Class " .. selectedProfile][category][2] or -1
        local first = false
        if isGun then
            wepSelect.button_wepModify.Visible = true
        else
            wepSelect.button_wepModify.Visible = false
        end
        for k, v in pairs(Data.Inventory.OwnedWeapons) do
            do
                local name, gid = getNameFromOwned(k)
                local category = gunInfo.weaponTypes[name]
                if category == currentCategory then
                    do
                        local entry = wepSelectListing:clone()
                        CollectionService:AddTag(entry, "WepSelectListing")
                        entry.Parent = wepSelectContainer
                        entry.weaponImage.Image = gunInfo.weaponGFX[name]
                        local classes = ""
                        if isGun then
                            for i, q in pairs(gunInfo.weaponClass[name]) do
                                classes = classes .. q .. (i == #gunInfo.weaponClass[name] and "" or ", ")
                            end
                        end
                        entry.weaponClass.Text = classes
                        entry.weaponTitle.Text = name
                        entry.Name = name
                        entry.ID.Value = gid
                        if name == equippedString and (equippedId == -1 or equippedId == tonumber(gid)) then
                            entry.weaponTitle.TextColor3 = Color3.new(0, 0.4980392156862745, 1)
                            CollectionService:AddTag(entry, "Using!")
                        end
                        entry.MouseButton1Click:connect(function()
                            if selectedButton == entry then
                                return
                            end
                            selectedButton = entry
                            local tween = TweenService:Create(entry, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                BorderSizePixel = 5,
                                BorderColor3 = Color3.new(0, 1, 1)
                            })
                            tween:Play()
                            tween.Completed:connect(function()
                                if selectedButton ~= entry then
                                    entry.BorderSizePixel = 1
                                    entry.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
                                end
                            end)
                            showWeaponStats(wepSelectStats, name, v.Attachments)
                            for _, e in pairs(CollectionService:GetTagged("WepSelectListing")) do
                                if e ~= entry then
                                    e.BorderSizePixel = 1
                                    e.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
                                end
                            end
                            local cansell = true
                            for i = 1, 3 do
                                local d = Data.Inventory.Classes["Class " .. i][category]
                                if isGun and d[1] == name and tostring(d[2]) == gid then
                                    cansell = false
                                    break
                                end
                            end
                            if cansell then
                                wepSelect.button_wepSell.Visible = true
                            else
                                wepSelect.button_wepSell.Visible = false
                            end
                        end)
                        if not first then
                            first = true
                            selectedButton = entry
                            entry.BorderSizePixel = 5
                            entry.BorderColor3 = Color3.new(0, 1, 1)
                            showWeaponStats(wepSelectStats, name, v.Attachments)
                            if CollectionService:HasTag(entry, "Using!") then
                                wepSelect.button_wepSell.Visible = false
                            else
                                wepSelect.button_wepSell.Visible = true
                            end
                        end
                    end
                end
            end
        end
        if not first then
            wepSelectStats.Visible = false
            wepSelect.button_wepEquip.Visible = false
            wepSelect.button_wepSell.Visible = false
            wepSelect.button_wepModify.Visible = false
        else
            wepSelectStats.Visible = true
        end
        updateConcealment()
    end
    wepPurchaseWeaponContainer:WaitForChild("UIGridLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        local frameAbsoluteSize = wepPurchaseWeaponContainer.AbsoluteSize
        wepPurchaseWeaponContainer.UIGridLayout.CellSize = UDim2.new(0, frameAbsoluteSize.X / 5 - 30 + 0.015 * frameAbsoluteSize.X / 2, 0, 92)
        wepPurchaseWeaponContainer.CanvasSize = UDim2.new(0, 0, 0, wepPurchaseWeaponContainer.UIGridLayout.AbsoluteContentSize.Y)
    end)
    local MarketplaceService = game:GetService("MarketplaceService")
    local function updatePurchaseSelectionView(allowRepeats, defaultSelectionName)
        wepSelectTitle:WaitForChild("text_menuTitle").Text = "Inventory: " .. currentCategory
        for _, v in pairs(CollectionService:GetTagged("WepPurchaseListing")) do
            v:Destroy()
        end
        local first = false
        for k, v in pairs(gunInfo.weaponTypes) do
            if v == currentCategory then
                local allowed = true
                if not allowRepeats then
                    for n, _ in pairs(Data.Inventory.OwnedWeapons) do
                        local name = getNameFromOwned(n)
                        if name == k then
                            allowed = false
                        end
                    end
                end
                if allowed then
                    do
                        local entry = wepPurchaseListing:clone()
                        CollectionService:AddTag(entry, "WepPurchaseListing")
                        entry.weaponImage.Image = gunInfo.weaponGFX[k]
                        local order = gunInfo.weaponPrices[k]
                        local hasDLC = true
                        if gunInfo.weaponLevels[k] < 0 then
                            local s, m = pcall(function()
                                hasDLC = MarketplaceService:UserOwnsGamePassAsync(player.UserId, -gunInfo.weaponLevels[k])
                            end)
                            if not s then
                                hasDLC = false
                                warn(m)
                            end
                        end
                        if hasDLC then
                            if Data.Inventory.Level < gunInfo.weaponLevels[k] and #Data.Inventory.Infamy == 0 then
                                entry.weaponPrice.Text = "Requires Level " .. gunInfo.weaponLevels[k]
                                entry.weaponPrice.TextColor3 = Color3.new(0, 1, 1)
                                order = 555555555 + gunInfo.weaponLevels[k]
                            else
                                entry.weaponPrice.Text = "$" .. convertToCommas(gunInfo.weaponPrices[k])
                            end
                        else
                            entry.weaponPrice.Text = "Requires Gamepass"
                            entry.weaponPrice.TextColor3 = Color3.new(0.7, 0, 0)
                            order = order + 999999999
                        end
                        entry.weaponTitle.Text = k
                        entry.Name = k
                        entry.LayoutOrder = order
                        entry.MouseButton1Click:connect(function()
                            if selectedButton == entry then
                                return
                            end
                            selectedButton = entry
                            local tween = TweenService:Create(entry, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                BorderSizePixel = 5,
                                BorderColor3 = Color3.new(0, 1, 1)
                            })
                            tween:Play()
                            tween.Completed:connect(function()
                                if selectedButton ~= entry then
                                    entry.BorderSizePixel = 1
                                    entry.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
                                end
                            end)
                            showWeaponStats(wepPurchaseWeaponStats, k, {}, true)
                            for _, e in pairs(CollectionService:GetTagged("WepPurchaseListing")) do
                                if e ~= entry then
                                    e.BorderSizePixel = 1
                                    e.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
                                end
                            end
                            wepPurchase.button_wepBuy.Visible = false
                            wepPurchase.button_wepPurchaseEquip.Visible = false
                            if hasDLC then
                                if gunInfo.weaponPrices[k] <= Data.Inventory.Cash then
                                    if gunInfo.weaponLevels[k] <= Data.Inventory.Level or 0 < #Data.Inventory.Infamy then
                                        wepPurchase.button_wepPurchaseEquip.Visible = true
                                        wepPurchase.button_wepBuy.buttonText.Text = "PURCHASE"
                                    else
                                        wepPurchase.button_wepBuy.buttonText.Text = "Requires Level " .. convertToCommas(gunInfo.weaponLevels[k])
                                    end
                                else
                                    wepPurchase.button_wepBuy.buttonText.Text = "Insufficient Funds"
                                end
                            else
                                wepPurchase.button_wepBuy.buttonText.Text = "Requires Gamepass"
                            end
                            wepPurchase.button_wepBuy.Visible = true
                        end)
                        entry.Parent = wepPurchaseWeaponContainer
                    end
                end
            end
        end
        local lowest
        local lowestValue = math.huge
        local override = false
        if defaultSelectionName then
            for _, v in pairs(CollectionService:GetTagged("WepPurchaseListing")) do
                if v.Name == defaultSelectionName then
                    lowest = v
                    override = true
                    break
                end
            end
        end
        for _, v in pairs(CollectionService:GetTagged("WepPurchaseListing")) do
            if override then
                break
            end
            if v:IsA("ImageButton") and lowestValue > v.LayoutOrder then
                lowestValue = v.LayoutOrder
                lowest = v
            end
        end
        if lowest then
            do
                local tween = TweenService:Create(lowest, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    BorderSizePixel = 5,
                    BorderColor3 = Color3.new(0, 1, 1)
                })
                tween:Play()
                selectedButton = lowest
                wepPurchaseWeaponStats.Visible = true
                wepPurchase.button_wepBuy.Visible = true
                wepPurchase.button_wepPurchaseEquip.Visible = true
                showWeaponStats(wepPurchaseWeaponStats, lowest.weaponTitle.Text, {}, true)
                wepPurchase.button_wepBuy.Visible = false
                wepPurchase.button_wepPurchaseEquip.Visible = false
                local hasDLC = true
                if 0 > gunInfo.weaponLevels[lowest.Name] then
                    local s, m = pcall(function()
                        hasDLC = MarketplaceService:UserOwnsGamePassAsync(player.UserId, -gunInfo.weaponLevels[lowest.Name])
                    end)
                    if not s then
                        hasDLC = false
                        warn(m)
                    end
                end
                if hasDLC then
                    if gunInfo.weaponPrices[lowest.Name] <= Data.Inventory.Cash then
                        if gunInfo.weaponLevels[lowest.Name] <= Data.Inventory.Level or 0 < #Data.Inventory.Infamy then
                            wepPurchase.button_wepPurchaseEquip.Visible = true
                            wepPurchase.button_wepBuy.buttonText.Text = "PURCHASE"
                        else
                            wepPurchase.button_wepBuy.buttonText.Text = "Requires Level " .. convertToCommas(gunInfo.weaponLevels[lowest.Name])
                        end
                    else
                        wepPurchase.button_wepBuy.buttonText.Text = "Insufficient Funds"
                    end
                else
                    wepPurchase.button_wepBuy.buttonText.Text = "Requires Gamepass"
                end
                wepPurchase.button_wepBuy.Visible = true
            end
        else
            wepPurchaseWeaponStats.Visible = false
            wepPurchase.button_wepBuy.Visible = false
            wepPurchase.button_wepPurchaseEquip.Visible = false
        end
    end
    MarketplaceService.PromptGamePassPurchaseFinished:connect(function(playerObj, id, purchased)
        if player == playerObj then
            print("Player attempted to purchase GamePass. Success = " .. tostring(purchased))
            wait(0.25)
            updatePurchaseSelectionView(currentCategory ~= "Equipment" and currentCategory ~= "Melee" and currentCategory ~= "Armor", selectedButton and selectedButton.Name or nil)
        end
    end)
    wepSelectContainer:WaitForChild("purchaseWeapon").MouseButton1Click:connect(function()
        local noRepeats = currentCategory == "Equipment" or currentCategory == "Melee" or currentCategory == "Armor"
        updatePurchaseSelectionView(not noRepeats)
        wepPurchase.frame_titleBar.text_menuTitle.Text = "Purchase: " .. currentCategory
        wepPurchase.Visible = true
        wepSelect.Visible = false
    end)
    wepPurchase:WaitForChild("button_wepBack").MouseButton1Click:connect(function()
        wepPurchase.Visible = false
        wepSelect.Visible = true
    end)
    local function buyGun(gunName)
        Data.Inventory.Cash = Data.Inventory.Cash - gunInfo.weaponPrices[gunName]
        local idnum = 0
        local smallestCurrent = 0
        local matches = {}
        for n, v in pairs(Data.Inventory.OwnedWeapons) do
            if getNameFromOwned(n) == gunName then
                table.insert(matches, v.ID)
            end
        end
        if #matches > 0 then
            local min = math.huge
            for _, n in pairs(matches) do
                min = math.min(min, n)
            end
            smallestCurrent = min
        end
        if smallestCurrent > 0 then
            idnum = 0
        else
            local correct = true
            repeat
                correct = true
                smallestCurrent = smallestCurrent + 1
                for _, v in pairs(matches) do
                    if smallestCurrent == v then
                        correct = false
                    end
                end
            until correct
            idnum = smallestCurrent
        end
        Data.Inventory.OwnedWeapons["(" .. gunName .. ")" .. idnum] = {
            Skin = "",
            Attachments = {},
            ID = idnum
        }
        return idnum
    end
    wepPurchase:WaitForChild("button_wepBuy").MouseButton1Click:connect(function()
        if selectedButton then
            do
                local name = selectedButton.Name
                local reqMoney = gunInfo.weaponPrices[name]
                local reqLevel = gunInfo.weaponLevels[name]
                if reqMoney and reqLevel then
                    do
                        local hasDLC = true
                        if reqLevel < 0 then
                            local s, m = pcall(function()
                                hasDLC = MarketplaceService:UserOwnsGamePassAsync(player.UserId, -reqLevel)
                            end)
                            if not s then
                                hasDLC = false
                                warn(m)
                            end
                        end
                        if not hasDLC then
                            MarketplaceService:PromptGamePassPurchase(player, -reqLevel)
                        else
                            if 0 < #Data.Inventory.Infamy and reqLevel > 0 then
                                reqLevel = 0
                            end
                            if reqLevel <= Data.Inventory.Level and reqMoney <= Data.Inventory.Cash then
                                if currentCategory == "Primary" or currentCategory == "Secondary" then
                                    game:GetService("ReplicatedStorage").BuyGun:FireServer(name)
                                    local id = buyGun(name)
                                else
                                    Data.Inventory.Cash = Data.Inventory.Cash - gunInfo.weaponPrices[name]
                                    Data.Inventory.OwnedWeapons["(" .. name .. ")0"] = {
                                        Skin = "",
                                        Attachments = {},
                                        ID = 0
                                    }
                                    game:GetService("ReplicatedStorage").BuyArmor:FireServer(name)
                                end
                                updateWeaponSelectionView(currentCategory)
                                updatePurchaseSelectionView(currentCategory ~= "Equipment" and currentCategory ~= "Melee" and currentCategory ~= "Armor", selectedButton.Name)
                                playerGui:WaitForChild("StatsChange"):Fire()
                            end
                        end
                    end
                end
            end
        end
    end)
    wepPurchase:WaitForChild("button_wepPurchaseEquip").MouseButton1Click:connect(function()
        if selectedButton then
            do
                local name = selectedButton.Name
                local reqMoney = gunInfo.weaponPrices[name]
                local reqLevel = gunInfo.weaponLevels[name]
                if reqMoney and reqLevel then
                    do
                        local hasDLC = true
                        if reqLevel < 0 then
                            local s, m = pcall(function()
                                hasDLC = MarketplaceService:UserOwnsGamePassAsync(player.UserId, -reqLevel)
                            end)
                            if not s then
                                hasDLC = false
                                warn(m)
                            end
                        end
                        if not hasDLC then
                            MarketplaceService:PromptGamePassPurchase(player, -reqLevel)
                        else
                            if 0 < #Data.Inventory.Infamy and reqLevel > 0 then
                                reqLevel = 0
                            end
                            if reqLevel <= Data.Inventory.Level and reqMoney <= Data.Inventory.Cash then
                                if currentCategory == "Primary" or currentCategory == "Secondary" then
                                    game:GetService("ReplicatedStorage").BuyGun:FireServer(name)
                                    do
                                        local id = buyGun(name)
                                        local attachid = gunInfo.weaponTypes[name] == "Primary" and 1 or 2
                                        local slotid = attachid == 1 and "Primary" or "Secondary"
                                        Data.Inventory.Classes["Class " .. selectedProfile][slotid] = {
                                            name,
                                            id,
                                            ""
                                        }
                                        Data.Inventory.Classes["Class " .. selectedProfile]["Attach" .. attachid] = {}
                                        delay(0.25, function()
                                            game:GetService("ReplicatedStorage").SetGunForClass:FireServer("Class " .. selectedProfile, name, id)
                                        end)
                                    end
                                elseif currentCategory == "Armor" then
                                    game:GetService("ReplicatedStorage").BuyArmor:FireServer(name)
                                    Data.Inventory.OwnedWeapons["(" .. name .. ")0"] = {
                                        Skin = "",
                                        Attachments = {},
                                        ID = 0
                                    }
                                    Data.Inventory.Classes["Class " .. selectedProfile].Armor = name
                                    delay(0.25, function()
                                        game:GetService("ReplicatedStorage").SetArmorForClass:FireServer("Class " .. selectedProfile, name, 0)
                                    end)
                                elseif currentCategory == "Equipment" then
                                    game:GetService("ReplicatedStorage").BuyArmor:FireServer(name)
                                    Data.Inventory.OwnedWeapons["(" .. name .. ")0"] = {
                                        Skin = "",
                                        Attachments = {},
                                        ID = 0
                                    }
                                    Data.Inventory.Classes["Class " .. selectedProfile].Equipment = name
                                    delay(0.25, function()
                                        game:GetService("ReplicatedStorage").SetEquipmentForClass:FireServer("Class " .. selectedProfile, name, 0)
                                    end)
                                elseif currentCategory == "Melee" then
                                    game:GetService("ReplicatedStorage").BuyArmor:FireServer(name)
                                    Data.Inventory.OwnedWeapons["(" .. name .. ")0"] = {
                                        Skin = "",
                                        Attachments = {},
                                        ID = 0
                                    }
                                    Data.Inventory.Classes["Class " .. selectedProfile].Melee = name
                                    delay(0.25, function()
                                        game:GetService("ReplicatedStorage").SetMeleeForClass:FireServer("Class " .. selectedProfile, name, 0)
                                    end)
                                end
                                updateWeaponSelectionView(currentCategory)
                                updatePurchaseSelectionView(currentCategory ~= "Equipment" and currentCategory ~= "Melee" and currentCategory ~= "Armor", selectedButton.Name)
                                playerGui:WaitForChild("StatsChange"):Fire()
                            end
                        end
                    end
                end
            end
        end
    end)
    wepSelect:WaitForChild("button_wepSell").MouseButton1Click:connect(function()
        if selectedButton and not CollectionService:HasTag(selectedButton, "Using!") then
            game:GetService("ReplicatedStorage").SellGun:FireServer(selectedButton.Name, selectedButton.ID.Value)
            local worth = math.ceil(gunInfo.weaponPrices[selectedButton.Name] * 0.4)
            Data.Inventory.Cash = Data.Inventory.Cash + worth
            Data.Inventory.OwnedWeapons["(" .. selectedButton.Name .. ")" .. selectedButton.ID.Value] = nil
            updateWeaponSelectionView(currentCategory)
            playerGui:WaitForChild("StatsChange"):Fire()
        end
    end)
    wepSelect:WaitForChild("button_wepEquip").MouseButton1Click:connect(function()
        if selectedButton then
            for _, v in pairs(CollectionService:GetTagged("Using!")) do
                if v and v:FindFirstChild("weaponTitle") then
                    v:FindFirstChild("weaponTitle").TextColor3 = Color3.new(1, 1, 1)
                    CollectionService:RemoveTag(v, "Using!")
                end
            end
            selectedButton.weaponTitle.TextColor3 = Color3.new(0, 0.4980392156862745, 1)
            CollectionService:AddTag(selectedButton, "Using!")
            if currentCategory == "Primary" or currentCategory == "Secondary" then
                game:GetService("ReplicatedStorage"):WaitForChild("SetGunForClass"):FireServer("Class " .. selectedProfile, selectedButton.Name, selectedButton.ID.Value)
                Data.Inventory.Classes["Class " .. selectedProfile][currentCategory] = {
                    selectedButton.Name,
                    selectedButton.ID.Value,
                    ""
                }
                Data.Inventory.Classes["Class " .. selectedProfile]["Attach" .. (currentCategory == "Primary" and 1 or 2)] = Data.Inventory.OwnedWeapons["(" .. selectedButton.Name .. ")" .. selectedButton.ID.Value].Attachments
            elseif currentCategory == "Armor" then
                game:GetService("ReplicatedStorage").SetArmorForClass:FireServer("Class " .. selectedProfile, selectedButton.Name, 0)
                Data.Inventory.Classes["Class " .. selectedProfile].Armor = selectedButton.Name
            elseif currentCategory == "Equipment" then
                game:GetService("ReplicatedStorage").SetEquipmentForClass:FireServer("Class " .. selectedProfile, selectedButton.Name, 0)
                Data.Inventory.Classes["Class " .. selectedProfile].Equipment = selectedButton.Name
            elseif currentCategory == "Melee" then
                game:GetService("ReplicatedStorage").SetMeleeForClass:FireServer("Class " .. selectedProfile, selectedButton.Name, 0)
                Data.Inventory.Classes["Class " .. selectedProfile].Melee = selectedButton.Name
            end
            equippedId = selectedButton.ID.Value
            equippedString = selectedButton.Name
            updateConcealment()
        end
    end)
    local function updateMainStats()
        local classInfo = Data.Inventory.Classes["Class " .. selectedProfile]
        local baseArmor = gunInfo.armorValues[classInfo.Armor]
        local skillArmor = 0
        mainStats.text_statArmor.text_statBase.Text = numberDisplay(baseArmor)
        mainStats.text_statArmor.text_statSkill.Text = numberDisplay(skillArmor)
        mainStats.text_statArmor.text_statTotal.Text = numberDisplay(baseArmor + skillArmor)
        local dtect, conceal = updateConcealment()
        local baseDodge = gunInfo.armorDodge[classInfo.Armor]
        local skillDodge = 0
        if hasSkill("T", "I") then
            skillDodge = skillDodge + 5
        end
        if hasSkill("G", "R") then
            local pointsUnder35 = 35 - dtect
            if pointsUnder35 > 0 then
                skillDodge = skillDodge + math.min(10, math.floor(pointsUnder35))
            end
        elseif hasSkill("G", "r") then
            local pointsUnder35 = 35 - dtect
            if pointsUnder35 > 0 then
                skillDodge = skillDodge + math.min(10, math.floor(pointsUnder35 / 3))
            end
        end
        mainStats.text_statDodge.text_statBase.Text = numberDisplay(baseDodge)
        mainStats.text_statDodge.text_statSkill.Text = numberDisplay(skillDodge)
        mainStats.text_statDodge.text_statTotal.Text = numberDisplay(baseDodge + skillDodge)
        local baseHealth = 100
        local skillHealth = 0
        if hasSkill("M", "c") then
            skillHealth = skillHealth + 25
        end
        if hasSkill("E", "q") then
            skillHealth = skillHealth + baseHealth
        end
        if hasSkill("E", "Q") then
            skillHealth = skillHealth + 50
        end
        mainStats.text_statHealth.text_statBase.Text = numberDisplay(baseHealth)
        mainStats.text_statHealth.text_statSkill.Text = numberDisplay(skillHealth)
        mainStats.text_statHealth.text_statTotal.Text = numberDisplay(baseHealth + skillHealth)
        local baseSpeed = gunInfo.armorSpeed[classInfo.Armor]
        local skillSpeed = 0
        if hasSkill("G", "j") then
            skillSpeed = skillSpeed + baseSpeed * 0.1
        end
        mainStats.text_statSpeed.text_statBase.Text = numberDisplay(baseSpeed)
        mainStats.text_statSpeed.text_statSkill.Text = numberDisplay(skillSpeed)
        mainStats.text_statSpeed.text_statTotal.Text = numberDisplay(baseSpeed + skillSpeed)
        local baseRunSpeed = (baseSpeed + skillSpeed) * 1.6666666666666667
        local skillRunSpeed = 0
        if hasSkill("G", "F") then
            skillRunSpeed = skillRunSpeed + baseRunSpeed * 0.25
        end
        mainStats.text_statRunSpeed.text_statBase.Text = numberDisplay(baseRunSpeed)
        mainStats.text_statRunSpeed.text_statSkill.Text = numberDisplay(skillRunSpeed)
        mainStats.text_statRunSpeed.text_statTotal.Text = numberDisplay(baseRunSpeed + skillRunSpeed)
        local baseStamina = gunInfo.armorStamina[classInfo.Armor]
        local skillStamina = 0
        if hasSkill("M", "C") then
            skillStamina = skillStamina + baseStamina * 0.3
        end
        mainStats.text_statStamina.text_statBase.Text = numberDisplay(baseStamina)
        mainStats.text_statStamina.text_statSkill.Text = numberDisplay(skillStamina)
        mainStats.text_statStamina.text_statTotal.Text = numberDisplay(baseStamina + skillStamina)
    end
    for i = 1, 3 do
        do
            local button = inventory:WaitForChild("button_profile0" .. i)
            button.MouseButton1Click:connect(function()
                changeProfile(i)
                updateMainStats()
            end)
        end
    end
    inventory:GetPropertyChangedSignal("Visible"):connect(function()
        if inventory.Visible then
            updateMainStats()
        end
    end)
    local maskSelect = UI:WaitForChild("frame_maskSelect")
    local maskContainer = maskSelect:WaitForChild("frame_masksContainer")
    local maskTemplate = maskContainer:WaitForChild("maskListing01")
    maskTemplate.Parent = nil
    local RandomItemGenerator = require(game:GetService("ReplicatedStorage"):WaitForChild("RandomItemGenerator"))
    local quality_values = {
        Common = 0,
        Uncommon = 1,
        Rare = 2,
        Epic = 3,
        Infamous = 4
    }
    local materialInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("MaterialInfo"))
    local cam = Instance.new("Camera")
    cam.Parent = maskSelect:WaitForChild("frame_masksStats"):WaitForChild("preview")
    maskSelect:WaitForChild("frame_masksStats"):WaitForChild("preview").CurrentCamera = cam
    local function selectMask(entry)
        if selectedButton == entry then
            return
        end
        maskSelect.button_maskEquip.Visible = false
        maskSelect.button_maskDestroy.Visible = false
        selectedButton = entry
        local tween = TweenService:Create(entry, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BorderSizePixel = 5,
            BorderColor3 = Color3.new(0, 1, 1)
        })
        tween:Play()
        tween.Completed:connect(function()
            if selectedButton ~= entry then
                entry.BorderSizePixel = 1
                entry.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
            end
        end)
        for _, e in pairs(CollectionService:GetTagged("InventoryMasks")) do
            if e ~= entry then
                e.BorderSizePixel = 1
                e.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
            end
        end
        maskSelect.frame_masksStats.maskTitle.Text = selectedButton.maskTitle.Text
        maskSelect.frame_masksStats.maskRarity.Text = selectedButton.maskRarity.Text
        maskSelect.frame_masksStats.maskRarity.TextColor3 = selectedButton.maskRarity.TextColor3
        if Data.Inventory.MyMaskStats[5] ~= selectedButton.ID.Value then
            maskSelect.button_maskDestroy.Visible = true
            maskSelect.button_maskEquip.buttonText.Text = "EQUIP MASK"
            maskSelect.button_maskEquip.Visible = true
        end
        local mask = selectedButton.maskImage.Handle:Clone()
        mask.Parent = maskSelect.frame_masksStats.preview
        local angle = 0
        cam.CFrame = CFrame.new(mask.CFrame.p + mask.CFrame.lookVector * 2.5, mask.CFrame.p)
        local con
        con = game:GetService("RunService").RenderStepped:connect(function()
            if selectedButton == entry then
                angle = angle + 1
                if angle >= 360 then
                    angle = angle - 360
                end
                mask.CFrame = CFrame.new(mask.Position) * CFrame.Angles(0, math.rad(angle), 0)
            else
                mask:Destroy()
                con:Disconnect()
            end
        end)
    end
    local function openMaskSelection(id)
        selectedButton = nil
        maskSelect.button_maskDestroy.Visible = false
        maskSelect.button_maskEquip.Visible = false
        local eID = Data.Inventory.MyMaskStats[5]
        for _, v in pairs(CollectionService:GetTagged("InventoryMasks")) do
            v:Destroy()
        end
        for n, v in pairs(Data.Inventory.OwnedCustomMasks) do
            do
                local entry = maskTemplate:Clone()
                CollectionService:AddTag(entry, "InventoryMasks")
                entry.Name = v[1]
                entry.maskTitle.Text = v[1]
                local color = BrickColor.new(v[2])
                local rarity = RandomItemGenerator.getItemRarity(v[1], v[3])
                entry.maskRarity.Text = rarity
                entry.maskRarity.TextColor3 = quality_colors[rarity]
                entry.Parent = maskContainer
                entry.maskImage.Handle.Mesh.MeshId = maskInfo[v[1]].MeshId
                entry.maskImage.Handle.BrickColor = color
                entry.maskImage.Handle.Mesh.VertexColor = Vector3.new(color.r, color.g, color.b)
                entry.maskImage.Handle.Mesh.TextureId = materialInfo[v[3]] or v[3]
                entry.maskImage.Handle.Mesh.Scale = gunInfo.MaskScales[tostring(maskInfo[v[1]].MeshId)] or Vector3.new(1, 1, 1)
                entry.ID.Value = n
                if n == eID then
                    entry.maskTitle.TextColor3 = Color3.new(0, 0.4980392156862745, 1)
                end
                local cam = Instance.new("Camera")
                cam.CFrame = CFrame.new(entry.maskImage.Handle.CFrame.p + entry.maskImage.Handle.CFrame.lookVector * 2.5, entry.maskImage.Handle.CFrame.p)
                cam.Parent = entry.maskImage
                entry.maskImage.CurrentCamera = cam
                if id == nil and n == 1 or id == n then
                    selectMask(entry)
                end
                entry.MouseButton1Click:connect(function()
                    selectMask(entry)
                end)
            end
        end
    end
    maskContainer:WaitForChild("UIGridLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        wait()
        local frameAbsoluteSize = maskContainer.AbsoluteSize
        maskContainer.UIGridLayout.CellSize = UDim2.new(0, frameAbsoluteSize.X / 5 - 30 + 0.015 * frameAbsoluteSize.X / 2, 0, 92)
        maskContainer.CanvasSize = UDim2.new(0, 0, 0, maskContainer.UIGridLayout.AbsoluteContentSize.Y)
    end)
    maskContainer:GetPropertyChangedSignal("Visible"):connect(function()
        wait()
        local frameAbsoluteSize = maskContainer.AbsoluteSize
        maskContainer.UIGridLayout.CellSize = UDim2.new(0, frameAbsoluteSize.X / 5 - 30 + 0.015 * frameAbsoluteSize.X / 2, 0, 92)
        maskContainer.CanvasSize = UDim2.new(0, 0, 0, maskContainer.UIGridLayout.AbsoluteContentSize.Y)
    end)
    local lootboxSelect = UI:WaitForChild("frame_lootboxSelect")
    local lootboxEntry = lootboxSelect:WaitForChild("frame_safesContainer"):WaitForChild("weaponListing01")
    lootboxEntry.Parent = nil
    local safeInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("SafeInfo"))
    local lootboxList = {
        ["Cardboard 'Safe'"] = {
            description = "A cheap safe made of cardboard. Contains contracts and blank white masks.",
            oddDescription = "Odds: 35% Common, 30% Rare, 20% Epic, 10% Elite, 5% Infamous",
            odds = {
                35,
                30,
                20,
                10,
                5
            }
        },
        ["Metal Safe"] = {
            description = "A durable safe that is hard to get into. Contains contracts and blank colored masks.",
            oddDescription = "Odds: 25% Common, 30% Rare, 30% Epic, 10% Elite, 5% Infamous",
            odds = {
                25,
                30,
                30,
                10,
                5
            }
        },
        ["Gold Safe"] = {
            description = "gold desc.",
            oddDescription = "Odds: 5% Common, 5% Rare, 25% Epic, 30% Elite, 35% Infamous",
            odds = {
                5,
                5,
                25,
                30,
                35
            }
        },
        ["Diamond Safe"] = {
            description = "A ridiculously expensive safe forged from diamonds. Contains textured and colored masks.",
            oddDescription = "Odds: 35% Common, 30% Rare, 20% Epic, 10% Elite, 5% Infamous",
            odds = {
                35,
                30,
                20,
                10,
                5
            }
        },
        ["Infamous Safe"] = {
            description = "A safe of superior quality. Contains rare textured and colored masks.",
            oddDescription = "Odds: 25% Common, 30% Rare, 30% Epic, 10% Elite, 5% Infamous",
            odds = {
                0,
                0,
                0,
                0,
                100
            }
        },
        ["Outlaw Safe"] = {
            description = "A safe designed to hold only the most expensive items.",
            oddDescription = "Odds: 5% Common, 30% Rare, 20% Epic, 10% Elite, 5% Infamous",
            odds = {
                5,
                50,
                30,
                10,
                5
            }
        },
        ["Ruby Safe"] = {
            description = "An extravagant safe that contains  valuable ruby red masks",
            oddDescription = "Odds: 5% Common, 5% Rare, 25% Epic, 30% Elite, 35% Infamous",
            odds = {
                20,
                30,
                30,
                15,
                5
            }
        }
    }
    local function updateSelectedLootbox(isSafe, entry)
        selectedButton = entry
        if entry then
            local tween = TweenService:Create(entry, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BorderSizePixel = 5,
                BorderColor3 = Color3.new(0, 1, 1)
            })
            tween:Play()
            tween.Completed:connect(function()
                if selectedButton ~= entry then
                    entry.BorderSizePixel = 1
                    entry.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
                end
            end)
            if isSafe then
                for _, e in pairs(CollectionService:GetTagged("InventorySafes")) do
                    if e ~= entry then
                        e.BorderSizePixel = 1
                        e.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
                    end
                end
                lootboxSelect.frame_safeStats.Visible = true
                lootboxSelect.frame_caseStats.Visible = false
                lootboxSelect.frame_safeStats.lootboxTitle.Text = entry.Name
                lootboxSelect.frame_safeStats.lootboxDesc.Text = lootboxList[entry.Name].description
                lootboxSelect.frame_safeStats.lootboxValue.Text = safeInfo[entry.Name].Cost == -1 and "" or "$" .. convertToCommas(safeInfo[entry.Name].Cost)
                lootboxSelect.frame_safeStats.rarityCommon.Text = lootboxList[entry.Name].odds[1] .. "% Common"
                lootboxSelect.frame_safeStats.rarityRare.Text = lootboxList[entry.Name].odds[2] .. "% Uncommon"
                lootboxSelect.frame_safeStats.rarityEpic.Text = lootboxList[entry.Name].odds[3] .. "% Rare"
                lootboxSelect.frame_safeStats.rarityElite.Text = lootboxList[entry.Name].odds[4] .. "% Epic"
                lootboxSelect.frame_safeStats.rarityInfamous.Text = lootboxList[entry.Name].odds[5] .. "% Infamous"
                if safeInfo[entry.Name].UpgradeCost then
                    lootboxSelect.frame_safeStats.button_safeUpgrade.Visible = true
                else
                    lootboxSelect.frame_safeStats.button_safeUpgrade.Visible = false
                end
            else
                for _, e in pairs(CollectionService:GetTagged("InventoryCases")) do
                    if e ~= entry then
                        e.BorderSizePixel = 1
                        e.BorderColor3 = Color3.new(0.10588235294117647, 0.16470588235294117, 0.20784313725490197)
                    end
                end
                lootboxSelect.frame_safeStats.Visible = false
                lootboxSelect.frame_caseStats.Visible = true
            end
        else
            lootboxSelect.frame_safeStats.Visible = false
            lootboxSelect.frame_caseStats.Visible = false
        end
    end
    local function updateSafeList(selectedSafe)
        for _, v in pairs(CollectionService:GetTagged("InventorySafes")) do
            v:Destroy()
        end
        local first
        for name, amt in pairs(Data.Inventory.OwnedSafes) do
            if amt > 0 then
                do
                    local entry = lootboxEntry:Clone()
                    entry.TextLabel.Text = name .. "(x" .. convertToCommas(amt) .. ")"
                    entry.Image = safeInfo[name].Image
                    entry.LayoutOrder = amt
                    entry.Name = name
                    CollectionService:AddTag(entry, "InventorySafes")
                    entry.Parent = lootboxSelect.frame_safesContainer
                    entry.MouseButton1Click:connect(function()
                        if selectedButton ~= entry then
                            updateSelectedLootbox(true, entry)
                        end
                    end)
                    if name == selectedSafe then
                        first = entry
                    end
                    if first == nil and not selectedSafe then
                        first = entry
                    end
                end
            end
        end
        updateSelectedLootbox(true, first)
    end
    local updateCasesList = function()
    end
    local opening = false
    lootboxSelect:WaitForChild("frame_safeStats"):WaitForChild("button_safeUpgrade").MouseButton1Click:connect(function()
        if selectedButton then
            lootboxSelect.Visible = false
            msgBox.Visible = true
            for _, v in pairs(msgBox:GetChildren()) do
                v.Visible = false
            end
            msgBox.frame_upgradeConfirmation.text_warning01.Text = "This upgrade will cost " .. safeInfo[selectedButton.Name].UpgradeCost .. " " .. selectedButton.Name .. "s. You currently have " .. Data.Inventory.OwnedSafes[selectedButton.Name] .. "."
            msgBox.frame_upgradeConfirmation.text_warning02.Text = "You will receive 1 " .. safeInfo[selectedButton.Name].UpgradeTo .. "."
            if Data.Inventory.OwnedSafes[selectedButton.Name] >= safeInfo[selectedButton.Name].UpgradeCost then
                msgBox.frame_upgradeConfirmation.button_confirm.Visible = true
            else
                msgBox.frame_upgradeConfirmation.button_confirm.Visible = false
            end
            msgBox.frame_upgradeConfirmation.Visible = true
        end
    end)
    msgBox:WaitForChild("frame_upgradeConfirmation"):WaitForChild("button_confirm").MouseButton1Click:connect(function()
        if selectedButton then
            local owned = Data.Inventory.OwnedSafes[selectedButton.Name]
            if owned and owned >= safeInfo[selectedButton.Name].UpgradeCost then
                game:GetService("ReplicatedStorage"):WaitForChild("UpgradeSafe"):FireServer(selectedButton.Name)
                Data.Inventory.OwnedSafes[selectedButton.Name] = Data.Inventory.OwnedSafes[selectedButton.Name] - safeInfo[selectedButton.Name].UpgradeCost
                Data.Inventory.OwnedSafes[safeInfo[selectedButton.Name].UpgradeTo] = Data.Inventory.OwnedSafes[safeInfo[selectedButton.Name].UpgradeTo] and Data.Inventory.OwnedSafes[safeInfo[selectedButton.Name].UpgradeTo] + 1 or 1
                updateSafeList(selectedButton.Name)
            end
        end
        lootboxSelect.Visible = true
        msgBox.Visible = false
    end)
    msgBox:WaitForChild("frame_upgradeConfirmation"):WaitForChild("button_decline").MouseButton1Click:connect(function()
        lootboxSelect.Visible = true
        msgBox.Visible = false
    end)
    local spinner = UI:WaitForChild("frame_lootboxSpinner")
    local spinnerComponent = spinner:WaitForChild("MainHolder"):WaitForChild("Holder"):WaitForChild("imgbg")
    spinnerComponent.Parent = nil
    local explainFrame = lootboxSelect:WaitForChild("Explain")
    local explainItem = explainFrame:WaitForChild("frame_items"):WaitForChild("item")
    explainItem.Parent = nil
    explainFrame:WaitForChild("Ok").MouseButton1Click:connect(function()
        explainFrame.Visible = false
    end)
    explainFrame:WaitForChild("frame_items"):WaitForChild("UIListLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        explainFrame.frame_items.CanvasSize = UDim2.new(0, 0, 0, explainFrame.frame_items.UIListLayout.AbsoluteContentSize.Y)
    end)
    lootboxSelect:WaitForChild("frame_safeStats"):WaitForChild("button_openBulk").MouseButton1Click:connect(function()
        if opening or selectedButton == nil then
            return
        end
        opening = true
        explainFrame.Visible = false
        local selectedSafe = selectedButton.Name
        for _, v in pairs(CollectionService:GetTagged("WonItems")) do
            v:Destroy()
        end
        for i = 1, Data.Inventory.OwnedSafes[selectedSafe] do
            local itemPool, chosenIndex = game:GetService("ReplicatedStorage"):WaitForChild("RequestUseSafe"):InvokeServer(selectedSafe)
            local winItem = itemPool[chosenIndex]
            local quality = "Common"
            local entry = explainItem:Clone()
            entry.ItemType.Image = winItem[1] == "CONTRACT" and "rbxassetid://1459069099" or "rbxassetid://943239001"
            if winItem[1] ~= "CONTRACT" then
                quality = RandomItemGenerator.getItemRarity(winItem[1], winItem[2])
                entry.TextLabel.Text = winItem[1] .. " [" .. quality .. "]"
                table.insert(Data.Inventory.OwnedCustomMasks, {
                    winItem[1],
                    winItem[3],
                    winItem[2]
                })
            else
                quality = ({
                    Normal = "Common",
                    Hard = "Common",
                    ["Very Hard"] = "Uncommon",
                    Extreme = "Rare",
                    Anarchy = "Epic",
                    Nightmare = "Infamous"
                })[winItem[3]]
                entry.TextLabel.Text = winItem[3] .. " " .. winItem[2] .. " Contract [" .. quality .. "]"
                if Data.Inventory.Contracts[winItem[2]] then
                    if Data.Inventory.Contracts[winItem[2]][winItem[3]] then
                        Data.Inventory.Contracts[winItem[2]][winItem[3]] = Data.Inventory.Contracts[winItem[2]][winItem[3]] + 1
                    else
                        Data.Inventory.Contracts[winItem[2]][winItem[3]] = 1
                    end
                else
                    Data.Inventory.Contracts[winItem[2]] = {
                        [winItem[3]] = 1
                    }
                end
            end
            game:GetService("ReplicatedStorage"):WaitForChild("UsedSafe"):FireServer(selectedSafe, winItem)
            entry.Name = quality
            entry.LayoutOrder = quality_values[quality]
            entry.TextLabel.TextColor3 = quality_colors[quality]
            CollectionService:AddTag(entry, "WonItems")
            entry.Parent = explainFrame:WaitForChild("frame_items")
        end
        Data.Inventory.OwnedSafes[selectedSafe] = 0
        explainFrame.Visible = true
        updateSafeList()
        opening = false
    end)
    lootboxSelect:WaitForChild("frame_safeStats"):WaitForChild("button_safeOpen").MouseButton1Click:connect(function()
        if opening or selectedButton == nil then
            return
        end
        opening = true
        local selectedSafe = selectedButton.Name
        Data.Inventory.OwnedSafes[selectedSafe] = Data.Inventory.OwnedSafes[selectedSafe] - 1
        local itemPool, chosenIndex = game:GetService("ReplicatedStorage"):WaitForChild("RequestUseSafe"):InvokeServer(selectedSafe)
        lootboxSelect.Visible = false
        spinner.Visible = true
        spinner.rouletteReward.Position = UDim2.new(0.238, 0, -10, 0)
        cameraRun:SetCameraByPart(workspace.cam_safes)
        for _, v in pairs(CollectionService:GetTagged("SpinnerComponents")) do
            v:Destroy()
        end
        local originalElements = {}
        for n, v in pairs(itemPool) do
            local element = spinnerComponent:clone()
            element.Name = v[1] .. v[2]
            if v[1] ~= "CONTRACT" then
                element.Image = ""
                element.img.Image = ""
                local color = BrickColor.new(v[3])
                element.maskFrame.Handle.BrickColor = color
                element.maskFrame.Handle.Mesh.VertexColor = Vector3.new(color.r, color.g, color.b)
                element.maskFrame.Handle.Mesh.MeshId = maskInfo[v[1]].MeshId
                element.maskFrame.Handle.Mesh.TextureId = materialInfo[v[2]] or v[2]
                element.maskFrame.Handle.Mesh.Scale = gunInfo.MaskScales[tostring(maskInfo[v[1]].MeshId)] or Vector3.new(1, 1, 1)
                local cam = Instance.new("Camera")
                cam.CFrame = CFrame.new(element.maskFrame.Handle.Position + element.maskFrame.Handle.CFrame.lookVector * 2.5, element.maskFrame.Handle.Position)
                cam.Parent = element
                element.maskFrame.CurrentCamera = cam
            else
                element.Image = heistInfo[v[2]].Image
                element.img.Image = "rbxassetid://1459069099"
                element.img.ImageColor3 = difficultycolors[v[3]]
            end
            CollectionService:AddTag(element, "SpinnerComponents")
            element.Parent = spinner.MainHolder.Holder
            table.insert(originalElements, element)
        end
        local iteration = 1
        wait()
        local fullLoop = spinner.MainHolder.Holder.UIListLayout.AbsoluteContentSize.X
        local elementSize = originalElements[1].AbsoluteSize.X
        local holderSize = spinner.MainHolder.AbsoluteSize.X
        repeat
            iteration = iteration + 1
            for _, v in pairs(originalElements) do
                local element2 = v:clone()
                element2.LayoutOrder = iteration
                element2.Parent = spinner.MainHolder.Holder
            end
            wait()
        until holderSize <= spinner.MainHolder.Holder.UIListLayout.AbsoluteContentSize.X
        local selectedSafeModel = game:GetService("ReplicatedStorage"):WaitForChild("Safes"):FindFirstChild(selectedSafe):clone()
        selectedSafeModel:SetPrimaryPartCFrame(CFrame.new(workspace:WaitForChild("SafeSpawn").Position + Vector3.new(selectedSafeModel.PrimaryPart.Size.Y / 2)))
        selectedSafeModel.Parent = workspace
        local module = require(selectedSafeModel.CrateModule)
        spawn(function()
            module:initiateOpen()
        end)
        local runningTween
        local skip = false
        local skipCon
        spinner.button_rouletteSkip.Visible = true
        skipCon = spinner.button_rouletteSkip.MouseButton1Click:connect(function()
            skip = true
            spinner.button_rouletteSkip.Visible = false
            if runningTween then
                runningTween:Cancel()
            end
        end)
        for i = 1, 5 do
            local timeTaken = i / 4
            runningTween = game:GetService("TweenService"):Create(spinner.MainHolder.Holder, TweenInfo.new(timeTaken, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, -fullLoop, 0, 0)
            })
            runningTween:Play()
            runningTween.Completed:wait()
            spinner.MainHolder.Holder.Position = UDim2.new(0, 0, 0, 0)
            if skip then
                break
            end
        end
        local timeTaken = 1.5
        local randOffset = math.random((chosenIndex - 1) * elementSize + elementSize / 4, (chosenIndex - 1) * elementSize + elementSize / 2)
        local offset = holderSize / 2 - randOffset
        if offset > 0 then
            offset = offset - fullLoop
            timeTaken = timeTaken * 2
        end
        local Tween = game:GetService("TweenService"):Create(spinner.MainHolder.Holder, TweenInfo.new(timeTaken, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, offset, 0, 0)
        })
        Tween:Play()
        Tween.Completed:wait()
        spawn(function()
            module:open(itemPool[chosenIndex], skip)
        end)
        local winItem = itemPool[chosenIndex]
        if winItem[1] ~= "CONTRACT" then
            local quality = RandomItemGenerator.getItemRarity(winItem[1], winItem[2])
            spinner.rouletteReward.rewardLabel.Text = winItem[1]
            spinner.rouletteReward.rarityLabel.Text = quality
            spinner.rouletteReward.rarityLabel.TextColor3 = quality_colors[quality]
            table.insert(Data.Inventory.OwnedCustomMasks, {
                winItem[1],
                winItem[3],
                winItem[2]
            })
            wait(2)
        else
            local quality = ({
                Normal = "Common",
                Hard = "Common",
                ["Very Hard"] = "Uncommon",
                Extreme = "Rare",
                Anarchy = "Epic",
                Nightmare = "Infamous"
            })[winItem[3]]
            spinner.rouletteReward.rewardLabel.Text = winItem[3] .. " " .. winItem[2] .. " Contract"
            spinner.rouletteReward.rarityLabel.Text = quality
            spinner.rouletteReward.rarityLabel.TextColor3 = quality_colors[quality]
            if Data.Inventory.Contracts[winItem[2]] then
                if Data.Inventory.Contracts[winItem[2]][winItem[3]] then
                    Data.Inventory.Contracts[winItem[2]][winItem[3]] = Data.Inventory.Contracts[winItem[2]][winItem[3]] + 1
                else
                    Data.Inventory.Contracts[winItem[2]][winItem[3]] = 1
                end
            else
                Data.Inventory.Contracts[winItem[2]] = {
                    [winItem[3]] = 1
                }
            end
        end
        local tween = game:GetService("TweenService"):Create(spinner.rouletteReward, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.238, 0, -3.573, 0)
        })
        tween:Play()
        wait(0.5)
        SFX.Earn:Play()
        wait(5.5)
        selectedSafeModel:Destroy()
        game:GetService("ReplicatedStorage"):WaitForChild("UsedSafe"):FireServer(selectedSafe, winItem)
        skipCon:Disconnect()
        cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
        lootboxSelect.Visible = true
        updateSafeList(selectedSafe)
        spinner.Visible = false
        opening = false
    end)
    lootboxSelect:WaitForChild("frame_safesContainer"):WaitForChild("UIGridLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        local frameAbsoluteSize = lootboxSelect:WaitForChild("frame_safesContainer").AbsoluteSize
        lootboxSelect:WaitForChild("frame_safesContainer").UIGridLayout.CellSize = UDim2.new(0, frameAbsoluteSize.X / 5 - 30 + 0.015 * frameAbsoluteSize.X / 2, 0, 92)
        lootboxSelect:WaitForChild("frame_safesContainer").CanvasSize = UDim2.new(0, 0, 0, lootboxSelect:WaitForChild("frame_safesContainer").UIGridLayout.AbsoluteContentSize.Y)
    end)
    lootboxSelect:WaitForChild("frame_casesContainer"):WaitForChild("UIGridLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
        local frameAbsoluteSize = lootboxSelect:WaitForChild("frame_casesContainer").AbsoluteSize
        lootboxSelect:WaitForChild("frame_casesContainer").UIGridLayout.CellSize = UDim2.new(0, frameAbsoluteSize.X / 5 - 30 + 0.015 * frameAbsoluteSize.X / 2, 0, 92)
        lootboxSelect:WaitForChild("frame_casesContainer").CanvasSize = UDim2.new(0, 0, 0, lootboxSelect:WaitForChild("frame_casesContainer").UIGridLayout.AbsoluteContentSize.Y)
    end)
    local function setLootboxView(typeOf)
        if typeOf == "Safe" then
            lootboxSelect.frame_safesContainer.Visible = true
            lootboxSelect.frame_casesContainer.Visible = false
            lootboxSelect.buttonCases.frame_buttonSelection.Visible = false
            lootboxSelect.buttonSafes.frame_buttonSelection.Visible = true
        else
            lootboxSelect.frame_safesContainer.Visible = false
            lootboxSelect.frame_casesContainer.Visible = true
            lootboxSelect.buttonCases.frame_buttonSelection.Visible = true
            lootboxSelect.buttonSafes.frame_buttonSelection.Visible = false
        end
    end
    lootboxSelect:WaitForChild("buttonCases").MouseButton1Click:connect(function()
        if lootboxSelect.frame_casesContainer.Visible then
            return
        else
            updateCasesList()
            setLootboxView("Case")
        end
    end)
    lootboxSelect:WaitForChild("buttonSafes").MouseButton1Click:connect(function()
        if lootboxSelect.frame_safesContainer.Visible then
            return
        else
            updateSafeList()
            setLootboxView("Safe")
        end
    end)
    lootboxSelect:WaitForChild("button_safesBack").MouseButton1Click:connect(function()
        lootboxSelect.Visible = false
        inventory.Visible = true
    end)
    wepSelect:WaitForChild("button_wepModify").MouseButton1Click:connect(function()
        myCat = 1
        setModCategory(modCats[myCat])
        wepMod.frame_statsContainer.text_weaponName.Text = selectedButton.Name
        showGun("(" .. selectedButton.Name .. ")" .. selectedButton.ID.Value)
        wepMod.Visible = true
        wepSelect.Visible = false
    end)
    wepSelect:GetPropertyChangedSignal("Visible"):Connect(function()
        if wepSelect.Visible then
            cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
        end
    end)
    wepMod:GetPropertyChangedSignal("Visible"):Connect(function()
        if wepMod.Visible then
            cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
        end
    end)
    local skills = UI:WaitForChild("frame_skills")
    local skillInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("SkillInfo"))
    local infamyInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("InfamyInfo"))
    local skillCategory = "M"
    local skillsLeft = 0
    local skillsSpent = {
        M = 0,
        E = 0,
        G = 0,
        T = 0
    }
    local tierRules = {
        {
            0,
            1,
            2
        },
        {
            3,
            2,
            3
        },
        {
            10,
            3,
            4
        },
        {
            20,
            3,
            4
        },
        {
            30,
            5,
            6
        },
        {
            999999,
            0,
            0
        }
    }
    local function getSkillsAvailable()
        local total = Data.Inventory.Level + math.floor(Data.Inventory.Level / 10) + infamyInfo:GetInfamySkill(Data.Inventory.Infamy)
        local spent = {
            M = 0,
            E = 0,
            G = 0,
            T = 0
        }
        local class = Data.Inventory.Classes["Class " .. selectedProfile]
        for skillTypeCode, skills in pairs(class.Skills) do
            local code = skillTypeCode:sub(1, 1)
            for i = 1, #skills do
                local skill = skills:sub(i, i)
                if skillInfo[code][skill:upper()] then
                    local tier = skillInfo[code][skill:upper()].Tier
                    local expertise = skill == skill:lower() and 2 or 3
                    spent[code] = spent[code] + tierRules[tier][expertise]
                end
            end
        end
        total = total - spent.M - spent.E - spent.G - spent.T
        skillsLeft = total
        skillsSpent = spent
        return total, spent
    end
    local function updateSkillCategory(categoryName)
        skillCategory = categoryName
        local skillPoints, skillsSpent = getSkillsAvailable()
        skills.frame_titleBar.text_menuTitle.Size = UDim2.new(0, skills.frame_titleBar.text_menuTitle.TextBounds.X, 1, 0)
        skills.frame_titleBar.text_skillsAmt.Text = convertToCommas(skillPoints)
        local currentSkills = Data.Inventory.Classes["Class " .. selectedProfile].Skills[categoryName .. "Tree"]
        for _, v in pairs({
            "E",
            "M",
            "G",
            "T"
        }) do
            skills["button_tree" .. v].frame_buttonSelection.Visible = false
        end
        skills["button_tree" .. categoryName].frame_buttonSelection.Visible = true
        for _, button in pairs(skills.frame_skillContainer:GetChildren()) do
            if button:IsA("ImageButton") then
                local info = skillInfo[categoryName][button.Name]
                button.Image = info.Image
                local owned = currentSkills:find(button.Name:lower())
                if owned then
                    local aced = currentSkills:find(button.Name:upper())
                    button.ImageColor3 = Color3.new(1, 1, 1)
                    if aced then
                        button.skillAce.Visible = true
                    else
                        button.skillAce.Visible = false
                    end
                else
                    button.skillAce.Visible = false
                    button.ImageColor3 = Color3.new(0.6509803921568628, 0.6509803921568628, 0.6509803921568628)
                end
                local locked = skillsSpent[categoryName] < tierRules[info.Tier][1]
                if locked then
                    button.skillLock.Visible = true
                else
                    button.skillLock.Visible = false
                end
            end
        end
    end
    for _, button in pairs(skills:GetChildren()) do
        if button:IsA("TextButton") then
            button.MouseButton1Click:connect(function()
                updateSkillCategory(button.Name:sub(-1, -1))
            end)
        end
    end
    for _, button in pairs(skills:WaitForChild("frame_skillContainer"):GetChildren()) do
        if button:IsA("ImageButton") then
            button.MouseButton1Click:connect(function()
                local currentSkills = Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"]
                local info = skillInfo[skillCategory][button.Name]
                if skillsSpent[skillCategory] < tierRules[info.Tier][1] then
                    SFX.Cant:Play()
                    return
                end
                if currentSkills:find(button.Name:lower()) then
                    if currentSkills:find(button.Name:upper()) then
                    else
                        local aceCost = tierRules[info.Tier][3]
                        if aceCost <= skillsLeft then
                            Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"] = Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"] .. button.Name:upper()
                            game:GetService("ReplicatedStorage"):WaitForChild("BuySkill"):FireServer("Class " .. selectedProfile, button.Name, skillCategory, true)
                            SFX.Gun:Play()
                            updateSkillCategory(skillCategory)
                        else
                            SFX.Cant:Play()
                        end
                    end
                else
                    local baseCost = tierRules[info.Tier][2]
                    if baseCost <= skillsLeft then
                        Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"] = Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"] .. button.Name:lower()
                        game:GetService("ReplicatedStorage"):WaitForChild("BuySkill"):FireServer("Class " .. selectedProfile, button.Name, skillCategory, false)
                        SFX.LoadGun:Play()
                        updateSkillCategory(skillCategory)
                    else
                        SFX.Cant:Play()
                    end
                end
            end)
            button.MouseButton2Click:connect(function()
                local currentSkills = Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"]
                local info = skillInfo[skillCategory][button.Name]
                local owned = currentSkills:find(button.Name:lower())
                local aced = currentSkills:find(button.Name:upper())
                if not owned then
                    return
                end
                if aced then
                    local value = tierRules[info.Tier][3]
                    if skillsSpent[skillCategory] - value <= tierRules[info.Tier + 1][1] then
                        local sameTier = false
                        for i = 1, #currentSkills do
                            local s = currentSkills:sub(i, i):upper()
                            if skillInfo[skillCategory][s].Tier == info.Tier + 1 then
                                sameTier = true
                                break
                            end
                        end
                        if sameTier then
                            SFX.Cant:Play()
                            return
                        end
                    end
                    local a, b = currentSkills:find(button.Name:upper())
                    local newString = currentSkills:sub(1, a - 1) .. currentSkills:sub(b + 1, #currentSkills)
                    Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"] = newString
                    game:GetService("ReplicatedStorage"):WaitForChild("SellSkill"):FireServer("Class " .. selectedProfile, button.Name, skillCategory, true)
                    updateSkillCategory(skillCategory)
                else
                    local value = tierRules[info.Tier][3]
                    if skillsSpent[skillCategory] - value <= tierRules[info.Tier + 1][1] then
                        local sameTier = false
                        for i = 1, #currentSkills do
                            local s = currentSkills:sub(i, i):upper()
                            if skillInfo[skillCategory][s].Tier == info.Tier + 1 then
                                sameTier = true
                                break
                            end
                        end
                        if sameTier then
                            SFX.Cant:Play()
                            return
                        end
                    end
                    local a, b = currentSkills:find(button.Name:lower())
                    local newString = currentSkills:sub(1, a - 1) .. currentSkills:sub(b + 1, #currentSkills)
                    Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"] = newString
                    game:GetService("ReplicatedStorage"):WaitForChild("SellSkill"):FireServer("Class " .. selectedProfile, button.Name, skillCategory, false)
                    updateSkillCategory(skillCategory)
                end
            end)
            button.MouseEnter:connect(function()
                local currentSkills = Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"]
                local info = skillInfo[skillCategory][button.Name]
                local owned = currentSkills:find(button.Name:lower())
                local aced = currentSkills:find(button.Name:upper())
                local tier = info.Tier
                if skillsSpent[skillCategory] < tierRules[tier][1] then
                    local needed = tierRules[tier][1] - skillsSpent[skillCategory]
                    skills.frame_skillDesc.skillRequirement.Text = "You must spend " .. convertToCommas(needed) .. " additional skill point" .. (needed == 1 and "" or "s") .. " to unlock this skill"
                else
                    skills.frame_skillDesc.skillRequirement.Text = ""
                end
                if owned then
                    skills.frame_skillDesc.basic.amt.Text = "Owned"
                else
                    skills.frame_skillDesc.basic.amt.Text = tierRules[tier][2] .. " skill point" .. (tierRules[tier][2] == 1 and "" or "s")
                end
                if aced then
                    skills.frame_skillDesc.aced.amt.Text = "Owned"
                else
                    skills.frame_skillDesc.aced.amt.Text = tierRules[tier][3] .. " skill point" .. (tierRules[tier][3] == 1 and "" or "s")
                end
                skills.frame_skillDesc.basic.desc.Text = info.Basic
                skills.frame_skillDesc.aced.desc.Text = info.Ace
                skills.frame_skillDesc.skillTitle.Text = info.Name
                SFX.Hover:Play()
            end)
        end
    end
    skills:WaitForChild("button_skillRefresh").MouseButton1Click:connect(function()
        SFX.TerminalClick:Play()
        Data.Inventory.Classes["Class " .. selectedProfile].Skills[skillCategory .. "Tree"] = ""
        game:GetService("ReplicatedStorage"):WaitForChild("RespecTree"):FireServer("Class " .. selectedProfile, skillCategory)
        updateSkillCategory(skillCategory)
    end)
    local charSelect = UI:WaitForChild("frame_charSelect")
    charSelect:WaitForChild("button_charBack").MouseButton1Click:connect(function()
        charSelect.Visible = false
        inventory.Visible = true
    end)
    wepMod:WaitForChild("button_gunModifyBack").MouseButton1Click:connect(function()
        wepMod.Visible = false
        wepSelect.Visible = true
        for _, v in pairs(CollectionService:GetTagged("WeaponPreview")) do
            v:Destroy()
        end
        local current = Data.Inventory.OwnedWeapons["(" .. selectedButton.Name .. ")" .. selectedButton.ID.Value]
        showWeaponStats(wepSelectStats, selectedButton.Name, current.Attachments, false)
    end)
    mainButtons.button_slotPrimary.MouseButton1Click:connect(function()
        updateWeaponSelectionView("Primary")
        inventory.Visible = false
        wepSelect.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
    end)
    mainButtons.button_slotSecondary.MouseButton1Click:connect(function()
        updateWeaponSelectionView("Secondary")
        inventory.Visible = false
        wepSelect.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
    end)
    mainButtons.button_slotMelee.MouseButton1Click:connect(function()
        updateWeaponSelectionView("Melee")
        inventory.Visible = false
        wepSelect.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
    end)
    mainButtons.button_slotArmor.MouseButton1Click:connect(function()
        updateWeaponSelectionView("Armor")
        inventory.Visible = false
        wepSelect.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
    end)
    mainButtons.button_slotEquipment.MouseButton1Click:connect(function()
        updateWeaponSelectionView("Equipment")
        inventory.Visible = false
        wepSelect.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
    end)
    mainButtons.button_slotMask.MouseButton1Click:connect(function()
        openMaskSelection()
        inventory.Visible = false
        maskSelect.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
    end)
    mainButtons.button_slotSafes.MouseButton1Click:connect(function()
        inventory.Visible = false
        lootboxSelect.Visible = true
        updateSafeList()
        setLootboxView("Safe")
        cameraRun:SetCameraByPart(workspace.cam_weaponSelect)
    end)
    mainButtons.button_slotChar.MouseButton1Click:connect(function()
        inventory.Visible = false
        charSelect.Visible = true
    end)
    mainButtons.button_slotSkills.MouseButton1Click:connect(function()
        inventory.Visible = false
        skills.Visible = true
        cameraRun:SetCameraByPart(workspace.cam_Skills)
        updateSkillCategory("M")
    end)
    skills:WaitForChild("button_skillsBack").MouseButton1Click:connect(function()
        inventory.Visible = true
        skills.Visible = false
        cameraRun:SetCameraByPart(workspace.cam_Inventory)
    end)
    wepSelect:WaitForChild("button_wepBack").MouseButton1Click:connect(function()
        inventory.Visible = true
        wepSelect.Visible = false
        updateMainButtons()
        cameraRun:SetCameraByPart(workspace.cam_Inventory)
    end)
    maskSelect:WaitForChild("button_maskBack").MouseButton1Click:connect(function()
        inventory.Visible = true
        maskSelect.Visible = false
        updateMainButtons()
        cameraRun:SetCameraByPart(workspace.cam_Inventory)
    end)
    maskSelect:WaitForChild("button_maskDestroy").MouseButton1Click:connect(function()
        if selectedButton then
            game:GetService("ReplicatedStorage").SellMask:FireServer(selectedButton.ID.Value)
            local playerMask = Data.Inventory.OwnedCustomMasks[selectedButton.ID.Value]
            if playerMask then
                local currentID = Data.Inventory.MyMaskStats[5]
                local currentMask = Data.Inventory.OwnedCustomMasks[currentID]
                table.remove(Data.Inventory.OwnedCustomMasks, selectedButton.ID.Value)
                for newID, v in pairs(Data.Inventory.OwnedCustomMasks) do
                    if v == currentMask then
                        Data.Inventory.MyMaskStats[5] = newID
                    end
                end
                openMaskSelection()
            end
        end
    end)
    maskSelect:WaitForChild("button_maskEquip").MouseButton1Click:connect(function()
        if selectedButton then
            local maskid = selectedButton.ID.Value
            game:GetService("ReplicatedStorage").SetMask:FireServer(selectedButton.ID.Value)
            if Data.Inventory.OwnedCustomMasks[maskid] then
                local maskstat = maskInfo[Data.Inventory.OwnedCustomMasks[maskid][1]]
                Data.Inventory.MaskName = Data.Inventory.OwnedCustomMasks[maskid][1]
                Data.Inventory.MyMaskStats = {
                    Data.Inventory.OwnedCustomMasks[maskid][2],
                    materialInfo[Data.Inventory.OwnedCustomMasks[maskid][3]],
                    maskstat.MeshId,
                    maskstat.Offset,
                    maskid
                }
                openMaskSelection(maskid)
            end
        end
    end)
    printTimeTaken("Inventory")
end
do
    local FakeCharacter = game:GetService("ReplicatedStorage"):WaitForChild("PlayerCharacter"):Clone()
    FakeCharacter.Parent = workspace
    repeat
        wait()
    until player.Character and player.HasAppearanceLoaded
    for _, v in pairs(player.Character:GetChildren()) do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("Accoutrement") or v:IsA("Accessory") or v:IsA("Hat") or v:IsA("CharacterMesh") or v:IsA("BodyColors") then
            local obj = v:clone()
            if obj:IsA("Hat") or obj:IsA("Accoutrement") then
                local handle = obj.Handle
                handle.Parent = FakeCharacter
                if handle:FindFirstChildWhichIsA("Weld") then
                    handle:FindFirstChildWhichIsA("Weld"):Destroy()
                end
                obj:Destroy()
                handle.CFrame = FakeCharacter.Head.CFrame * obj.AttachmentPoint:inverse() * CFrame.new(0, 0.5, -9.53674316E-7, 1, -1.89326617E-29, 0, -1.89326617E-29, 1, 2.5243549E-29, 0, 2.5243549E-29, 1)
                local w = Instance.new("Weld")
                w.Part0 = handle
                w.Part1 = FakeCharacter.Head
                w.C0 = handle.CFrame:inverse()
                w.C1 = FakeCharacter.Head.CFrame:inverse()
                w.Parent = FakeCharacter.Head
                handle.CanCollide = true
            else
                obj.Parent = FakeCharacter
            end
        elseif v.Name == "Head" then
            local Face = v:FindFirstChild("face")
            if Face then
                Face:clone().Parent = FakeCharacter.Head
            end
            local Mesh = v:FindFirstChildWhichIsA("DataModelMesh")
            if Mesh then
                Mesh:clone().Parent = FakeCharacter.Head
            end
        end
    end
    local animsFolder = FakeCharacter:WaitForChild("anims")
    local anims = {}
    for _, v in pairs(animsFolder:GetChildren()) do
        anims[v.Name] = FakeCharacter.Humanoid:LoadAnimation(v)
    end
    anims.idle:Play()
    spawn(function()
        while true do
            wait(math.random(30, 60))
            if math.random(1, 100) == 1 then
                anims.sit:Play()
            end
            wait(math.random(60, 180))
        end
    end)
    printTimeTaken("Inventory Character")
end
do
    local SocialService = game:GetService("SocialService")
    local invFrame = msgBox:WaitForChild("frame_inviteConfirmation")
    local canInvite = false
    local invitedFromMenu = false
    local myInvited = {}
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_refer").MouseButton1Click:connect(function()
        if not canInvite then
            return
        end
        msgBox.Visible = true
        menuMain.Visible = false
        for _, v in pairs(msgBox:GetChildren()) do
            v.Visible = false
        end
        invFrame.Visible = true
    end)
    invFrame:WaitForChild("button_confirm").MouseButton1Click:connect(function()
        if not canInvite then
            return
        end
        invitedFromMenu = true
        SocialService:PromptGameInvite(player)
        msgBox.Visible = false
    end)
    invFrame:WaitForChild("button_decline").MouseButton1Click:connect(function()
        invitedFromMenu = false
        msgBox.Visible = false
        menuMain.Visible = true
    end)
    SocialService.GameInvitePromptClosed:connect(function(senderPlayer, inviteList)
        if invitedFromMenu then
            msgBox.Visible = true
            if #inviteList > 0 then
                SFX.TerminalClick:Play()
            end
        end
        for i, v in pairs(inviteList) do
            if myInvited[tostring(v)] == nil then
                myInvited[tostring(v)] = 0
            end
        end
        game:GetService("ReplicatedStorage"):WaitForChild("RunInvite"):FireServer(myInvited)
    end)
    game:GetService("ReplicatedStorage"):WaitForChild("RunInvite").OnClientEvent:connect(function(updatedList, diamondSafesEarned, cardboardSafesEarned)
        myInvited = updatedList
        local stringText = "You earned " .. (diamondSafesEarned > 0 and tostring(diamondSafesEarned)) .. " diamond safe" .. (diamondSafesEarned ~= 1 and "s" or "")
        if diamondSafesEarned > 0 and cardboardSafesEarned > 0 then
            stringText = stringText .. " and "
        end
        stringText = stringText .. (cardboardSafesEarned > 0 and tostring(cardboardSafesEarned)) .. " cardboard 'safe'" .. (cardboardSafesEarned ~= 1 and "s" or "")
        SFX.ChaChing:Play()
        Data.Inventory.OwnedSafes["Diamond Safe"] = Data.Inventory.OwnedSafes["Diamond Safe"] and Data.Inventory.OwnedSafes["Diamond Safe"] + diamondSafesEarned or diamondSafesEarned
        Data.Inventory.OwnedSafes["Cardboard 'Safe'"] = Data.Inventory.OwnedSafes["Cardboard 'Safe'"] and Data.Inventory.OwnedSafes["Cardboard 'Safe'"] + cardboardSafesEarned or cardboardSafesEarned
        game.StarterGui:SetCore("SendNotification", {
            Title = "Invite accepted!",
            Text = stringText,
            Icon = "rbxassetid://1459151636",
            Duration = 30
        })
    end)
    spawn(function()
        local s, m = pcall(function()
            canInvite = SocialService:CanSendGameInviteAsync(player)
        end)
        canInvite = false
        if not canInvite then
            menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_refer").Visible = false
        end
    end)
    printTimeTaken("Referral System")
end
repeat
    do break end
    do
        local outlawFrame = UI:WaitForChild("frame_mainMenu"):WaitForChild("frame_outlawTracker")
        local progressFrame = outlawFrame:WaitForChild("frame_progress")
        local heistList = Data.Inventory.RecentlyPlayed
        outlawFrame.Visible = true
        local function getLowest(lowerBound, nameList)
            local lowestID = math.huge
            local lowestIndex
            for i, v in pairs(heistList) do
                local id = v[1]
                if v[4] and lowestID > id and lowerBound < id and not nameList[v[2]] then
                    lowestID = id
                    lowestIndex = i
                end
            end
            return lowestID, lowestIndex
        end
        if heistList ~= nil then
            do
                local originalText = outlawFrame.text_warning01.Text
                local lastLowest = -1
                local nameList = {}
                local failed = false
                local difficultySum = 0
                local num = 0
                for i = 1, 3 do
                    local lowestID, lowestIndex = getLowest(lastLowest, nameList)
                    if lowestIndex then
                        num = i
                        lastLowest = lowestID
                        difficultySum = difficultySum + heistList[lowestIndex][3]
                        progressFrame["frame_heist" .. i].heistImg.Image = heistInfo[heistList[lowestIndex][2]] and heistInfo[heistList[lowestIndex][2]].Image or ""
                        nameList[heistList[lowestIndex][2]] = true
                        do
                            local name = heistList[lowestIndex][2]
                            progressFrame["frame_heist" .. i].TextButton.MouseEnter:connect(function()
                                outlawFrame.text_warning01.Text = "You completed " .. name .. "! Complete other heists to make progress towards the safe!"
                            end)
                            progressFrame["frame_heist" .. i].TextButton.MouseLeave:connect(function()
                                outlawFrame.text_warning01.Text = originalText
                            end)
                        end
                    else
                        progressFrame["frame_heist" .. i].heistImg.Image = ""
                        progressFrame["frame_heist" .. i].TextButton.MouseEnter:connect(function()
                            outlawFrame.text_warning01.Text = "Press the PLAY GAME button above and start or join a heist to earn this!"
                        end)
                        progressFrame["frame_heist" .. i].TextButton.MouseLeave:connect(function()
                            outlawFrame.text_warning01.Text = originalText
                        end)
                        if not failed then
                            local tween = game:GetService("TweenService"):Create(progressFrame["frame_heist" .. i], TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {
                                BackgroundColor3 = Color3.new(0, 0.5, 0.5)
                            })
                            tween:Play()
                            failed = true
                        end
                    end
                end
                if not failed then
                    do
                        local tween = game:GetService("TweenService"):Create(outlawFrame.button_redeem.buttonText, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {
                            TextColor3 = Color3.new(1, 1, 0.4980392156862745)
                        })
                        tween:Play()
                        outlawFrame.button_redeem.Visible = true
                        outlawFrame.textCount.Visible = false
                        local con
                        con = outlawFrame.button_redeem.MouseButton1Click:connect(function()
                            con:Disconnect()
                            tween:Cancel()
                            game:GetService("ReplicatedStorage"):WaitForChild("UnlockedOutlaw"):FireServer(difficultySum)
                            outlawFrame.button_redeem.Visible = false
                            SFX.TerminalClick:Play()
                            SFX.Earn:Play()
                            local cashEarned = difficultySum * 15000
                            outlawFrame.text_warning01.Text = "Congratulations! You earned 1 Outlaw Safe and $" .. convertToCommas(cashEarned) .. "! You can access safes from your inventory!"
                            outlawFrame.text_warning01.TextColor3 = Color3.new(0, 1, 0)
                            outlawFrame.textCount.Visible = true
                            outlawFrame.textCount.Text = "Complete more heists to earn additional rewards!"
                            Data.Inventory.Cash = Data.Inventory.Cash + cashEarned
                            Data.Inventory.OwnedSafes["Outlaw Safe"] = Data.Inventory.OwnedSafes["Outlaw Safe"] and Data.Inventory.OwnedSafes["Outlaw Safe"] + 1 or 1
                            Data.Inventory.RecentlyPlayed = {}
                            playerGui:WaitForChild("StatsChange"):Fire()
                            for i = 1, 3 do
                                progressFrame["frame_heist" .. i].heistImg.Image = ""
                                if i == 1 then
                                    local tween = game:GetService("TweenService"):Create(progressFrame["frame_heist" .. i], TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {
                                        BackgroundColor3 = Color3.new(0, 0.5, 0.5)
                                    })
                                    tween:Play()
                                end
                            end
                        end)
                    end
                else
                    outlawFrame.button_redeem.Visible = false
                    outlawFrame.textCount.Visible = true
                    outlawFrame.textCount.Text = "Progress: " .. num .. "/3"
                end
            end
        end
    end
until true
printTimeTaken("LiveOpsEvent")
do
    local restoreFrame = msgBox:WaitForChild("frame_restoreDataConfirmation")
    local names = {
        TiredDays = true,
        iby1234567 = true,
        HerobrineTrollGamer = true,
        GPUOverHeat = true,
        hacker_reaperdanny = true,
        rcmppolice42 = true,
        superherojoker1 = true,
        XDogeGamer = true,
        Spongocardo = true,
        whatsomeonesaid = true,
        Brick_man = true,
        steelbandit25 = true,
        Blaze360a = true,
        DrivingHorses420 = true,
        Vibxrzz = true,
        SomeNoobWhoWreckYa = true
    }
    if not Data.Inventory.DidJanuaryReset then
        for name, _ in pairs(names) do
            if name:lower() == player.Name:lower() then
                menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_restoreData").Visible = true
            end
        end
    end
    menuMain:WaitForChild("frame_buttonContainer"):WaitForChild("button_restoreData").MouseButton1Click:connect(function()
        msgBox.Visible = true
        menuMain.Visible = false
        for _, v in pairs(msgBox:GetChildren()) do
            v.Visible = false
        end
        restoreFrame.Visible = true
    end)
    restoreFrame:WaitForChild("button_confirm").MouseButton1Click:connect(function()
        msgBox.Visible = false
        game:GetService("ReplicatedStorage"):WaitForChild("RestoreBackup"):FireServer()
    end)
    restoreFrame:WaitForChild("button_decline").MouseButton1Click:connect(function()
        msgBox.Visible = false
        menuMain.Visible = true
    end)
    printTimeTaken("JanuaryRestore")
end