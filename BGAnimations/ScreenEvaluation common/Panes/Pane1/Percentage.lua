local player, controller = unpack(...)

local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
-- local PercentDP = stats:GetPercentDancePoints()
-- local percent = pss:GetHighScore():GetWifeScore()
-- Format the Percentage string, removing the % symbol
-- percent = percent:gsub("%%", "")

return Def.ActorFrame{
	Name="PercentageContainer"..ToEnumShortString(player),
	OnCommand=function(self)
		self:y( _screen.cy-26 )
	end,

	-- dark background quad behind player percent score
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(color("#101519")):zoomto(158.5, 88)
			self:horizalign(controller==PLAYER_1 and left or right)
			self:x(150 * (controller == PLAYER_1 and -1 or 1))
			self:y(14)

			if ThemePrefs.Get("VisualStyle") == "Technique" then
				self:diffusealpha(0.5)
			end
		end
	},

	LoadFont("Wendy/_wendy white")..{
		Name="Percent",
		Text="0.00",
		InitCommand=function(self)
			self:horizalign(right):zoom(0.585)
			self:x( (controller == PLAYER_1 and 1.5 or 141))
			self:playcommand("Set")
		end,
		SetCommand = function(self, params)
			local score = stats:GetWifeScore()*100
			if score >= 99.0 then
				self:horizalign(right):zoom(0.4)
				self:settext(string.format("%05.5f",score))
			else
				self:settext(string.format("%05.2f",score))
			end
		end,
	}
}
