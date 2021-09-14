local RunService: RunService = game:GetService("RunService")
local TimePassed: number = 0
local NextYield = nil

RunService.Heartbeat:Connect(function(deltaTime: number)
	TimePassed += deltaTime

	local currentYield = NextYield
	while currentYield ~= nil do
		local spent: number = TimePassed - currentYield[1]

		local _next = currentYield[4]

		if spent >= currentYield[2] then
			local _prev = currentYield[5]

			if _next ~= nil then
				_next[5] = _prev
			end

			if _prev ~= nil then
				_prev[4] = _next
			else -- Current yield is the head (NextYield)
				NextYield = _next
			end

			task.defer(
				currentYield[3],
				spent
			)
		end

		currentYield = _next
	end
end)

return function(n: number?): number
	n = typeof(n) == 'number' and n or 0

	do
		local yield = {
			TimePassed,
			n,
			coroutine.running(),
			NextYield, -- _next
			nil, -- _prev
		}

		if NextYield ~= nil then
			NextYield[5] = yield
		end

		NextYield = yield
	end

	return coroutine.yield()
end
