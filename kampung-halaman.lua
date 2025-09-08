-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPack = game:GetService("StarterPack")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local backpack = plr:WaitForChild("Backpack")
local hrp = char:WaitForChild("HumanoidRootPart")

-- // Remote
local SellEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SellEvent")

-- // GUI Buatan
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = plr:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 160)
Frame.Position = UDim2.new(0, 20, 0, 200)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true -- << bisa digeser

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.Parent = Frame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 5, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "⛏️ Auto Mine GUI"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Minimize Btn
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 1, 0)
MinBtn.Position = UDim2.new(1, -50, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Parent = TitleBar

-- Exit Btn
local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0, 25, 1, 0)
ExitBtn.Position = UDim2.new(1, -25, 0, 0)
ExitBtn.Text = "X"
ExitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.Parent = TitleBar

-- Buttons
local AutoMineBtn = Instance.new("TextButton")
AutoMineBtn.Size = UDim2.new(1, -20, 0, 30)
AutoMineBtn.Position = UDim2.new(0, 10, 0, 35)
AutoMineBtn.Text = "Auto Mine: OFF"
AutoMineBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
AutoMineBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoMineBtn.Parent = Frame

local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Size = UDim2.new(1, -20, 0, 30)
AutoCollectBtn.Position = UDim2.new(0, 10, 0, 70)
AutoCollectBtn.Text = "Auto Collect: OFF"
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
AutoCollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoCollectBtn.Parent = Frame

local SellBtn = Instance.new("TextButton")
SellBtn.Size = UDim2.new(1, -20, 0, 30)
SellBtn.Position = UDim2.new(0, 10, 0, 105)
SellBtn.Text = "Sell Crystal"
SellBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
SellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SellBtn.Parent = Frame

-- // State
local autoMine = false
local autoCollect = false
local guiVisible = true

-- // Functions
local function equipPickaxe()
    local pickaxe = backpack:FindFirstChild("Pickaxe") or StarterPack:FindFirstChild("Pickaxe")
    if pickaxe then
        pickaxe.Parent = char
    end
end

local function triggerPrompt(obj)
    local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
    if prompt then
        fireproximityprompt(prompt)
    end
end

-- Auto Mine loop
task.spawn(function()
    while true do
        if autoMine then
            for , ore in ipairs(Workspace.Ores:GetChildren()) do
                if (ore.Position - hrp.Position).Magnitude < 15 then -- kalau dekat
                    equipPickaxe()
                    triggerPrompt(ore)
                end
            end
        end
        task.wait(0.5)
    end
end)


-- Auto Collect loop
task.spawn(function()
    while running do
        if autoCollect then
            for _, shard in ipairs(Workspace:GetChildren()) do
                if shard:IsA("Tool") and shard:FindFirstChild("Handle") then
                    local handle = shard.Handle
                    if (handle.Position - hrp.Position).Magnitude < 15 then
                        triggerPrompt(handle)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- // Button Toggles
AutoMineBtn.MouseButton1Click:Connect(function()
    autoMine = not autoMine
    AutoMineBtn.Text = "Auto Mine: " .. (autoMine and "ON" or "OFF")
end)

AutoCollectBtn.MouseButton1Click:Connect(function()
    autoCollect = not autoCollect
    AutoCollectBtn.Text = "Auto Collect: " .. (autoCollect and "ON" or "OFF")
end)

SellBtn.MouseButton1Click:Connect(function()
    SellEvent:FireServer()
end)

-- Minimize
MinBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    for _, v in ipairs(Frame:GetChildren()) do
        if v ~= TitleBar then
            v.Visible = guiVisible
        end
    end
    Frame.Size = guiVisible and UDim2.new(0, 220, 0, 160) or UDim2.new(0, 220, 0, 25)
end)

-- Exit
ExitBtn.MouseButton1Click:Connect(function()
    running = false
    ScreenGui:Destroy()
end)
