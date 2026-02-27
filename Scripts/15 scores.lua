function getBestScore(pn, ignore, rate, percent)
	if not rate then rate = "1.0x" end
	local highest = -math.huge

	local indexScore
	local bestScore

	local hsTable = getScoreTable(pn, rate)
	local steps = GAMESTATE:GetCurrentSteps()
	local temp

	if hsTable ~= nil and #hsTable >= 1 then
		for k,v in ipairs(hsTable) do
			if k ~= ignore then
				indexScore = hsTable[k]
				if indexScore ~= nil then
					temp = getScore(indexScore, steps, percent)
					if temp >= highest then
						highest = temp
						bestScore = indexScore
					end
				end
			end
		end
	end
	return bestScore
end

function getCurRate()
	local mods = GAMESTATE:GetSongOptionsString()
	if string.find(mods,"Haste") ~= nil then
		return 'Haste'
	elseif string.find(mods,"xMusic") == nil then
		return '1.0x'
	else
		return (string.match(mods,"%d+%.%d+xMusic")):sub(1,-6)
	end
end

function getScoreTable(pn, rate, steps)
	if not rate then rate = "1.0x" end
	local rtTable = getRateTable(pn, steps)

	if not rtTable then return nil end
	return rtTable[rate]
end