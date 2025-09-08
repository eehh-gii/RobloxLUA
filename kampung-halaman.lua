--// Services
local HttpService = game:GetService("HttpService")

--// Loader UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 200)
Frame.Position = UDim2.new(0.35, 0, 0.35, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local keyInput = Instance.new("TextBox", Frame)
keyInput.PlaceholderText = "Enter Key..."
keyInput.Size = UDim2.new(0.9, 0, 0, 35)
keyInput.Position = UDim2.new(0.05, 0, 0.3, 0)
keyInput.Text = ""
keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local getBtn = Instance.new("TextButton", Frame)
getBtn.Text = "Get Key"
getBtn.Size = UDim2.new(0.43, 0, 0, 35)
getBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
getBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local checkBtn = Instance.new("TextButton", Frame)
checkBtn.Text = "Check Key"
checkBtn.Size = UDim2.new(0.43, 0, 0, 35)
checkBtn.Position = UDim2.new(0.52, 0, 0.55, 0)
checkBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local statusLbl = Instance.new("TextLabel", Frame)
statusLbl.Size = UDim2.new(1, 0, 0, 25)
statusLbl.Position = UDim2.new(0, 0, 0.85, 0)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = "Menunggu input..."
statusLbl.TextColor3 = Color3.fromRGB(255, 255, 255)

--// Tombol Get Key (Copy Link)
getBtn.MouseButton1Click:Connect(function()
    local link = "https://workink.net/23OL/zdbx28e2" -- ganti dengan link Work.ink kamu
    if setclipboard then
        setclipboard(link)
        statusLbl.Text = "Link GetKey Copied!"
    else
        statusLbl.Text = "Paste link in browser:\n" .. link
    end
end)

--// Tombol Check Key
checkBtn.MouseButton1Click:Connect(function()
    local token = keyInput.Text
    if token == "" then
        statusLbl.Text = "Input your key!"
        return
    end

    local url = "https://work.ink/_api/v2/token/isValid/" .. token

    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        statusLbl.Text = "Tidak bisa connect API!"
        return
    end

    local data
    local ok = pcall(function()
        data = HttpService:JSONDecode(response)
    end)

    if not ok or not data then
        statusLbl.Text = "Response API salah!"
        return
    end

    if data.valid then
        statusLbl.Text = "Key valid! Open script..."
        wait(1)
        ScreenGui:Destroy()

-- ================================================================================================================================

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterPack = game:GetService("StarterPack")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local backpack = plr:WaitForChild("Backpack")
local hrp = char:WaitForChild("HumanoidRootPart")

-- // GUI Buatan
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = plr:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 20, 0, 200)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Parent = ScreenGui

local AutoMineBtn = Instance.new("TextButton")
AutoMineBtn.Size = UDim2.new(1, -10, 0, 40)
AutoMineBtn.Position = UDim2.new(0, 5, 0, 5)
AutoMineBtn.Text = "Auto Mine: OFF"
AutoMineBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
AutoMineBtn.Parent = Frame

local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Size = UDim2.new(1, -10, 0, 40)
AutoCollectBtn.Position = UDim2.new(0, 5, 0, 50)
AutoCollectBtn.Text = "Auto Collect: OFF"
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
AutoCollectBtn.Parent = Frame

-- // State
local autoMine = false
local autoCollect = false

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
            for _, ore in ipairs(Workspace.Ores:GetChildren()) do
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
    while true do
        if autoCollect then
            for _, shard in ipairs(Workspace:GetChildren()) do
                if shard:IsA("Tool") and shard:FindFirstChild("Handle") then
                    local handle = shard.Handle
                    if (handle.Position - hrp.Position).Magnitude < 15 then -- kalau dekat
                        triggerPrompt(handle)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- // Button Toggle
AutoMineBtn.MouseButton1Click:Connect(function()
    autoMine = not autoMine
    AutoMineBtn.Text = "Auto Mine: " .. (autoMine and "ON" or "OFF")
end)

AutoCollectBtn.MouseButton1Click:Connect(function()
    autoCollect = not autoCollect
    AutoCollectBtn.Text = "Auto Collect: " .. (autoCollect and "ON" or "OFF")
end)

-- ================================================================================================================================

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)


    else
        statusLbl.Text = "Key Invalid / expired"
    end
end)
