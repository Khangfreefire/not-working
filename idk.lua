-- Fast Attack Dual Flintlock with Toggle GUI Script for Blox Fruits

local player = game.Players.LocalPlayer
local gun1 = nil  -- Flintlock Gun 1
local gun2 = nil  -- Flintlock Gun 2
local isAttacking = false  -- Biến để kiểm tra trạng thái bắn
local attackConnection = nil  -- Kết nối tấn công

-- Tạo GUI để bật/tắt tính năng
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Text = "Toggle Attack"
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0, 50, 0, 50)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Màu đỏ khi tắt

-- Tìm kiếm hai khẩu Flintlock trong nhân vật
for _, v in pairs(player.Character:GetChildren()) do
    if v:IsA("Tool") then
        if v.Name == "Flintlock" and not gun1 then
            gun1 = v
        elseif v.Name == "Flintlock" and not gun2 then
            gun2 = v
        end
    end
end

if not gun1 or not gun2 then
    print("Không tìm thấy hai khẩu Flintlock trong nhân vật!")
    return
end

-- Hàm để bắt đầu tấn công
function startAttacking()
    isAttacking = true
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Đổi màu nút thành xanh khi bật tấn công
    while isAttacking do
        if gun1.Parent == player.Character and gun2.Parent == player.Character then
            gun1:Activate()  -- Bắn súng 1
            gun2:Activate()  -- Bắn súng 2
            wait(0.1)  -- Thời gian giữa các lần bắn (có thể điều chỉnh)
        end
        wait(0.05)  -- Chờ giữa các lần lặp
    end
end

-- Hàm để dừng tấn công
function stopAttacking()
    isAttacking = false
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Đổi màu nút thành đỏ khi tắt tấn công
end

-- Bắt sự kiện khi người chơi nhấn nút Toggle Attack
toggleButton.MouseButton1Click:Connect(function()
    if isAttacking then
        stopAttacking()  -- Nếu đang tấn công, thì dừng
    else
        startAttacking()  -- Nếu không đang tấn công, thì bắt đầu
    end
end)
