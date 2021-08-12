local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BetterWait = require(ReplicatedStorage.BetterWait)

--\\ Waits should print from 10 to 1.
-- Skips, wrong order, reverse order, means that
-- the solution isn't consistent.

task.wait(5)

for i = 1, 10 do
	task.spawn(function()
		BetterWait(.5)
		print(i)
	end)
end
--
BetterWait(.25)
for i = 1, 10 do
	task.spawn(function()
		BetterWait(.5)
		print(i)
	end)
end
