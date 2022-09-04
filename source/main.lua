import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "ball"
import "game"
import "player"

local gfx <const> = playdate.graphics
local pd <const> = playdate


local function initialize()

	local ball = Ball(200, 120, 8, { 4, 4 })
	ball:add()
	local game = Game()
	game:add()
	game:addBlocks(4, 7)

	local player = Player(getLeftBorder() + gameAreaWidth / 2, getBottomBorder() - 25, 5)
	player:add()
end

initialize()

function playdate.update()
	gfx.sprite.update()
end
