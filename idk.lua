-- Script Dual Flintlock - Fast Attack (Cất và Lấy lại Súng)
local player = game.Players.LocalPlayer
local gun1 = nil
local gun2 = nil
local isAttacking = false  -- Trạng thái tấn công
local backpack = player.Backpack  -- Địa chỉ balo

-- Tìm kiếm hai khẩu súng Flintlock trong nhân vật
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

-- Hàm để bắt đầu tấn công nhanh
function startAttacking()
    isAttacking = true
    while isAttacking do
        if gun1.Parent == player.Character and gun2.Parent == player.Character then
            -- Cất súng vào balo và lấy lại liên tục
            gun1.Parent = backpack  -- Cất súng 1 vào balo
            wait(0.05)  -- Thời gian ngắn giữa các lần cất lấy
            gun1.Parent = player.Character  -- Lấy súng 1 ra
            gun2.Parent = backpack  -- Cất súng 2 vào balo
            wait(0.05)  -- Thời gian ngắn giữa các lần cất lấy
            gun2.Parent = player.Character  -- Lấy súng 2 ra

            -- Kích hoạt bắn súng
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
end

-- Bắt sự kiện để bắt đầu hoặc dừng tấn công
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.T then  -- Nhấn phím T để bắt đầu/tắt tấn công
        if isAttacking then
            stopAttacking()  -- Dừng tấn công
        else
            startAttacking()  -- Bắt đầu tấn công
        end
    end
end)
