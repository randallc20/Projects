local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local physics = require "physics"
physics.start(); physics.pause()
local sch = display.contentHeight
local scw = display.contentWidth
local fsize = scw/18
local scoreArrayf = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
local scoreArrayj = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

local function mainMenu()
    composer.gotoScene("menu", "fade", 300)
    return true
end

local function loadf()
   local path = system.pathForFile( "fallscore.txt", system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
		local score = tonumber(contents);
   		local i = 1
      for line in file:lines() do
	  		
			scoreArrayf[i] = tonumber(line)
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
   table.sort(scoreArrayf, compare)
   return score
end

local function loadj()

end



function scene:create( event )

    local sceneGroup = self.view
	
	loadj()
	loadf()
    
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
        fontSize=display.contentWidth/20,
        x=display.contentWidth*.8,
        y=display.contentHeight*.92,
        onRelease = mainMenu
    }
		
	local highScoreTxt = display.newText("Highscores", scw*.5, sch*.08+20, native.SystemFontBold, fsize + 8)
	local firstTxt = display.newText("1:  " .. tostring(scoreArrayf[1]), scw*.33, sch*.30+20, native.SystemFontBold, fsize)
	local secondTxt = display.newText("2:  " .. tostring(scoreArrayf[2]), scw*.33, sch*.35+20, native.SystemFontBold, fsize)
	local thirdTxt = display.newText("3:  " .. tostring(scoreArrayf[3]), scw*.33, sch*.4+20, native.SystemFontBold, fsize)
	local fourthTxt = display.newText("4:  " .. tostring(scoreArrayf[4]), scw*.33, sch*.45+20, native.SystemFontBold, fsize)
	local fifthTxt = display.newText("5:  " .. tostring(scoreArrayf[5]), scw*.33, sch*.5+20, native.SystemFontBold, fsize)
	local sixthTxt = display.newText("6:  " .. tostring(scoreArrayf[6]), scw*.33, sch*.55+20, native.SystemFontBold, fsize)
	local seventhTxt = display.newText("7:  " .. tostring(scoreArrayf[7]), scw*.33, sch*.6+20, native.SystemFontBold, fsize)
	local eighthTxt = display.newText("8:  " .. tostring(scoreArrayf[8]), scw*.33, sch*.65+20, native.SystemFontBold, fsize)
	local ninthTxt = display.newText("9:  " .. tostring(scoreArrayf[9]), scw*.33, sch*.7+20, native.SystemFontBold, fsize)
	local tenthTxt = display.newText("10:  " .. tostring(scoreArrayf[10]), scw*.33, sch*.75+20, native.SystemFontBold, fsize)
    local highScoreTxtf = display.newText("Fall", scw*.33, sch*.2+20, native.SystemFontBold, fsize+4)
	local highScoreTxtj = display.newText("Jump", scw*.66, sch*.2+20, native.SystemFontBold, fsize + 4)
	local firstTxtj = display.newText("1:  " .. tostring(scoreArrayj[1]), scw*.66, sch*.30+20, native.SystemFontBold, fsize)
	local secondTxtj = display.newText("2:  " .. tostring(scoreArrayj[2]), scw*.66, sch*.35+20, native.SystemFontBold, fsize)
	local thirdTxtj = display.newText("3:  " .. tostring(scoreArrayj[3]), scw*.66, sch*.4+20, native.SystemFontBold, fsize)
	local fourthTxtj = display.newText("4:  " .. tostring(scoreArrayj[4]), scw*.66, sch*.45+20, native.SystemFontBold, fsize)
	local fifthTxtj = display.newText("5:  " .. tostring(scoreArrayj[5]), scw*.66, sch*.5+20, native.SystemFontBold, fsize)
	local sixthTxtj = display.newText("6:  " .. tostring(scoreArrayj[6]), scw*.66, sch*.55+20, native.SystemFontBold, fsize)
	local seventhTxtj = display.newText("7:  " .. tostring(scoreArrayj[7]), scw*.66, sch*.6+20, native.SystemFontBold, fsize)
	local eighthTxtj = display.newText("8:  " .. tostring(scoreArrayj[8]), scw*.66, sch*.65+20, native.SystemFontBold, fsize)
	local ninthTxtj = display.newText("9:  " .. tostring(scoreArrayj[9]), scw*.66, sch*.7+20, native.SystemFontBold, fsize)
	local tenthTxtj = display.newText("10:  " .. tostring(scoreArrayj[10]), scw*.66, sch*.75+20, native.SystemFontBold, fsize)
    
	
    sceneGroup:insert(background)
    sceneGroup:insert(backBtn)
    sceneGroup:insert(scorebackground)
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
    sceneGroup:insert(highScoreTxtf)
    sceneGroup:insert(highScoreTxtj)
	sceneGroup:insert(firstTxtj)
	sceneGroup:insert(secondTxtj)
	sceneGroup:insert(thirdTxtj)
	sceneGroup:insert(fourthTxtj)
	sceneGroup:insert(fifthTxtj)
	sceneGroup:insert(sixthTxtj)
	sceneGroup:insert(seventhTxtj)
	sceneGroup:insert(eighthTxtj)
	sceneGroup:insert(ninthTxtj)
	sceneGroup:insert(tenthTxtj)
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

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene