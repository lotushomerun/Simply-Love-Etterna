local player = ...
local pn = ToEnumShortString(player)

local _x = _screen.cx + (player==PLAYER_1 and -1 or 1) * SL_WideScale(292.5, 328.5)

return Def.ActorFrame{
	InitCommand=function(self)
		local adjusted_offset_x = SL[pn].ActiveModifiers.NoteFieldOffsetX * (player == PLAYER_1 and -1 or 1)
		self:xy(_x + adjusted_offset_x, 56)
	end,


	-- colored background for player's chart's difficulty meter
	Def.Quad{
		InitCommand=function(self)
			self:zoomto(60, 30)
		end,
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Begin") end,
		BeginCommand=function(self)
			local currentSteps = GAMESTATE:GetCurrentSteps(player)
			if currentSteps then
				local currentDifficulty = currentSteps:GetDifficulty()
				self:diffuse(DifficultyColor(currentDifficulty))
			end
		end
	},

	-- player's chart's difficulty meter
	LoadFont("Common Bold")..{
		InitCommand=function(self)
			self:diffuse( Color.Black )
			self:zoom( 0.4 )
		end,
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Begin") end,
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(player)
			local meter = steps:GetMSD(getCurRateValue(),1)

			if meter then
				self:settext(string.format("%05.2f",meter))
			end
		end
	}
}