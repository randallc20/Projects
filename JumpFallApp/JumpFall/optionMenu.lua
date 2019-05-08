-----------------------------------------------------------------------------------------
--
-- optionMenu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

local widget = require("widget")

local audio = require "audio"
--------------------------------------------

-- forward declarations and other locals
local scw = display.contentWidth
local sch = display.contentHeight
local fsize = scw/20

local function mainMenu()
    composer.gotoScene("menu", "fade", 300)
    return true
end

local function setMusicVol(event)
	audio.setVolume(event.value/100, {channel=1})
end

local function setSFX(event)
	audio.setVolume(event.value/100, {channel=2})
end

local function inputPress(event)
	--TODO: Switch input
end

local function setRed(event)
	ballred=event.value/100.0
end
local function setGreen(event)
	ballgreen=event.value/100.0
end
local function setBlue(event)
	ballblue=event.value/100.0
end

--showcolor=display.newRect(0,0,0,0)

local function update( event )
	showcolor:setFillColor( ballred, ballgreen, ballblue, 1 )
end

function scene:create( event )

    local sceneGroup = self.view
	
	audio.resume({channel=1})
    
    local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background:setFillColor( .14, .14, .14 )
    
    local scorebackground = display.newRect( display.contentWidth*.15, display.contentHeight*.15, display.contentWidth*.7, display.contentHeight*.7)
    scorebackground.anchorX = 0
    scorebackground.anchorY = 0
    scorebackground:setFillColor( .3, .3, .3, .5)
    backBtn = widget.newButton
    {
        label = "back",
        labelColor = {default={.7, .7, .7}, over={1, 1, 1}},
        default="button.png",
        over="button-over.png",
        width=150, height=50,
        fontSize=fsize,
        x=display.contentWidth*.8,
        y=display.contentHeight*.92,
        onRelease = mainMenu
    }
	
	local musicSlider = widget.newSlider(
    {
        top = sch*.2,
        left = scw*.4,
        width = scw*.35,
		height = sch*.1,
        value = 100,  -- Start slider at 10% (optional)
        listener = setMusicVol
	} )
    
	local sfxSlider = widget.newSlider(
	{
		top = sch*.28,
		left = scw*.4,
		width = scw*.35,
		height = sch*.1,
		value = 100,
		listener = setSFX
	})
	
	local redSlider = widget.newSlider(
    {
        top = sch*.56,
        left = scw*.4,
        width = scw*.35,
		height = sch*.1,
        value = 100.0,  -- Start slider at 10% (optional)
        listener = setRed
	} )
	local greenSlider = widget.newSlider(
    {
        top = sch*.63,
        left = scw*.4,
        width = scw*.35,
		height = sch*.1,
        value = 100.0,  -- Start slider at 10% (optional)
        listener = setGreen
	} )
	local blueSlider = widget.newSlider(
    {
        top = sch*.70,
        left = scw*.4,
        width = scw*.35,
		height = sch*.1,
        value = 100.0,  -- Start slider at 10% (optional)
        listener = setBlue
	} )
	
	local musicTxt = display.newText("Music:", scw*.27, sch*.2+20, native.SystemFontBold, fsize)
	local sfxTxt = display.newText("SFX:", scw*.27, sch*.28+20, native.SystemFontBold, fsize)
	local colorTxt = display.newText("Ball Color", scw*.5, sch*.49+20, native.SystemFontBold, fsize)
	local redTxt = display.newText("Red:", scw*.27, sch*.56+20, native.SystemFontBold, fsize)
	local blueTxt = display.newText("Green:", scw*.27, sch*.63+20, native.SystemFontBold, fsize)
	local greenTxt = display.newText("Blue:", scw*.27, sch*.70+20, native.SystemFontBold, fsize)

	showcolor = display.newCircle( scw*.5, sch*.8, sch/30 )
	showcolor.fill = { type="image", filename="spiral.png" }
	showcolor:setFillColor( 1, 1, 1, 1 )

	
    sceneGroup:insert(background)
    sceneGroup:insert(backBtn)
    sceneGroup:insert(scorebackground)
	sceneGroup:insert(musicSlider)
	sceneGroup:insert(sfxSlider)
	sceneGroup:insert(musicTxt)
	sceneGroup:insert(sfxTxt)
	sceneGroup:insert(colorTxt)
	sceneGroup:insert(redSlider)
	sceneGroup:insert(greenSlider)
	sceneGroup:insert(blueSlider)
	sceneGroup:insert(redTxt)
	sceneGroup:insert(greenTxt)
	sceneGroup:insert(blueTxt)
	sceneGroup:insert(showcolor)

	

	

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		Runtime:addEventListener("enterFrame",update)
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
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene