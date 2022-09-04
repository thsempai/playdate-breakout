import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "ball"
import "game"

local gfx <const> = playdate.graphics
local pd <const> = playdate


local function initialize()

	local ball = Ball(200, 120, 8, { 4, 4 })
	ball:add()
	local game = Game()
	game:add()
end

initialize()

function playdate.update()
	gfx.sprite.update()
end