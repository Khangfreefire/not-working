-- Script Fruit Rain cho Blox Fruits (Tất cả các loại trái)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local fruitRainEnabled = false  -- Biến kiểm tra trạng thái fruit rain

-- Hàm để tạo ra quả trái ác quỷ rơi từ trên trời xuống
function createFruit()
    -- Lấy tất cả các trái ác quỷ từ ReplicatedStorage
    local fruits = ReplicatedStorage:WaitForChild("Fruits")
    local fruitNames = {}

    -- Lấy tên tất cả các trái ác quỷ
    for _, fruit in pairs(fruits:GetChildren()) do
        if fruit:IsA("Model") then
            table.insert(fruitNames, fruit.Name)
        end
    end

    -- Chọn ngẫu nhiên một trái ác quỷ từ danh sách
    local randomFruitName = fruitNames[math.random(1, #fruitNames)]
    local fruit = fruits:FindFirstChild(randomFruitName):Clone()

    -- Tạo vị trí ngẫu nhiên cho quả trái ác quỷ (rơi từ trên trời xuống)
    local startPos = Vector3.new(math.random(-1000, 1000), 500, math.random(-1000, 1000))
    fruit.Parent = workspace
    fruit:SetPrimaryPartCFrame(CFrame.new(startPos))

    -- Cập nhật vị trí để quả trái ác quỷ rơi xuống
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.new(0, -100, 0)  -- Điều chỉnh tốc độ rơi
    bodyVelocity.Parent = fruit

    -- Phát âm thanh khi trái ác quỷ xuất hiện
    if game:GetService("ReplicatedStorage"):FindFirstChild("Sounds") then
        local fruitSound = game:GetService("ReplicatedStorage").Sounds:FindFirstChild("FruitRainSound")
        if fruitSound then
            fruitSound:Play()
        end
    end
end

-- Hàm để bắt đầu fruit rain
function startFruitRain()
    fruitRainEnabled = true
    while fruitRainEnabled do
        createFruit()
        wait(2)  -- Khoảng thời gian giữa các lần trái ác quỷ rơi xuống (có thể điều chỉnh)
    end
end

-- Hàm để dừng fruit rain
function stopFruitRain()
    fruitRainEnabled = false
end

-- Tạo GUI để bật/tắt fruit rain
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Text = "Toggle Fruit Rain"
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0, 50, 0, 50)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Màu xanh khi bật

-- Bắt sự kiện nhấn nút
toggleButton.MouseButton1Click:Connect(function()
    if fruitRainEnabled then
        stopFruitRain()  -- Dừng fruit rain nếu đang chạy
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Đổi màu nút thành đỏ khi dừng
    else
        startFruitRain()  -- Bắt đầu fruit rain nếu chưa chạy
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Đổi màu nút thành xanh khi bắt đầu
    end
end)
