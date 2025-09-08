local TweenService = game:GetService("TweenService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")


local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = ScreenGui
TextLabel.AnchorPoint = Vector2.new(0.5, 0)
TextLabel.Position = UDim2.new(0.5, 0, 0.1, 0)
TextLabel.Size = UDim2.new(0, 250, 0, 50)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "🚨 Script not running, Game has been updated!!. 🚨"
TextLabel.TextColor3 = Color3.fromRGB(0, 250, 0)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextSize = 30
TextLabel.TextTransparency = 1

local fadeTime = 0.5
local stayTime = 2

local fadeIn = TweenService:Create(TextLabel, TweenInfo.new(fadeTime), {TextTransparency = 0})
local fadeOut = TweenService:Create(TextLabel, TweenInfo.new(fadeTime), {TextTransparency = 1})


local function showNotification()
    fadeIn:Play()
    task.wait(fadeTime + stayTime)
    fadeOut:Play()
    task.wait(fadeTime)
    ScreenGui:Destroy()
end

showNotification()
