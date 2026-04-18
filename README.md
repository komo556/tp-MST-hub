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
setBtn.Size = UDim2.new(1,0,0,35)
setBtn.Position = UDim2.new(0,0,0,80)
setBtn.Text = "設定"
setBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
setBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", setBtn)

--=====================================================
-- SETTINGS PANEL
--=====================================================
local settings = Instance.new("Frame", gui)
settings.Size = UDim2.new(0,180,0,140)
settings.Position = UDim2.new(0,220,0,100)
settings.BackgroundColor3 = Color3.fromRGB(20,20,20)
settings.Visible = false
Instance.new("UICorner", settings)

-- TP DISTANCE
local tpDistance = 3
local camOffsetY = 2

local tpLabel = Instance.new("TextLabel", settings)
tpLabel.Size = UDim2.new(1,0,0,30)
tpLabel.Text = "TP距離: 3"
tpLabel.TextColor3 = Color3.new(1,1,1)
tpLabel.BackgroundTransparency = 1

local tpAdd = Instance.new("TextButton", settings)
tpAdd.Size = UDim2.new(0.5,0,0,30)
tpAdd.Position = UDim2.new(0,0,0,30)
tpAdd.Text = "+"

local tpSub = Instance.new("TextButton", settings)
tpSub.Size = UDim2.new(0.5,0,0,30)
tpSub.Position = UDim2.new(0.5,0,0,30)
tpSub.Text = "-"

tpAdd.MouseButton1Click:Connect(function()
	tpDistance += 0.5
	tpLabel.Text = "TP距離: "..tpDistance
end)

tpSub.MouseButton1Click:Connect(function()
	tpDistance -= 0.5
	if tpDistance < 0.5 then tpDistance = 0.5 end
	tpLabel.Text = "TP距離: "..tpDistance
end)

-- CAMERA OFFSET
local camLabel = Instance.new("TextLabel", settings)
camLabel.Size = UDim2.new(1,0,0,30)
camLabel.Position = UDim2.new(0,0,0,70)
camLabel.Text = "カメラ高さ: 2"
camLabel.TextColor3 = Color3.new(1,1,1)
camLabel.BackgroundTransparency = 1

local camUp = Instance.new("TextButton", settings)
camUp.Size = UDim2.new(0.5,0,0,30)
camUp.Position = UDim2.new(0,0,0,100)
camUp.Text = "+"

local camDown = Instance.new("TextButton", settings)
camDown.Size = UDim2.new(0.5,0,0,30)
camDown.Position = UDim2.new(0.5,0,0,100)
camDown.Text = "-"

camUp.MouseButton1Click:Connect(function()
	camOffsetY += 0.5
	camLabel.Text = "カメラ高さ: "..camOffsetY
end)

camDown.MouseButton1Click:Connect(function()
	camOffsetY -= 0.5
	camLabel.Text = "カメラ高さ: "..camOffsetY
end)

--=====================================================
-- LIST
--=====================================================
local list = Instance.new("ScrollingFrame", frame)
list.Size = UDim2.new(1,-10,1,-10)
list.Position = UDim2.new(0,5,0,5)
list.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,5)

--=====================================================
-- DRAG
--=====================================================
local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = frame.Position
	end
end)

frame.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(i)
	if not dragging then return end
	if i.UserInputType ~= Enum.UserInputType.MouseMovement then return end

	local delta = i.Position - dragStart
	frame.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end)

--=====================================================
-- STATE
--=====================================================
local selected = nil
local tpEnabled = false
local camLock = false
local highlight = nil

--=====================================================
-- HIGHLIGHT
--=====================================================
local function setHighlight(char)
	if highlight then highlight:Destroy() end
	if not char then return end

	local h = Instance.new("Highlight")
	h.FillColor = Color3.fromRGB(0,255,0)
	h.OutlineColor = Color3.fromRGB(0,255,0)
	h.Parent = char

	highlight = h
end

--=====================================================
-- LOOP
--=====================================================
RunService.RenderStepped:Connect(function()
	if not tpEnabled or not selected then return end

	local c = LocalPlayer.Character
	local t = selected.Character

	if c and t then
		local my = c:FindFirstChild("HumanoidRootPart")
		local th = t:FindFirstChild("HumanoidRootPart")

		if my and th then
			my.CFrame = th.CFrame * CFrame.new(0,0,tpDistance)

			if camLock then
				workspace.CurrentCamera.CFrame =
					CFrame.new(
						workspace.CurrentCamera.CFrame.Position + Vector3.new(0,camOffsetY,0),
						th.Position
					)
			end
		end
	end
end)

--=====================================================
-- PLAYER LIST
--=====================================================
local function add(p)
	local b = Instance.new("TextButton", list)
	b.Size = UDim2.new(1,0,0,28)
	b.Text = p.DisplayName
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)

	b.MouseButton1Click:Connect(function()

		if selected == p then
			selected = nil
			tpEnabled = false
			setHighlight(nil)
			b.BackgroundColor3 = Color3.fromRGB(40,40,40)
			return
		end

		for _,v in pairs(list:GetChildren()) do
			if v:IsA("TextButton") then
				v.BackgroundColor3 = Color3.fromRGB(40,40,40)
			end
		end

		selected = p
		tpEnabled = true

		b.BackgroundColor3 = Color3.fromRGB(0,255,0)

		if p.Character then
			setHighlight(p.Character)
		end
	end)
end

local function refresh()
	for _,v in pairs(list:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end

	for _,p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			add(p)
		end
	end

	task.wait()
	list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end

Players.PlayerAdded:Connect(refresh)
Players.PlayerRemoving:Connect(refresh)

refresh()

--=====================================================
-- TOGGLES
--=====================================================
camBtn.MouseButton1Click:Connect(function()
	camLock = not camLock
	camBtn.Text = camLock and "カメラ固定 ON" or "カメラ固定 OFF"
end)

resetBtn.MouseButton1Click:Connect(function()
	selected = nil
	tpEnabled = false
	camLock = false
	setHighlight(nil)

	for _,v in pairs(list:GetChildren()) do
		if v:IsA("TextButton") then
			v.BackgroundColor3 = Color3.fromRGB(40,40,40)
		end
	end
end)

setBtn.MouseButton1Click:Connect(function()
	settings.Visible = not settings.Visible
end)
