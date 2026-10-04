local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Gui = Instance.new("ScreenGui")
Gui.Name = "ArexansMini"
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(300, 230)
Main.Position = UDim2.new(0.5, -150, 0.5, -115)
Main.BackgroundColor3 = Color3.fromRGB(5, 15, 40)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 9)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 140, 255)
Stroke.Thickness = 1.2

local Gradient = Instance.new("UIGradient", Main)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(3, 12, 35)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 65, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(3, 12, 35))
})

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 34)
Header.BackgroundColor3 = Color3.fromRGB(0, 60, 150)
Header.BorderSizePixel = 0

local HG = Instance.new("UIGradient", Header)
HG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 55, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 175, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 45, 130))
})

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -85, 1, 0)
Title.Position = UDim2.fromOffset(10, 0)
Title.BackgroundTransparency = 1
Title.Text = "AREXANS HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local function Button(parent, text, size, pos)
    local b = Instance.new("TextButton", parent)
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(8, 40, 90)
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.fromRGB(220, 240, 255)
    b.TextSize = 10
    b.Font = Enum.Font.GothamMedium
    b.AutoButtonColor = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    return b
end

local Min = Button(Header, "—", UDim2.fromOffset(25, 24), UDim2.new(1, -57, 0, 5))
local Close = Button(Header, "×", UDim2.fromOffset(25, 24), UDim2.new(1, -28, 0, 5))

local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.fromOffset(5, 40)
Sidebar.Size = UDim2.new(0, 82, 1, -45)
Sidebar.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout", Sidebar)
TabLayout.Padding = UDim.new(0, 4)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.fromOffset(93, 40)
Content.Size = UDim2.new(1, -98, 1, -45)
Content.BackgroundTransparency = 1
Content.ClipsDescendants = true

local Pages = {}
local Tabs = {}

local function CreateTab(name)
    local tab = Button(Sidebar, name, UDim2.new(1, 0, 0, 23), UDim2.new())
    tab.TextXAlignment = Enum.TextXAlignment.Left

    local page = Instance.new("ScrollingFrame", Content)
    page.Name = name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new()
    page.Visible = false

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 5)

    local padding = Instance.new("UIPadding", page)
    padding.PaddingRight = UDim.new(0, 4)
    padding.PaddingTop = UDim.new(0, 2)

    Pages[name] = page
    Tabs[name] = tab

    tab.MouseButton1Click:Connect(function()
        for n, p in pairs(Pages) do
            p.Visible = n == name
            Tabs[n].BackgroundColor3 = n == name
                and Color3.fromRGB(0, 110, 230)
                or Color3.fromRGB(8, 40, 90)
        end
    end)

    return page
end

local function AddButton(page, text, callback)
    local b = Button(page, text, UDim2.new(1, -4, 0, 26), UDim2.new())
    b.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return b
end

local function AddLabel(page, text)
    local label = Instance.new("TextLabel", page)
    label.Size = UDim2.new(1, -4, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(180, 220, 255)
    label.TextSize = 10
    label.Font = Enum.Font.Gotham
    label.TextWrapped = true
    return label
end

local function AddToggle(page, text, callback)
    local enabled = false
    local b = AddButton(page, text .. " : OFF", function()
        enabled = not enabled
        b.Text = text .. (enabled and " : ON" or " : OFF")
        b.BackgroundColor3 = enabled
            and Color3.fromRGB(0, 100, 210)
            or Color3.fromRGB(8, 40, 90)
        if callback then callback(enabled) end
    end)
end

local Home = CreateTab("Home")
local PlayerTab = CreateTab("Player")
local Visuals = CreateTab("Visuals")
local Combat = CreateTab("Combat")
local Teleports = CreateTab("Teleports")
local Misc = CreateTab("Misc")
local Settings = CreateTab("Settings")
local Credits = CreateTab("Credits")

AddLabel(Home, "Welcome, " .. Player.Name)
AddLabel(Home, "AREXANS HUB MINI")
AddButton(Home, "Refresh", function()
    print("Arexans Hub refreshed")
end)

AddToggle(PlayerTab, "WalkSpeed", function(v)
    local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = v and 32 or 16 end
end)

AddToggle(PlayerTab, "JumpPower", function(v)
    local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if h then
        h.UseJumpPower = true
        h.JumpPower = v and 80 or 50
    end
end)

AddButton(PlayerTab, "Reset Character", function()
    local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Health = 0 end
end)

AddToggle(Visuals, "Glow Effect")
AddToggle(Visuals, "Visual Mode")
AddToggle(Combat, "Training Mode")
AddToggle(Combat, "Combat Interface")

AddButton(Teleports, "Teleport to Spawn", function()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    local spawn = workspace:FindFirstChildWhichIsA("SpawnLocation", true)
    if root and spawn then root.CFrame = spawn.CFrame + Vector3.new(0, 3, 0) end
end)

AddToggle(Misc, "Animated Gradient")
AddToggle(Misc, "Extra Effects")

AddButton(Settings, "Reset Position", function()
    Main.Position = UDim2.new(0.5, -150, 0.5, -115)
end)

AddButton(Settings, "Close GUI", function()
    Gui:Destroy()
end)

AddLabel(Credits, "AREXANS HUB MINI")
AddLabel(Credits, "Blue Edition")
AddLabel(Credits, "Designed for Roblox Studio")

Pages.Home.Visible = true
Tabs.Home.BackgroundColor3 = Color3.fromRGB(0, 110, 230)

local minimized = false

Min.MouseButton1Click:Connect(function()
    minimized = not minimized
    Sidebar.Visible = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.fromOffset(300, 34) or UDim2.fromOffset(300, 230)
end)

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

local dragging, dragStart, startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function(dt)
    if not Gui.Parent then return end
    Gradient.Rotation = (Gradient.Rotation + dt * 20) % 360
    HG.Rotation = (HG.Rotation + dt * 35) % 360
end)