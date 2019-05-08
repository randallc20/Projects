require("math")
local physics = require("physics")
local composer = require ("composer")
local audio = require("audio")
local scene = composer.newScene()

--local variables
local stopped = false
local pos = display.contentHeight/2 --counts position so scrolling can speed up
local count = false
local rlop = 2 -- counts up number of platforms
local body_radius = display.contentWidth/20
local gwidth = body_radius * 5 + 10
local grad = gwidth/2
local scrollSpeed = body_radius/20
local ssi = scrollSpeed
local screentop = 0
local times = 1
local tvr = 1
local donealready = false
local speed = body_radius
score = 0

--Custom functions

local function save()
local path = system.pathForFile( "fallscore.txt", system.DocumentsDirectory )
   local file = io.open(path, "a")
   if ( file ) then
      local contents = tostring( score )
      file:write( contents )
	  file:write("\n")
      io.close( file )
      return true
   else
      print( "Error: could not read ", filename, "." )
      return false
   end
end
 --does not go here
local function load()
   local path = system.pathForFile( "fallscore.txt", system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   scoreArray = {}
   if ( file ) then
   		local i = 0
      for line in file:lines() do
	  		
			scoreArray[i] = tonumber(line)
			i = i + 1
	  end
      io.close( file )
      return score
   else
      print( "Error: could not read scores from ", filename, "." )
   end
   --sort the array here
   table.sort(scoreArray, compare)
   --test for sorting 
   print(table.concat(scoreArray, "," ))
end

local function onCollision( event )
	if ( event.phase == "began" ) then
        local sfxchannel = audio.play(fallhit, {channel=2})
    elseif ( event.phase == "ended" ) then
    end
end
local function addScrollableBg()
	bgImage = {type = "image", filename = "rocks0.png"}
	
	bg1 = display.newRect(0,0,display.actualContentHeight, display.actualContentHeight)
	bg1.fill = bgImage
	bg1.x = display.contentCenterX
	bg1.y = display.contentCenterY
	
	bg2 = display.newRect(0,0,display.actualContentHeight, display.actualContentHeight)
	bg2.fill = bgImage
	bg2.x = display.contentCenterX
	bg2.y = display.contentCenterY + display.actualContentHeight

end

local function moveBg(dt)
	bg1.y = bg1.y - scrollSpeed * dt
	bg2.y = bg2.y - scrollSpeed * dt
	
	if(times==0) then
		bgImage = {type = "image", filename = "rocks0.png"}
	elseif(times==tvr) then
		bgImage = {type = "image", filename = "rocks1.png"}
	elseif (times>=tvr and times <= tvr*2) then 
		bgImage = {type = "image", filename = "rocks2.png"}
	elseif (times>tvr*2) then 
		bgImage = {type = "image", filename = "rocks3.png"}
	end
	
	
	if (bg1.y + bg1.contentHeight/2) < 0 then
		bg1:translate(0, bg1.contentHeight * 2)
		times = times + 1
		bg1.fill = bgImage
    end
    if (bg2.y + bg2.contentHeight/2) < 0 then
		bg2:translate(0, bg2.contentHeight * 2)
		times = times + 1
		bg2.fill = bgImage
    end
end

local function platgen() -- generates platforms
	gpos = math.random(display.contentWidth-2*gwidth) + gwidth--gets random for center
	local rr1 = display.newRect( plat, 0, 0, gpos-grad, body_radius/3 )--creates two rectangles to mark off sides of gap
	local rr2 = display.newRect( plat, 0, 0, display.contentWidth-(gpos+grad), body_radius/3 )
	rr1:setFillColor(.25,.25,.25,1)
	rr2:setFillColor(.25,.25,.25,1)
	
	rr1.x = rr1.width/2--moves them to the right place
	rr2.x = gpos+grad + rr2.width/2
	rr1.y = rlop*4*body_radius
	rr2.y = rr1.y
	rlop = rlop + 1

	physics.addBody( rr1, "static", { friction=0.4, bounce=nobounce })	
	physics.addBody( rr2, "static", { friction=0.4, bounce=nobounce })	
end

local function updplat()

	if(c.y >= pos) then --speeds up
		scrollSpeed = scrollSpeed + ssi/(3 + 0.7*pos/display.contentHeight)
		pos = pos + display.contentHeight/2
		speed = speed + 5
	end
	plat.y = plat.y - scrollSpeed
	screentop = screentop + scrollSpeed
	
	score = math.floor(screentop)
	
	if(c.y+body_radius<screentop) then --death
		stopped = true
		save()
		composer.gotoScene( "deathscreenfall", "fade", 100 )
	end
	
	
	
	if (c.y + body_radius >= screentop + display.contentHeight*3/4  and count==false) then
		scrollSpeed = scrollSpeed + ssi*2
		count = true
	end
	if (count and c.y + body_radius < screentop + display.contentHeight*3/4) then
		scrollSpeed = scrollSpeed - ssi*2
		count = false
	end
end


local function updtxt()
	txt.text = score
	txt:toFront()
end

local function update( event )
	if(stopped == false) then
		local vx, vy = c:getLinearVelocity()
		c:setLinearVelocity( vx+(accela*.3), vy )
		c.angularVelocity = c.angularVelocity + accela
		
		if(c.x>=display.contentWidth) then c:translate(-display.contentWidth,0)
		elseif(c.x<=0) then c:translate(display.contentWidth,0)
		end
		platgen()
		updplat()
		updtxt()

		moveBg(.5)
		
		leftButton:toFront()
		rightButton:toFront()
	end
end

--Composer functions

function scene:create(event)

	
	

	local sceneGroup = self.view
		
	stopped = false
	pos = display.contentHeight/2 --counts position so scrolling can speed up
	count = false
	rlop = 2 -- counts up number of platforms
	body_radius = display.contentWidth/20
	gwidth = body_radius * 5 + 10
	grad = gwidth/2
	scrollSpeed = body_radius/20
	ssi = scrollSpeed
	screentop = 0
	times = 1
	tvr = 1

	score = 0
	
	fallhit = audio.loadSound("fallhit.wav")

	txt = display.newText({text=0,x=display.contentWidth/6,y=50,fontSize=50})
	txt:setFillColor(1,1,1,1)

	bgImage = {type = "image", filename = "rocks0.png"}
	
	bg1 = display.newRect(0,0,display.actualContentHeight, display.actualContentHeight)
	bg1.fill = bgImage
	bg1.x = display.contentCenterX
	bg1.y = display.contentCenterY
	
	bg2 = display.newRect(0,0,display.actualContentHeight, display.actualContentHeight)
	bg2.fill = bgImage
	bg2.x = display.contentCenterX
	bg2.y = display.contentCenterY + display.actualContentHeight

	physics.start()
	physics.setGravity( 0, body_radius*.6 )
	plat = display.newGroup()


	
	leftButton = display.newRect( display.contentWidth/4, display.contentHeight/2, display.contentWidth/2, display.contentHeight)
	leftButton:setFillColor( 0, 0, 0, 0.05 )
	rightButton = display.newRect( 3*display.contentWidth/4, display.contentHeight/2, display.contentWidth/2, display.contentHeight)
	rightButton:setFillColor( 0, 0, 0, 0.05 )

	leftButton:addEventListener( "touch", leftTouchListener )
	rightButton:addEventListener( "touch", rightTouchListener )

	--creates circle
	
	c = display.newCircle( 0, 0, body_radius )
	c.x = display.contentWidth / 2
	c.y = 30
	c.fill = { type="image", filename="spiral.png" }
	c:setFillColor( ballred, ballgreen, ballblue, 1 )
	physics.addBody( c, "dynamic", { density = 1.0, friction = 0.4, bounce = 0, radius = body_radius } )
	plat:insert(c)

	accela = 0
	motionx = 0
	speed = body_radius

	--variables determining platform position and size
	
	plat.x = 0 --sets the plat group to 0,0
	plat.y = 0
	nobounce = 0.001--variable for a small number so i dont have to retype it a lot
	
	sceneGroup:insert(leftButton)
	sceneGroup:insert(rightButton)
	sceneGroup:insert(bg1)
	sceneGroup:insert(bg2)
	sceneGroup:insert(txt)
	sceneGroup:insert(plat)
--	donealready = true
end

--Runtime Listeners
Runtime:addEventListener('key', function (event)  
if event.keyName == 'left' and event.phase == 'down' then
	accela = -(speed+scrollSpeed)
end
if event.keyName == 'left' and event.phase == 'up' then
	accela = 0
end
end)  
Runtime:addEventListener('key', function (event)  
if event.keyName == 'right' and event.phase == 'down' then
	accela = speed+scrollSpeed
end
if event.keyName == 'right' and event.phase == 'up' then
	accela = 0
end
end)  
Runtime:addEventListener('key', function (event)  
if event.keyName == 'space' and event.phase == 'down' then
	if(stopped==false) then 
		stopped = true
		physics.pause()
	elseif(stopped==true) then 
		stopped = false 
		physics.start()
	end
end
end)  

Runtime:addEventListener( "collision", onCollision )

function leftTouchListener( event )
	if ( event.phase == "began" ) then
		accela = -(speed+scrollSpeed)
	elseif ( event.phase == "ended" ) then
		accela = 0
	end
	return true  -- Prevents touch propagation to underlying objects
end
function rightTouchListener( event )
	if ( event.phase == "began" ) then
		accela = (speed+scrollSpeed)
	elseif ( event.phase == "ended" ) then
		accela = 0
	end
	return true  -- Prevents touch propagation to underlying objects
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	speed = body_radius
	scrollSpeed = body_radius/20
	pos = display.contentHeight/2 --counts position so scrolling can speed up
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		if(donealready) then
			scene:create()
			
		end
	elseif phase == "did" then
		
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		Runtime:addEventListener("enterFrame",update)
		donealready=true
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	scrollSpeed = body_radius/20
	pos = display.contentHeight/2 --counts position so scrolling can speed up
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		
	elseif phase == "did" then
		-- Called when the scene is now off screen
		physics.stop()
		
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	

	pos = display.contentHeight/2 --counts position so scrolling can speed up
	speed = body_radius
	scrollSpeed = body_radius/20
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