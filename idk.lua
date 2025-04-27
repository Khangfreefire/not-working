-- Fast Attack Dual Flintlock Script for Blox Fruits
local player = game.Players.LocalPlayer
local gun1 = nil  -- Dual Flintlock Gun 1
local gun2 = nil  -- Dual Flintlock Gun 2

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
    print("Không tìm thấy cả hai khẩu Flintlock trong nhân vật!")
    return
end

-- Hàm Fast Attack Dual Flintlock: Bắn liên tục với cả hai súng
function fastAttack()
    while true do
        if gun1 and gun1.Parent == player.Character and gun2 and gun2.Parent == player.Character then
            -- Bắn cả hai khẩu súng cùng một lúc
            gun1:Activate()  -- Giả lập hành động bắn cho súng 1
            gun2:Activate()  -- Giả lập hành động bắn cho súng 2
            wait(0.05)  -- Thời gian chờ rất ngắn giữa mỗi lần bắn (có thể điều chỉnh)
        end
    end
end

-- Bắt đầu tấn công
fastAttack()