local RunService = game:GetService("RunService")
local TimePassed = 0
local NextYield = nil

local c_running = coroutine.running
local c_yield = coroutine.yield
local t_defer = task.defer

RunService.Stepped:Connect(function(_, deltaTime)
	TimePassed += deltaTime

	local currentYield = NextYield
	while currentYield ~= nil do
		local spent = TimePassed - currentYield[1]

		local _next = currentYield[4]
		local _prev = currentYield[5]

		if spent >= currentYield[2] then
			if _next ~= nil then
				_next[5] = _prev
			end

			if _prev ~= nil then
				_prev[4] = _next
				
			else -- Current yield is the head (NextYield)
				NextYield = _next
			end

			t_defer(
				currentYield[3],
				spent
			)
		end

		currentYield = _next
	end
end)

return function(n)
	n = typeof(n) == 'number' and n or 0

	do
		local yield = {
			TimePassed,
			n,
			c_running(),
			NextYield, -- _next
			nil, -- _prev
		}

		if NextYield ~= nil then
			NextYield[5] = yield
		end

		NextYield = yield
	end

	return c_yield()
end
