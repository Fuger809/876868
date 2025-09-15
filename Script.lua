print("Loading Herkle Hub -- Booga Booga Reborn")
print("-----------------------------------------")
local Library = loadstring(game:HttpGetAsync("https://github.com/1dontgiveaf/Fluent-Renewed/releases/download/v1.0/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/1dontgiveaf/Fluent-Renewed/refs/heads/main/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/1dontgiveaf/Fluent-Renewed/refs/heads/main/Addons/InterfaceManager.luau"))()
 
local Window = Library:CreateWindow{
    Title = "Herkle Hub -- Booga Booga Reborn",
    SubTitle = "by herkle berlington",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
}

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "menu" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "axe" }),
    Map = Window:AddTab({ Title = "Map", Icon = "trees" }),
    Pickup = Window:AddTab({ Title = "Pickup", Icon = "backpack" }),
    Farming = Window:AddTab({ Title = "Farming", Icon = "sprout" }),
    Extra = Window:AddTab({ Title = "Extra", Icon = "plus" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local rs = game:GetService("ReplicatedStorage")
local packets = require(rs.Modules.Packets)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local runs = game:GetService("RunService")
local httpservice = game:GetService("HttpService")
local Players = game:GetService("Players")
local localiservice = game:GetService("LocalizationService")
local marketservice = game:GetService("MarketplaceService")
local rbxservice = game:GetService("RbxAnalyticsService")
local placestructure
local tspmo = game:GetService("TweenService")
local itemslist = {
"Adurite", "Berry", "Bloodfruit", "Bluefruit", "Coin", "Essence", "Hide", "Ice Cube", "Iron", "Jelly", "Leaves", "Log", "Steel", "Stone", "Wood", "Gold", "Raw Gold", "Crystal Chunk", "Raw Emerald", "Pink Diamond", "Raw Adurite", "Raw Iron", "Coal"}
local Options = Library.Options
--{MAIN TAB}
local wstoggle = Tabs.Main:CreateToggle("wstoggle", { Title = "Walkspeed", Default = false })
local wsslider = Tabs.Main:CreateSlider("wsslider", { Title = "Value", Min = 1, Max = 35, Rounding = 1, Default = 16 })
local jptoggle = Tabs.Main:CreateToggle("jptoggle", { Title = "JumpPower", Default = false })
local jpslider = Tabs.Main:CreateSlider("jpslider", { Title = "Value", Min = 1, Max = 65, Rounding = 1, Default = 50 })
local hheighttoggle = Tabs.Main:CreateToggle("hheighttoggle", { Title = "HipHeight", Default = false })
local hheightslider = Tabs.Main:CreateSlider("hheightslider", { Title = "Value", Min = 0.1, Max = 6.5, Rounding = 1, Default = 2 })
local msatoggle = Tabs.Main:CreateToggle("msatoggle", { Title = "No Mountain Slip", Default = false })
Tabs.Main:CreateButton({Title = "Copy Job ID", Callback = function() setclipboard(game.JobId) end})
Tabs.Main:CreateButton({Title = "Copy HWID", Callback = function() setclipboard(rbxservice:GetClientId()) end})
Tabs.Main:CreateButton({Title = "Copy SID", Callback = function() setclipboard(rbxservice:GetSessionId()) end})
--{COMBAT TAB}
local killauratoggle = Tabs.Combat:CreateToggle("killauratoggle", { Title = "Kill Aura", Default = false })
local killaurarangeslider = Tabs.Combat:CreateSlider("killaurarange", { Title = "Range", Min = 1, Max = 9, Rounding = 1, Default = 5 })
local katargetcountdropdown = Tabs.Combat:CreateDropdown("katargetcountdropdown", { Title = "Max Targets", Values = { "1", "2", "3", "4", "5", "6" }, Default = "1" })
local kaswingcooldownslider = Tabs.Combat:CreateSlider("kaswingcooldownslider", { Title = "Attack Cooldown (s)", Min = 0.01, Max = 1.01, Rounding = 2, Default = 0.1 })
--{MAP TAB}
local resourceauratoggle = Tabs.Map:CreateToggle("resourceauratoggle", { Title = "Resource Aura", Default = false })
local resourceaurarange = Tabs.Map:CreateSlider("resourceaurarange", { Title = "Range", Min = 1, Max = 20, Rounding = 1, Default = 20 })
local resourcetargetdropdown = Tabs.Map:CreateDropdown("resourcetargetdropdown", { Title = "Max Targets", Values = { "1", "2", "3", "4", "5", "6" }, Default = "1" })
local resourcecooldownslider = Tabs.Map:CreateSlider("resourcecooldownslider", { Title = "Swing Cooldown (s)", Min = 0.01, Max = 1.01, Rounding = 2, Default = 0.1 })
local critterauratoggle = Tabs.Map:CreateToggle("critterauratoggle", { Title = "Critter Aura", Default = false })
local critterrangeslider = Tabs.Map:CreateSlider("critterrangeslider", { Title = "Range", Min = 1, Max = 20, Rounding = 1, Default = 20 })
local crittertargetdropdown = Tabs.Map:CreateDropdown("crittertargetdropdown", { Title = "Max Targets", Values = { "1", "2", "3", "4", "5", "6" }, Default = "1" })
local crittercooldownslider = Tabs.Map:CreateSlider("crittercooldownslider", { Title = "Swing Cooldown (s)", Min = 0.01, Max = 1.01, Rounding = 2, Default = 0.1 })
--{PICKUP TAB}
local autopickuptoggle = Tabs.Pickup:CreateToggle("autopickuptoggle", { Title = "Auto Pickup", Default = false })
local chestpickuptoggle = Tabs.Pickup:CreateToggle("chestpickuptoggle", { Title = "Auto Pickup From Chests", Default = false })
local pickuprangeslider = Tabs.Pickup:CreateSlider("pickuprange", { Title = "Pickup Range", Min = 1, Max = 35, Rounding = 1, Default = 20 })
local itemdropdown = Tabs.Pickup:CreateDropdown("itemdropdown", {Title = "Items", Values = {"Berry", "Bloodfruit", "Bluefruit", "Lemon", "Strawberry", "Gold", "Raw Gold", "Crystal Chunk", "Coin", "Coins", "Coin2", "Coin Stack", "Essence", "Emerald", "Raw Emerald", "Pink Diamond", "Raw Pink Diamond", "Void Shard","Jelly", "Magnetite", "Raw Magnetite", "Adurite", "Raw Adurite", "Ice Cube", "Stone", "Iron", "Raw Iron", "Steel", "Hide", "Leaves", "Log", "Wood", "Pie"}, Multi = true, Default = { Leaves = true, Log = true }})
local droptoggle = Tabs.Pickup:AddToggle("droptoggle", { Title = "Auto Drop", Default = false })
local dropdropdown = Tabs.Pickup:AddDropdown("dropdropdown", {Title = "Select Item to Drop", Values = { "Bloodfruit", "Jelly", "Bluefruit", "Log", "Leaves", "Wood" }, Default = "Bloodfruit"})
local droptogglemanual = Tabs.Pickup:AddToggle("droptogglemanual", { Title = "Auto Drop Custom", Default = false })
local droptextbox = Tabs.Pickup:AddInput("droptextbox", { Title = "Custom Item", Default = "Bloodfruit", Numeric = false, Finished = false })
-- Добавляем вкладку Tp-pos
Tabs.TpPos = Window:AddTab({ Title = "Tp-pos", Icon = "location" })

--{FARMING TAB}
local fruitdropdown = Tabs.Farming:CreateDropdown("fruitdropdown", {Title = "Select Fruit",Values = {"Bloodfruit", "Bluefruit", "Lemon", "Coconut", "Jelly", "Banana", "Orange", "Oddberry", "Berry", "Strangefruit", "Strawberry", "Sunjfruit", "Pumpkin", "Prickly Pear", "Apple",  "Barley", "Cloudberry", "Carrot"}, Default = "Bloodfruit"})
local planttoggle = Tabs.Farming:CreateToggle("planttoggle", { Title = "Auto Plant", Default = false })
local plantrangeslider = Tabs.Farming:CreateSlider("plantrange", { Title = "Plant Range", Min = 1, Max = 30, Rounding = 1, Default = 30 })
local plantdelayslider = Tabs.Farming:CreateSlider("plantdelay", { Title = "Plant Delay (s)", Min = 0.01, Max = 1, Rounding = 2, Default = 0.1 })
local harvesttoggle = Tabs.Farming:CreateToggle("harvesttoggle", { Title = "Auto Harvest", Default = false })
local harvestrangeslider = Tabs.Farming:CreateSlider("harvestrange", { Title = "Harvest Range", Min = 1, Max = 30, Rounding = 1, Default = 30 })
Tabs.Farming:CreateParagraph("Aligned Paragraph", {Title = "Tween Stuff", Content = "wish this ui was more like linoria :(", TitleAlignment = "Middle", ContentAlignment = Enum.TextXAlignment.Center})
local tweenplantboxtoggle = Tabs.Farming:AddToggle("tweentoplantbox", { Title = "Tween to Plant Box", Default = false })
local tweenbushtoggle = Tabs.Farming:AddToggle("tweentobush", { Title = "Tween to Bush + Plant Box", Default = false })
local tweenrangeslider = Tabs.Farming:AddSlider("tweenrange", { Title = "Range", Min = 1, Max = 250, Rounding = 1, Default = 250 })
Tabs.Farming:CreateParagraph("Aligned Paragraph", {Title = "Plantbox Stuff", Content = "wish this ui was more like linoria :(", TitleAlignment = "Middle", ContentAlignment = Enum.TextXAlignment.Center})
Tabs.Farming:CreateButton({Title = "Place 16x16 Plantboxes (256)", Callback = function() placestructure(16) end })
Tabs.Farming:CreateButton({Title = "Place 15x15 Plantboxes (225)", Callback = function() placestructure(15) end })
Tabs.Farming:CreateButton({Title = "Place 10x10 Plantboxes (100)", Callback = function() placestructure(10) end })
Tabs.Farming:CreateButton({Title = "Place 5x5 Plantboxes (25)", Callback = function() placestructure(5) end })
--{EXTRA TAB}
Tabs.Extra:CreateButton({Title = "Infinite Yield", Description = "inf yield chat", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/decryp1/herklesiy/refs/heads/main/hiy"))()end})
Tabs.Extra:CreateParagraph("Aligned Paragraph", {Title = "orbit breaks sometimes", Content = "i dont give a shit", TitleAlignment = "Middle", ContentAlignment = Enum.TextXAlignment.Center})
local orbittoggle = Tabs.Extra:CreateToggle("orbittoggle", { Title = "Item Orbit", Default = false })
local orbitrangeslider = Tabs.Extra:CreateSlider("orbitrange", { Title = "Grab Range", Min = 1, Max = 50, Rounding = 1, Default = 20 })
local orbitradiusslider = Tabs.Extra:CreateSlider("orbitradius", { Title = "Orbit Radius", Min = 0, Max = 30, Rounding = 1, Default = 10 })
local orbitspeedslider = Tabs.Extra:CreateSlider("orbitspeed", { Title = "Orbit Speed", Min = 0, Max = 10, Rounding = 1, Default = 5 })
local itemheightslider = Tabs.Extra:CreateSlider("itemheight", { Title = "Item Height", Min = -3, Max = 10, Rounding = 1, Default = 3 })
--{END OF TAB ELEMENTS}

-- ============================================
-- TAB: Gold BV (v5.6 — hover-ground + instant break + hotbar equip + slope/retarget fixes)
-- ============================================
do
    local PFS       = game:GetService("PathfindingService")
    local RS        = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local Players   = game:GetService("Players")

    -- Tab
    Tabs.GoldBV = Tabs.GoldBV or Window:AddTab({ Title = "Gold BV", Icon = "compass" })

    -- UI
    Tabs.GoldBV:CreateToggle("aw_on",        { Title = "Auto path to Gold (BV)", Default = false })
    Tabs.GoldBV:CreateSlider("aw_rng",       { Title = "Scan range",     Min=80,  Max=800, Rounding=0, Default=300 })
    Tabs.GoldBV:CreateSlider("aw_spd",       { Title = "Speed (BV)",     Min=8,   Max=60,  Rounding=0, Default=20 })
    Tabs.GoldBV:CreateToggle("aw_gps",       { Title = "Show GPS dots",  Default = true })
    Tabs.GoldBV:CreateSlider("aw_gap",       { Title = "GPS dot gap",    Min=3,   Max=12,  Rounding=0, Default=7 })
    Tabs.GoldBV:CreateToggle("aw_antistuck", { Title = "Anti-stuck",     Default = true })
    Tabs.GoldBV:CreateToggle("aw_keepY",     { Title = "BV keep level Y (surface glide)", Default = true })
    Tabs.GoldBV:CreateSlider("aw_hover",     { Title = "Ground hover height (studs)", Min = 1.5, Max = 4.0, Rounding = 1, Default = 2.6 })

    Tabs.GoldBV:CreateToggle("aw_ice",       { Title = "Break ice near gold", Default = true })
    Tabs.GoldBV:CreateSlider("aw_cd",        { Title = "Swing cooldown (s)", Min=0.06, Max=0.40, Rounding=2, Default=0.12 })
    Tabs.GoldBV:CreateSlider("aw_hit",       { Title = "Start breaking at ≤ (studs)", Min=4, Max=15, Rounding=0, Default=9 })

    Tabs.GoldBV:CreateToggle("aw_autoeq",    { Title = "Auto-equip tools (God Pick/Axe)", Default = true })
    Tabs.GoldBV:CreateToggle("aw_prescan",   { Title = "Prescan whole map before start", Default = true })
    Tabs.GoldBV:CreateToggle("aw_prefetch",  { Title = "Prefetch next target while breaking", Default = true })
    Tabs.GoldBV:CreateToggle("aw_retarget",  { Title = "Retarget on the fly", Default = true })
    Tabs.GoldBV:CreateSlider("aw_ret_pct",   { Title = "Retarget better by (%)", Min=1, Max=50, Rounding=0, Default=35 })
    Tabs.GoldBV:CreateSlider("aw_ret_abs",   { Title = "Retarget better by (studs)", Min=1, Max=80, Rounding=0, Default=35 })
    Tabs.GoldBV:CreateSlider("aw_ret_int",   { Title = "Retarget check interval (s)", Min=0, Max=2, Rounding=2, Default=1.2 })

    Tabs.GoldBV:CreateSlider("aw_k_up",      { Title = "Cost coeff: climb (U)",  Min=0, Max=2,   Rounding=2, Default=0.6 })
    Tabs.GoldBV:CreateSlider("aw_k_down",    { Title = "Cost coeff: drop (D)",   Min=0, Max=2,   Rounding=2, Default=0.2 })
    Tabs.GoldBV:CreateSlider("aw_k_jump",    { Title = "Cost coeff: jump",       Min=0, Max=3,   Rounding=2, Default=1.2 })
    Tabs.GoldBV:CreateSlider("aw_k_turn",    { Title = "Cost coeff: turns",      Min=0, Max=1.5, Rounding=2, Default=0.25 })
    Tabs.GoldBV:CreateSlider("aw_k_water",   { Title = "Cost coeff: water len",  Min=0, Max=3,   Rounding=2, Default=1.0 })

    Tabs.GoldBV:CreateToggle("aw_timer",     { Title = "Show respawn timers", Default = true })
    Tabs.GoldBV:CreateSlider("aw_respawn",   { Title = "Respawn time (s)", Min=30, Max=900, Rounding=0, Default=180 })
    Tabs.GoldBV:CreateSlider("aw_respawnr",  { Title = "Detect radius (studs)", Min=3, Max=20, Rounding=0, Default=10 })

    -- Helpers
    local function awRoot() local c=plr.Character return c and c:FindFirstChild("HumanoidRootPart") or nil end
    local function awHum()  local c=plr.Character return c and c:FindFirstChildOfClass("Humanoid") or nil end
    local function awAlive() local h=awHum() return h and h.Health>0 end
    local function hrpPos() local r=awRoot() return r and r.Position or nil end

    -- Swing / Ice
    local function swing(ids)
        if packets and packets.SwingTool and packets.SwingTool.send then
            pcall(function() packets.SwingTool.send(ids) end)
        elseif typeof(_G.swingtool)=="function" then
            pcall(function() _G.swingtool(ids) end)
        end
    end
    local function iceNear(pos,r)
        if not Options.aw_ice.Value then return nil end
        local near,bd
        for _,inst in ipairs(Workspace:GetDescendants()) do
            if inst:IsA("Model") and inst.Name=="Ice Chunk" then
                local pp=inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart")
                local eid=inst:GetAttribute("EntityID")
                if pp and eid then
                    local d=(pp.Position-pos).Magnitude
                    if d<=r and (not bd or d<bd) then near,bd=eid,d end
                end
            end
        end
        return near
    end

    -- GPS (pool)
    local gpsFolder = Workspace:FindFirstChild("_AW_GPS") or Instance.new("Folder", Workspace); gpsFolder.Name="_AW_GPS"
    local dotPool, inUse, blinkT, blinkFlip = {}, {}, 0, false
    local function acquireDot()
        local p=table.remove(dotPool)
        if not p or not p.Parent then
            p=Instance.new("Part"); p.Name="_aw_dot"; p.Anchored=true; p.CanCollide=false; p.CanQuery=false; p.CanTouch=false
            p.Shape=Enum.PartType.Ball; p.Material=Enum.Material.Neon; p.Color=Color3.fromRGB(255,220,80)
            p.Size=Vector3.new(0.6,0.6,0.6); p.Parent=gpsFolder
        end
        inUse[p]=true; return p
    end
    local function clearGPS() for p,_ in pairs(inUse) do inUse[p]=nil; p.Transparency=0.7; p.CFrame=CFrame.new(0,-1e5,0); table.insert(dotPool,p) end end
    local function drawGPS(points)
        clearGPS(); if not (Options.aw_gps.Value and #points>=2) then return end
        local gap=Options.aw_gap.Value
        for i=1,#points-1 do
            local a,b=points[i],points[i+1]; local seg=b-a; local len=seg.Magnitude
            if len>0 then local u=seg.Unit; local steps=math.max(1, math.floor(len/gap))
                for s=0,steps do local d=acquireDot(); d.CFrame=CFrame.new(a+u*(s*gap)+Vector3.new(0,0.15,0)); d.Transparency=0.25 end
            end
        end
        local last=acquireDot(); last.Size=Vector3.new(0.9,0.9,0.9); last.CFrame=CFrame.new(points[#points]+Vector3.new(0,0.15,0)); last.Transparency=0.1
    end
    RS.Heartbeat:Connect(function(dt) blinkT+=dt; if blinkT>=0.5 then blinkT=0; blinkFlip=not blinkFlip; local t=blinkFlip and 0.25 or 0.65; for p,_ in pairs(inUse) do p.Transparency=t end end end)

    -- Timers
    local timerFolder = Workspace:FindFirstChild("_AW_TIMERS") or Instance.new("Folder", Workspace); timerFolder.Name="_AW_TIMERS"
    local timers, nextTid = {}, 0
    local function fmtTime(t) t=math.max(0, math.floor(t+0.5)); return string.format("%d:%02d", math.floor(t/60), t%02d) end
    local function removeTimer(id) local t=timers[id]; if t and t.part then t.part:Destroy() end; timers[id]=nil end
    local function addTimer(worldPos)
        if not Options.aw_timer.Value then return end
        nextTid+=1; local id=nextTid
        local p=Instance.new("Part"); p.Name="_aw_timer"; p.Anchored=true; p.CanCollide=false; p.Transparency=1
        p.Size=Vector3.new(0.1,0.1,0.1); p.CFrame=CFrame.new(worldPos+Vector3.new(0,3,0)); p.Parent=timerFolder
        local bb=Instance.new("BillboardGui",p); bb.AlwaysOnTop=true; bb.Size=UDim2.fromOffset(120,40)
        local txt=Instance.new("TextLabel",bb); txt.BackgroundTransparency=0.2; txt.BackgroundColor3=Color3.fromRGB(30,30,42)
        txt.TextColor3=Color3.fromRGB(255,230,120); txt.TextScaled=true; txt.Font=Enum.Font.GothamSemibold; txt.Size=UDim2.fromScale(1,1)
        local endsAt=time()+Options.aw_respawn.Value; txt.Text="⏳ "..fmtTime(endsAt-time())
        timers[id]={part=p,label=txt,endsAt=endsAt,pos=worldPos}; return id
    end
    RS.Heartbeat:Connect(function()
        if not Options.aw_timer.Value then for id,_ in pairs(timers) do removeTimer(id) end; return end
        local now=time()
        for id,t in pairs(timers) do local left=t.endsAt-now; if left<=0 then removeTimer(id) elseif t.label then t.label.Text="⏳ "..fmtTime(left) end end
    end)
    Workspace.DescendantAdded:Connect(function(inst)
        if not Options.aw_timer.Value then return end
        if inst:IsA("Model") and inst.Name=="Gold Node" then
            task.defer(function()
                local pp=inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart"); if not pp then return end
                local r=Options.aw_respawnr.Value
                for id,t in pairs(timers) do if (pp.Position-t.pos).Magnitude<=r then removeTimer(id) end end
            end)
        end
    end)

    -- Live cache + spatial hash
    local CELL=96
    local goldCache, goldList, grid, entrances = {}, {}, {}, {}
    local prescanned=false

    local function tclear(t) if table.clear then table.clear(t) else for k in pairs(t) do t[k]=nil end end end
    local function gridKey(v) return string.format("%d|%d", math.floor(v.X/CELL), math.floor(v.Z/CELL)) end
    local function gridAdd(rec) local k=gridKey(rec.pos); local b=grid[k]; if not b then b={} grid[k]=b end; b[#b+1]=rec; rec._gridKey=k end
    local function gridRemove(rec) local k=rec._gridKey; if not k then return end; local b=grid[k]; if not b then return end; for i=#b,1,-1 do if b[i]==rec then table.remove(b,i) break end end; rec._gridKey=nil end

    local function addGold(inst)
        if goldCache[inst] then return end
        local pp=inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart"); if not pp then return end
        local rec={model=inst, pos=pp.Position, eid=inst:GetAttribute("EntityID")}
        goldCache[inst]=rec; goldList[#goldList+1]=rec; gridAdd(rec)
        inst:GetPropertyChangedSignal("Parent"):Connect(function()
            if not inst.Parent then
                local r=goldCache[inst]; if not r then return end
                gridRemove(r); for i=#goldList,1,-1 do if goldList[i]==r then table.remove(goldList,i) break end end
                goldCache[inst]=nil
            end
        end)
        pp:GetPropertyChangedSignal("Position"):Connect(function() rec.pos=pp.Position; gridRemove(rec); gridAdd(rec) end)
    end
    local function fullScan()
        for k in pairs(goldCache) do goldCache[k]=nil end; tclear(goldList); tclear(grid); tclear(entrances)
        for _,inst in ipairs(Workspace:GetDescendants()) do
            if inst:IsA("Model") then
                if inst.Name=="Gold Node" then addGold(inst)
                else
                    local n=inst.Name:lower()
                    if n:find("cave") or n:find("entrance") or n:find("mine") then
                        local pp=inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart"); if pp then entrances[#entrances+1]={model=inst,pos=pp.Position} end
                    end
                end
            end
        end
        prescanned=true
        if Library and Library.Notify then
            Library:Notify({Title="Gold BV", Content=("Prescan done: %d gold, %d entrances"):format(#goldList,#entrances), Duration=6})
        end
        print(("[GoldBV] Prescan: %d gold, %d entrances"):format(#goldList,#entrances))
    end
    Workspace.DescendantAdded:Connect(function(inst) if inst:IsA("Model") and inst.Name=="Gold Node" then task.defer(function() addGold(inst) end) end end)
    Workspace.DescendantRemoving:Connect(function(inst)
        local rec=goldCache[inst]; if not rec then return end
        gridRemove(rec); for i=#goldList,1,-1 do if goldList[i]==rec then table.remove(goldList,i) break end end
        goldCache[inst]=nil
    end)

    local function gatherCandidates(pos, range)
        if range<=0 then return {} end
        local cells,out={},{}
        local cx,cz=math.floor(pos.X/CELL), math.floor(pos.Z/CELL)
        local span=math.ceil(range/CELL)+1
        for dx=-span,span do for dz=-span,span do local k=string.format("%d|%d",cx+dx,cz+dz); local b=grid[k]; if b then cells[#cells+1]=b end end end
        for _,bucket in ipairs(cells) do for _,rec in ipairs(bucket) do if (rec.pos-pos).Magnitude<=range then out[#out+1]=rec end end end
        if #out==0 and #goldList>0 then for _,rec in ipairs(goldList) do if (rec.pos-pos).Magnitude<=range then out[#out+1]=rec end end end
        table.sort(out, function(a,b) return (a.pos-pos).Magnitude < (b.pos-pos).Magnitude end)
        return out
    end

    -- Path + scoring
    local function buildPath(fromPos,toPos)
        local pf=PFS:CreatePath({AgentRadius=2,AgentHeight=5,AgentCanJump=true,WaypointSpacing=2})
        local ok=pcall(function() pf:ComputeAsync(fromPos,toPos) end)
        if ok and pf.Status==Enum.PathStatus.Success then local wps=pf:GetWaypoints() if wps and #wps>=2 then return pf,wps end end
        return nil,nil
    end
    local function wpsToPoints(wps) local pts=table.create(#wps) for i=1,#wps do pts[i]=wps[i].Position end return pts end

    local rcParams = RaycastParams.new(); rcParams.FilterType=Enum.RaycastFilterType.Blacklist
    local function waterLenOnSegment(a,b)
        local steps=math.max(1, math.floor((b-a).Magnitude/12)); local len=0
        for i=1,steps do
            local p=a+(b-a)*(i/steps); local origin=p+Vector3.new(0,40,0); local dir=Vector3.new(0,-120,0)
            rcParams.FilterDescendantsInstances={plr.Character}
            local hit=Workspace:Raycast(origin,dir,rcParams)
            if hit and hit.Material==Enum.Material.Water then len += ((b-a).Magnitude/steps) end
        end
        return len
    end
    local function scorePath(wps)
        local kU,kD,kJ,kT,kW = Options.aw_k_up.Value, Options.aw_k_down.Value, Options.aw_k_jump.Value, Options.aw_k_turn.Value, Options.aw_k_water.Value
        local L,U,D,Jumps,Turns,Wlen,prevDir = 0,0,0,0,0,0,nil
        for i=2,#wps do
            local a=wps[i-1].Position; local b=wps[i].Position; local seg=b-a; L+=seg.Magnitude
            local dy=b.Y-a.Y; if dy>0 then U+=dy else D+=-dy end
            if wps[i].Action==Enum.PathWaypointAction.Jump then Jumps+=1 end
            if prevDir then local dir=seg.Unit; local dot=math.clamp(prevDir:Dot(dir),-1,1); local ang=math.acos(dot); Turns+=ang; prevDir=dir else prevDir=seg.Unit end
            Wlen += waterLenOnSegment(a,b)
        end
        local J=L + kU*U + kD*D + kJ*Jumps + kT*Turns*10 + kW*Wlen
        return J,L
    end
    local function bestPlan(fromPos, range, excludeModel)
        local cands=gatherCandidates(fromPos, range); if #cands==0 then return nil end
        local best,bestJ; local bestDirect; local LIMIT=math.min(12,#cands)
        for i=1,LIMIT do
            local c=cands[i]; if c.model~=excludeModel then
                local pf,wps=buildPath(fromPos, c.pos)
                if wps then local J,L=scorePath(wps); if not bestJ or J<bestJ then bestJ=J; best={pts=wpsToPoints(wps), target=c, J=J, L=L} end
                else bestDirect = bestDirect or {pts={fromPos,c.pos}, target=c, direct=true, J=(fromPos-c.pos).Magnitude} end
            end
        end
        return best or bestDirect
    end

    -- ---------- auto-equip tools (hotbar-aware) ----------
    local GOD_PICK = "God Pick"
    local GOD_AXE  = "God Axe"
    local PICK_CANDIDATES = { "God Pick","Magnetite Pick","Steel Pick","Iron Pick","Stone Pick","Pickaxe","Pick" }
    local AXE_CANDIDATES  = { "God Axe","Magnetite Axe","Steel Axe","Iron Axe","Stone Axe","Axe" }

    local function tryPacketSend(pkt, arg)
        local ok=false
        pcall(function() if pkt and pkt.send then pkt.send(arg); ok=true end end); if ok then return true end
        if typeof(arg)=="string" then
            pcall(function() if pkt and pkt.send then pkt.send({item=arg}) end end); if ok then return true end
            pcall(function() if pkt and pkt.send then pkt.send({Item=arg}) end end); if ok then return true end
            pcall(function() if pkt and pkt.send then pkt.send({Name=arg}) end end); if ok then return true end
            pcall(function() if pkt and pkt.send then pkt.send({Tool=arg}) end end); if ok then return true end
        elseif typeof(arg)=="number" then
            pcall(function() if pkt and pkt.send then pkt.send({slot=arg}) end end); if ok then return true end
            pcall(function() if pkt and pkt.send then pkt.send({Slot=arg}) end end); if ok then return true end
            pcall(function() if pkt and pkt.send then pkt.send({Index=arg}) end end); if ok then return true end
        end
        return ok
    end
    local function equipViaName(name)
        if not packets then return false end
        local tries = {
            packets.EquipItem, packets.EquipTool, packets.Equip,
            packets.Hotbar and packets.Hotbar.Equip,
            packets.Inventory and packets.Inventory.EquipItem,
            packets.Inventory and packets.Inventory.Equip
        }
        for _,pkt in ipairs(tries) do if tryPacketSend(pkt, name) then return true end end
        return false
    end
    local function findHotbarSlotIndexByNames(nameList)
        local pg = plr:FindFirstChildOfClass("PlayerGui"); if not pg then return nil end
        local function readSlotIndex(inst)
            if inst.GetAttribute then
                local s = inst:GetAttribute("Slot")
                if typeof(s)=="number" then return s end
                if typeof(s)=="string" then local n=tonumber(s) if n then return n end end
            end
            local p=inst
            for _=1,4 do
                if not p then break end
                local num = tonumber((p.Name or ""):match("%d+"))
                if num then return num end
                p=p.Parent
            end
            return nil
        end
        local found
        for _,d in ipairs(pg:GetDescendants()) do
            for _,key in ipairs({"ItemName","Item","Tool","DisplayName","Name"}) do
                local v = d.GetAttribute and d:GetAttribute(key)
                if typeof(v)=="string" then
                    for _,want in ipairs(nameList) do
                        if v==want then found = readSlotIndex(d); if found then break end end
                    end
                end
                if found then break end
            end
            if found then break end
            if d:IsA("TextLabel") then
                for _,want in ipairs(nameList) do
                    if d.Text==want then found = readSlotIndex(d); if found then break end end
                end
            end
            if found then break end
        end
        return found
    end
    local function selectHotbarSlot(idx)
        if not packets then return false end
        local tries = {
            packets.Hotbar and packets.Hotbar.Select,
            packets.Hotbar and packets.Hotbar.EquipSlot,
            packets.Slots  and packets.Slots.Select,
            packets.Slots  and packets.Slots.EquipSlot,
            packets.EquipSlot, packets.SelectSlot
        }
        for _,pkt in ipairs(tries) do if tryPacketSend(pkt, idx) then return true end end
        return false
    end
    local function ensureAnyTool(nameList)
        if not Options.aw_autoeq.Value then return true end
        for _,nm in ipairs(nameList) do if equipViaName(nm) then return true end end
        local idx = findHotbarSlotIndexByNames(nameList)
        if idx and selectHotbarSlot(idx) then return true end
        -- fallback Backpack/Tool
        local char, bag = plr.Character, plr.Backpack
        if char then for _,nm in ipairs(nameList) do local t=char:FindFirstChild(nm) if t and t:IsA("Tool") then local h=awHum() if h then local ok=pcall(function() h:EquipTool(t) end) if ok then return true end end end end end
        if bag  then for _,nm in ipairs(nameList) do local t=bag:FindFirstChild(nm)  if t and t:IsA("Tool") then local h=awHum() if h then local ok=pcall(function() h:EquipTool(t) end) if ok then return true end end end end end
        return false
    end

    -- эвристика: есть ли «топорная» преграда по лучу
    local function isAxeBreakable(model)
        if not model then return false end
        local tt = model:GetAttribute("ToolType") or model:GetAttribute("WeakTo") or model:GetAttribute("Tool")
        if typeof(tt)=="string" and tt:lower():find("axe") then return true end
        local n = model.Name:lower()
        return n:find("tree") or n:find("bush") or n:find("log") or n:find("leaves") or n:find("stump") or false
    end
    local rcBlock = RaycastParams.new(); rcBlock.FilterType=Enum.RaycastFilterType.Blacklist
    local function chooseToolListForPath(model, goldPos)
        local hrp=awRoot() if not hrp then return PICK_CANDIDATES end
        rcBlock.FilterDescendantsInstances = { plr.Character, model }
        local origin = hrp.Position + Vector3.new(0,2,0)
        local dir    = (goldPos - origin)
        if dir.Magnitude <= 2 then return PICK_CANDIDATES end
        local hit = Workspace:Raycast(origin, dir, rcBlock)
        if hit then
            local mdl = hit.Instance and hit.Instance:FindFirstAncestorOfClass("Model")
            if mdl and isAxeBreakable(mdl) then return AXE_CANDIDATES end
        end
        return PICK_CANDIDATES
    end

    -- Raycast for ground hover
    local rcGround = RaycastParams.new()
    rcGround.FilterType = Enum.RaycastFilterType.Blacklist

    -- BV (hover-ground + smooth) --------------------------------
    local function ensureBV(hrp)
        local bv=hrp:FindFirstChild("_AW_BV"); if not bv then bv=Instance.new("BodyVelocity"); bv.Name="_AW_BV"; bv.Parent=hrp end
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        return bv
    end
    local function killBV(hrp) local b=hrp and hrp:FindFirstChild("_AW_BV"); if b then b:Destroy() end end

    local function moveToBV(hrp, goalPos, speed, tol, token)
        local bv = ensureBV(hrp)
        local start   = time()
        local lastPos = hrp.Position
        local stuckT  = time()
        local maxStuck = 3.2

        while hrp.Parent and token.alive do
            local cur  = hrp.Position
            local diff = goalPos - cur

            -- target Y = ground + hover
            rcGround.FilterDescendantsInstances = { plr.Character }
            local desiredY = cur.Y
            do
                local origin = cur + Vector3.new(0, 6, 0)
                local hit = Workspace:Raycast(origin, Vector3.new(0, -40, 0), rcGround)
                if hit then
                    desiredY = hit.Position.Y + (Options.aw_hover and Options.aw_hover.Value or 2.6)
                end
            end

            local needY = (not Options.aw_keepY.Value) or (math.abs(cur.Y - desiredY) >= 0.35)
            local target = needY and Vector3.new(goalPos.X, desiredY, goalPos.Z)
                                   or Vector3.new(goalPos.X, cur.Y,    goalPos.Z)

            local v3   = target - cur
            local dist = v3.Magnitude
            if dist <= tol then
                bv.Velocity = Vector3.new()
                return true
            end

            -- smooth approach & velocity lerp (less micro steps)
            local flat = Vector3.new(v3.X, needY and v3.Y or 0, v3.Z)
            local slow = math.clamp(dist / 8, 0.35, 1.0)
            local want = flat.Unit * (speed * slow)

            bv.MaxForce = needY and Vector3.new(1e9, 1e9, 1e9) or Vector3.new(1e9, 0, 1e9)
            bv.Velocity = bv.Velocity:Lerp(want, 0.25)

            -- gentle anti-stuck
            if Options.aw_antistuck.Value then
                if (cur - lastPos).Magnitude > 0.15 then
                    lastPos = cur; stuckT = time()
                elseif time() - stuckT > maxStuck then
                    bv.Velocity = want * 0.5 + Vector3.new(math.random(-2,2), 0, math.random(-2,2))
                    task.wait(0.12)
                    stuckT = time()
                end
            end

            if time() - start > 35 then
                bv.Velocity = Vector3.new()
                return false
            end

            RS.Heartbeat:Wait()
        end

        if bv then bv.Velocity = Vector3.new() end
        return false
    end

    -- followPath (no direct retarget + skip retarget near target + early break)
    local function followPathBV(hrp, plan, speed, token, hitDist)
        hitDist = hitDist or Options.aw_hit.Value
        local tol=1.6  -- чуть расслабленный допуск
        local lastCheck=time()
        drawGPS(plan.pts)

        local function targetPos()
            local m=plan.target and plan.target.model
            if not m then return plan.pts[#plan.pts] end
            local pp=m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart")
            return (pp and pp.Position) or plan.pts[#plan.pts]
        end

        for i=2,#plan.pts do
            if not token.alive then return "stop" end
            local tp=targetPos()

            -- уже рядом — сразу ломаем
            if (hrp.Position - tp).Magnitude <= hitDist then clearGPS(); return "break_now" end

            -- ретаргет не считаем вплотную к цели
            if (hrp.Position - tp).Magnitude > (hitDist + 4) then
                if Options.aw_retarget.Value and (time()-lastCheck)>=Options.aw_ret_int.Value then
                    lastCheck=time()
                    local here=hrp.Position
                    local newPlan=bestPlan(here, Options.aw_rng.Value, plan.target and plan.target.model)
                    if newPlan and (not newPlan.direct) and plan.J then
                        local pctBetter=(plan.J - newPlan.J)
                        local absBetter=(plan.L or 0)-(newPlan.L or newPlan.J)
                        if pctBetter>=plan.J*(Options.aw_ret_pct.Value/100) or absBetter>=Options.aw_ret_abs.Value then
                            token.retargetPlan=newPlan; clearGPS(); return "retarget"
                        end
                    end
                end
            end

            if not moveToBV(hrp, plan.pts[i], speed, tol, token) then
                if not token.alive then return "stop" end
                local _,wps=buildPath(hrp.Position, plan.pts[#plan.pts])
                local newPts=(wps and #wps>=2) and wpsToPoints(wps) or {hrp.Position, plan.pts[#plan.pts]}
                drawGPS(newPts); plan.pts=newPts; i=1
            end
        end
        clearGPS(); return "ok"
    end

    -- ломание — мгновенный первый удар, префетч в фоне
    local function breakGold(model, token)
        if not model or not model.Parent then return nil end
        local hrp = awRoot(); if not hrp then return nil end

        local cd = Options.aw_cd.Value
        local start = time()
        local limit = 60
        local lastSwing = -1e9
        local lastPos
        local nextPlan = nil
        local hitRadius = math.max(4, Options.aw_hit.Value - 0.5)
        local firstHitDone = false

        while token.alive and model and model.Parent and (time() - start < limit) do
            local eid = model:GetAttribute("EntityID")
            local pp  = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
            if not eid or not pp then break end
            lastPos = pp.Position

            -- дожаться до реальной дистанции и не ждать
            local dist = (hrp.Position - pp.Position).Magnitude
            if dist > hitRadius then
                moveToBV(hrp, pp.Position, Options.aw_spd.Value, hitRadius, token)
                if not token.alive then break end
            end

            -- авто-экип не блокирует свинг
            local ice = iceNear(pp.Position, 9)
            local wanted = (ice and PICK_CANDIDATES) or chooseToolListForPath(model, pp.Position)
            if Options.aw_autoeq.Value then task.spawn(function() ensureAnyTool(wanted) end) end

            -- мгновенный swing
            if time() - lastSwing >= cd then
                swing(ice and {ice, eid} or {eid})
                lastSwing = time()

                -- префетч асинхронно после первого удара
                if not firstHitDone then
                    firstHitDone = true
                    if Options.aw_prefetch.Value then
                        task.spawn(function()
                            local here = hrpPos() or pp.Position
                            nextPlan = bestPlan(here, Options.aw_rng.Value, model)
                        end)
                    end
                end
            end

            RS.Heartbeat:Wait()
        end

        if Options.aw_timer.Value and lastPos and not (model and model.Parent) then
            addTimer(lastPos)
        end
        return nextPlan
    end

    -- main
    local running=false
    local job={alive=false}
    local function stopAll() job.alive=false; killBV(awRoot()); clearGPS() end

    task.spawn(function()
        while true do
            if Options.aw_on.Value then
                if not running then running=true; job={alive=true}; if Options.aw_prescan.Value and not prescanned then fullScan() end end
                local hrp=awRoot()
                if hrp and awAlive() and job.alive then
                    local plan=bestPlan(hrp.Position, Options.aw_rng.Value)
                    if plan then
                        local status=followPathBV(hrp, plan, Options.aw_spd.Value, job, Options.aw_hit.Value)
                        if status=="retarget" and job.retargetPlan then
                            followPathBV(hrp, job.retargetPlan, Options.aw_spd.Value, job, Options.aw_hit.Value)
                        elseif status=="break_now" or status=="ok" then
                            local model=plan.target and plan.target.model
                            if model then
                                local nextPlan=breakGold(model, job)
                                if job.alive and nextPlan then
                                    followPathBV(awRoot(), nextPlan, Options.aw_spd.Value, job, Options.aw_hit.Value)
                                end
                            end
                        end
                        if job.alive then task.wait(0.1) end
                    else
                        task.wait(0.4)
                    end
                else
                    task.wait(0.2)
                end
            else
                if running then running=false; stopAll() end
                task.wait(0.1)
            end
            RS.Heartbeat:Wait()
        end
    end)

    plr.CharacterAdded:Connect(function() stopAll() end)
    Players.PlayerRemoving:Connect(function(p) if p==plr then stopAll() end end)
end






orbitrangeslider:OnChanged(function(value) range = value end)
orbitradiusslider:OnChanged(function(value) orbitradius = value end)
orbitspeedslider:OnChanged(function(value) orbitspeed = value end)
itemheightslider:OnChanged(function(value) itemheight = value end)

runs.RenderStepped:Connect(function()
    if not orbiton then return end
    local time = tick() * orbitspeed
    for item, bp in pairs(attacheditems) do
        if item then
            local angle = itemangles[item] + time
            bp.Position = root.Position + Vector3.new(math.cos(angle) * orbitradius, itemheight, math.sin(angle) * orbitradius)
        end
    end
end)

task.spawn(function()
    while true do
        if orbiton then
            local children, index = itemsfolder:GetChildren(), 0
            local anglestep = (math.pi * 2) / math.max(#children, 1)

            for _, item in pairs(children) do
                local primary = item:IsA("BasePart") and item or item:IsA("Model") and item.PrimaryPart
                if primary and (primary.Position - root.Position).Magnitude <= range then
                    if not attacheditems[primary] then
                        local bp = Instance.new("BodyPosition")
                        bp.MaxForce, bp.D, bp.P, bp.Parent = Vector3.new(math.huge, math.huge, math.huge), 1500, 25000, primary
                        attacheditems[primary], itemangles[primary], lastpositions[primary] = bp, index * anglestep, primary.Position
                        index += 1
                    end
                end
            end
        end
        task.wait()
    end
end)

SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes{}
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
Library:Notify{
    Title = "Herkle Hub",
    Content = "Loaded, Enjoy!",
    Duration = 8
}
SaveManager:LoadAutoloadConfig()
print("Done! Enjoy Herkle Hub!")
