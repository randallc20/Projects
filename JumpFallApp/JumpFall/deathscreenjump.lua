local composer = require("composer")
local widget = require("widget")

-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local scoreArray = {9000, 8000, 7000, 6000, 5000, 4000, 3000, 2000, 1000, 0}

--------------------------------------------

-- forward declarations and other locals
local scw, sch, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local fsize = scw/18

local function mainMenu()
    composer.gotoScene("menu", "fade", 300)
    return true
end

local function playJump()
    composer.gotoScene("jump", "fade", 300)
    return true
end

local function load()
   local path = system.pathForFile( "jumpscore.txt", system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
		local scorel = tonumber(contents);
   		local i = 1
      for line in file:lines() do
	  		
			scoreArray[i] = tonumber(line)
			i = i + 1
	  end
      io.close( file )
   else
      print( "Error: could not read scores from ", filename, "." )
   end
   
	local function compare( a, b)
		return a > b
	end
   --sort the array here
   table.sort(scoreArray, compare)
   return scorel
end

function scene:create( event )
    local sceneGroup = self.view
    local scorebackground = display.newRect( display.contentWidth*.15, display.contentHeight*.15, display.contentWidth*.7, display.contentHeight*.7)
    scorebackground.anchorX = 0
    scorebackground.anchorY = 0
    scorebackground:setFillColor( .3, .3, .3, .5)
    
    local emojipic = display.newImage("img/sademoji.png", scw*.25, sch*.2)
    emojipic.x, emojipic.y = scw*.5, sch*.08
    
    menuBtn = widget.newButton
    {
        label = "Main Menu",
        labelColor = {default={.7, .7, .7}, over={1, 1, 1}},
        default="button.png",
        over="button-over.png",
        width=150, height=50,
        fontSize=display.contentWidth/20,
        x=display.contentWidth*.8,
        y=display.contentHeight*.92,
        onRelease = mainMenu
    }
    
    playBtn = widget.newButton
    {
        label = "Play Again",
        labelColor = {default={.7, .7, .7}, over={1, 1, 1}},
        default="button.png",
        over="button-over.png",
        width=150, height=50,
        fontSize=display.contentWidth/20,
        x= display.contentWidth*.2,
        y=display.contentHeight*.92,
        onRelease = playJump
    }
    
    local curScoreTxt = display.newText("Your Score: " .. tostring(score), scw*.5, sch*.18+20, native.SystemFontBold, fsize+5)
	local highScoreTxt = display.newText("Highscores:", scw*.5, sch*.25+20, native.SystemFontBold, fsize)
    local firstTxt = display.newText("1........................" .. tostring(scoreArray[1]), scw*.5, sch*.30+20, native.SystemFontBold, fsize)
	local secondTxt = display.newText("2........................" .. tostring(scoreArray[2]), scw*.5, sch*.35+20, native.SystemFontBold, fsize)
	local thirdTxt = display.newText("3........................" .. tostring(scoreArray[3]), scw*.5, sch*.4+20, native.SystemFontBold, fsize)
	local fourthTxt = display.newText("4........................" .. tostring(scoreArray[4]), scw*.5, sch*.45+20, native.SystemFontBold, fsize)
	local fifthTxt = display.newText("5........................" .. tostring(scoreArray[5]), scw*.5, sch*.5+20, native.SystemFontBold, fsize)
	local sixthTxt = display.newText("6........................" .. tostring(scoreArray[6]), scw*.5, sch*.55+20, native.SystemFontBold, fsize)
	local seventhTxt = display.newText("7........................" .. tostring(scoreArray[7]), scw*.5, sch*.6+20, native.SystemFontBold, fsize)
	local eighthTxt = display.newText("8........................" .. tostring(scoreArray[8]), scw*.5, sch*.65+20, native.SystemFontBold, fsize)
	local ninthTxt = display.newText("9........................" .. tostring(scoreArray[9]), scw*.5, sch*.7+20, native.SystemFontBold, fsize)
	local tenthTxt = display.newText("10........................" .. tostring(scoreArray[10]), scw*.5, sch*.75+20, native.SystemFontBold, fsize)
    
    sceneGroup:insert(scorebackground)
    sceneGroup:insert(menuBtn)
    sceneGroup:insert(playBtn)
    sceneGroup:insert(curScoreTxt)
	sceneGroup:insert(highScoreTxt)
	sceneGroup:insert(firstTxt)
	sceneGroup:insert(secondTxt)
	sceneGroup:insert(thirdTxt)
	sceneGroup:insert(fourthTxt)
	sceneGroup:insert(fifthTxt)
	sceneGroup:insert(sixthTxt)
	sceneGroup:insert(seventhTxt)
	sceneGroup:insert(eighthTxt)
	sceneGroup:insert(ninthTxt)
	sceneGroup:insert(tenthTxt)
    sceneGroup:insert(emojipic)
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
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene