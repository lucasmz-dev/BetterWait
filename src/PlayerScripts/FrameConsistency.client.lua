local RunService = game:GetService("RunService")
local Stepped = RunService.Stepped
local frameCount = 0

local function StandardWait(n)
	n = typeof(n) == 'number' and n or 0

	local spent = 0
	repeat
		local _, deltaTime = Stepped:Wait()
		spent += deltaTime
	until spent >= n
	return spent
end

local BetterWait = require(game.ReplicatedStorage.BetterWait)

StandardWait(1)

Stepped:Connect(function()
	frameCount += 1

	--\\ Remember? Connections are fired from last to first,
	-- So we need this to update before anything else!
end)


coroutine.wrap(function()
	local timeTook = os.clock()
	print(StandardWait(5))
	print("StandardWait at frame ", frameCount)
	print("StandardWait actually took ", os.clock() - timeTook)
end)()

local timeTook = os.clock()
print(BetterWait(5))
print("BetterWait at frame ", frameCount)
print("BetterWait actually took ", os.clock() - timeTook)
