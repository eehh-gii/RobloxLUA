local TweenService = game:GetService("TweenService")

-- GUI container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- TextLabel langsung (tanpa frame)
local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = ScreenGui
TextLabel.AnchorPoint = Vector2.new(0.5, 0) -- posisi tengah atas
TextLabel.Position = UDim2.new(0.5, 0, 0.1, 0)
TextLabel.Size = UDim2.new(0, 250, 0, 50)
TextLabel.BackgroundTransparency = 1 -- full transparan
TextLabel.Text = "🚨 Script not running, Game has been updated!!. 🚨"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextSize = 30
TextLabel.TextTransparency = 1 -- mulai tidak terlihat

-- Tween Info
local fadeTime = 0.5 -- durasi animasi
local stayTime = 2   -- waktu diam di layar

local fadeIn = TweenService:Create(TextLabel, TweenInfo.new(fadeTime), {TextTransparency = 0})
local fadeOut = TweenService:Create(TextLabel, TweenInfo.new(fadeTime), {TextTransparency = 1})

-- Fungsi notifikasi
local function showNotification()
    fadeIn:Play()
    task.wait(fadeTime + stayTime) -- tunggu animasi masuk + tampil
    fadeOut:Play()
    task.wait(fadeTime)
    ScreenGui:Destroy()
end

-- Jalankan notifikasi
showNotification()
