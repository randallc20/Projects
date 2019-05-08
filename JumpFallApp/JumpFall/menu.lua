-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local audio = require( "audio" )

--------------------------------------------

-- forward declarations and other locals
local playBtn
local cwidth = display.contentWidth
local cheight = display.contentHeight
local fsize = cwidth/18




-- 'onRelease' event listener for playBtn
local function playFalling()
	
	-- go to level1.lua scene
	composer.gotoScene( "fall", "fade", 300 )
	
	return true	-- indicates successful touch
end

    local function openHighScoreMenu()
    
        composer.gotoScene("highscores", "fade", 300)
        return true
    end
    
    local function playJumping()
        composer.gotoScene("jump", "fade", 300)
        return true
    end
    
    local function optionMenu()
        composer.gotoScene("optionMenu", "fade", 300)
        return true
    end
	
function scene:create( event )
	composer.removeHidden()
    local btnwidth = display.contentWidth*.4
    local btnheight = display.contentHeight*.1
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "stars2.png", display.contentWidth, display.contentHeight )
	audio.play()
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newText("Gravity", cwidth*.5, cheight*.15, native.SystemFontBold, fsize+60)
	
	-- create a widget button (which will loads level1.lua on release)
	fallBtn = widget.newButton{
		label="Play Falling",
		labelColor = { default={.7, .7, .7, .9}, over={1, 1, 1} },
		default="button.png",
		over="button-over.png",
		width=btnwidth, height=btnheight,
        fontSize=fsize,
		onRelease = playFalling	-- event listener function
	}
	fallBtn.x = display.contentWidth*0.5
	fallBtn.y = display.contentHeight*.82
    
    scoreBtn = widget.newButton{
        label = "High Scores",
        labelColor = { default={.7, .7, .7, .9}, over={1, 1, 1}},
        default = "button.png",
        over = "button-over.png",
        width = btnwidth, height = btnheight,
        x = display.contentWidth*.5,
        y = display.contentHeight*.60,
        fontSize=fsize,
        onRelease = openHighScoreMenu
    }
    
    jumpBtn = widget.newButton{
        label = "Play Jumping",
        labelColor = { default={.7, .7, .7, .9}, over={1, 1, 1}},
        default = "button.png",
        over = "button-over.png",
        width = btnwidth, height = btnheight,
        x = display.contentWidth*.5,
        y = display.contentHeight*.71,
        fontSize=fsize,
        onRelease = playJumping
    }
    
    optionBtn = widget.newButton{
        label = "Options",
        labelColor = { default={.7, .7, .7, .9}, over={1, 1, 1}},
        default = "button.png",
        over = "button-over.png",
        width = btnwidth, height = btnheight,
        x = display.contentWidth*.5,
        y = display.contentHeight*.49,
        fontSize=fsize,
        onRelease = optionMenu
    }
    
	
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( fallBtn )
    sceneGroup:insert( scoreBtn )
    sceneGroup:insert( jumpBtn )
    sceneGroup:insert( optionBtn )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		local backgroundMusic = audio.loadSound("backgroundMusicMenu.wav")
		local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=2000 } )
		audio.resume(backgroundMusicChannel)
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		audio.pause(backgroundMusicChannel)
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene