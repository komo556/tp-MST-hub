local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--=====================================================
-- GUI
--=====================================================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

--=====================================================
-- CLOSE
--=====================================================
local close = Instance.new("TextButton", gui)
close.Size = UDim2.new(0,28,0,28)
close.Position = UDim2.new(0,5,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,60,60)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--=====================================================
-- MAIN FRAME
--=====================================================
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,200,0,280)
frame.Position = UDim2.new(0,40,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
Instance.new("UICorner", frame)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2

task.spawn(function()
	local h = 0
	while frame.Parent do
		h += 0.01
		if h > 1 then h = 0 end
		stroke.Color = Color3.fromHSV(h,1,1)
		task.wait(0.02)
	end
end)

--=====================================================
-- MENU BUTTON
--=====================================================
local menuBtn = Instance.new("TextButton", gui)
menuBtn.Size = UDim2.new(0,30,0,30)
menuBtn.Position = UDim2.new(0,40,0,5)
menuBtn.Text = "←"
menuBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
menuBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", menuBtn)

--=====================================================
-- MENU
--=====================================================
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,140,0,180)
menu.Position = UDim2.new(0,-160,0,40)
menu.BackgroundColor3 = Color3.fromRGB(20,20,20)
menu.Visible = false
Instance.new("UICorner", menu)

local open = false

menuBtn.MouseButton1Click:Connect(function()
	open = not open
	menu.Visible = true

	menu:TweenPosition(
		open and UDim2.new(0,10,0,40) or UDim2.new(0,-160,0,40),
		"Out","Quad",0.25,true
	)

	if not open then
		task.wait(0.25)
		menu.Visible = false
	end
end)

--=====================================================
-- MENU BUTTONS
--=====================================================
local camBtn = Instance.new("TextButton", menu)
camBtn.Size = UDim2.new(1,0,0,35)
camBtn.Text = "カメラ固定 OFF"
camBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
camBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", camBtn)

local resetBtn = Instance.new("TextButton", menu)
resetBtn.Size = UDim2.new(1,0,0,35)
resetBtn.Position = UDim2.new(0,0,0,40)
resetBtn.Text = "解除"
resetBtn.BackgroundColor3 = Color3.fromRGB(80,30,30)
resetBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", resetBtn)

local setBtn = Instance.new("TextButton", menu)
