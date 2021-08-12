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
		local spent = TimePassed - currentYield[3]

		local _next = currentYield[1]

		if spent >= currentYield[4] then
			local _prev = currentYield[2]

			if _next ~= nil then
				_next[2] = _prev
			end

			if _prev ~= nil then
				_prev[1] = _next
				
			else -- Current yield is the head (NextYield)
				NextYield = _next
			end

			t_defer(
				currentYield[5],
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
			NextYield, -- _next
			nil, -- _prev
			TimePassed,
			n,
			c_running()
		}

		if NextYield ~= nil then
			NextYield[2] = yield
		end

		NextYield = yield
	end

	return c_yield()
end
