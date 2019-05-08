require("math")
local physics = require("physics")

local composer = require("composer")
local audio = require("audio")
local scene = composer.newScene()

--local vars
local bg1
local bg2
local screenbot = display.actualContentHeight
local times = 0
local stopped = false
local body_radius = display.contentWidth/25
local scrollSpeed = body_radius/25
local ssi = scrollSpeed
local rlop = 2 -- number of platforms
local gwidth = body_radius * 5 + 10
local grad = gwidth/2
local pos = 0
local accela = 0
local motionx = 0
local speed = 30
local donealready = false

score = 0 --keep this non-local to retain score info

--custom functions

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

local function onCollision( event )

	if ( event.phase == "began" )then
		if not ( event.object1.y+(body_radius) > event.object2.y-(event.object2.height*0.5)+0.1 ) then
			audio.play(jumphit, {channel=2})
		end
    elseif ( event.phase == "ended" ) then
    end
end

local function addScrollableBg()
	bgImage = {type = "image", filename = "clouds1.png"}
	
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
	bg1.y = bg1.y + scrollSpeed * dt
	bg2.y = bg2.y + scrollSpeed * dt
	
	if (bg1.y - display.contentHeight/2) > display.actualContentHeight then
		bg1:translate(0, -bg1.contentHeight * 2)
    end
    if (bg2.y - display.contentHeight/2) > display.actualContentHeight then
		bg2:translate(0, -bg2.contentHeight * 2)
    end
end

local function onPreCollision( self, event )

   local collideObject = event.other
   
   if ( collideObject.collType == "pthru" ) then
		if ( self.y+(body_radius) > collideObject.y-(collideObject.height*0.5)+0.1 ) then
			if event.contact then
				event.contact.isEnabled = false
			end
		else
			audio.play(jumphit, {channel=2})
		end
		
   end
   
end

Runtime:addEventListener('key', function (event)  
  if event.keyName == 'left' and event.phase == 'down' then
	accela = - speed
  end
  if event.keyName == 'left' and event.phase == 'up' then
	accela = 0
  end
end)  
Runtime:addEventListener('key', function (event)  
  if event.keyName == 'right' and event.phase == 'down' then
	accela = speed
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


--Runtime:addEventListener( "collision", onCollision ) 

local count = false

local function updplat()
	gpos = math.random(display.contentWidth-gwidth) + grad
	local rr1 = display.newRect( plat, 0, 0, grad*2, body_radius/3 )
	rr1.collType = "pthru"
	rr1:setFillColor(.25,.25,.25,1)
	rr1.x = gpos
	rr1.y = display.contentHeight - rlop*body_radius*4
	
	screenbot = screenbot - scrollSpeed
	score = math.floor(-(screenbot-display.actualContentHeight))
	
	rlop = rlop + 1
	
	if(c.y - body_radius > screenbot) then --death
		stopped = true
		composer.gotoScene( "deathscreenjump", "fade", 100 )
	end

	physics.addBody( rr1, "static", { friction=0.4, bounce=2 })	
	if(c.y <= pos) then
		scrollSpeed = scrollSpeed + ssi/3
		speed = speed + 5
		pos = pos - display.contentHeight/2
	end
	plat.y = plat.y + scrollSpeed
	
	if (c.y + body_radius <= screenbot - display.contentHeight*3/4  and count==false) then
		scrollSpeed = scrollSpeed + ssi*2
		count = true
	end
	if (count and c.y + body_radius > screenbot - display.contentHeight*3/4) then
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
		c:setLinearVelocity( vx+accela, vy )
		c.angularVelocity = c.angularVelocity + accela
		
		if(c.x>=display.contentWidth) then c:translate(-display.contentWidth,0)
		elseif(c.x<=0) then c:translate(display.contentWidth,0)
		end
		moveBg(.5)
		updplat()
		updtxt()
	end
end
Runtime:addEventListener("enterFrame",update)


function scene:create( event )

	local sceneGroup = self.view

	jumphit = audio.loadSound("jumphit.wav")
		
	txt = display.newText({text=0,x=display.contentWidth/6,y=50,fontSize=50})
	txt:setFillColor(1,1,1,1)
	
	addScrollableBg()

	physics.start()
	physics.setGravity( 0, 9.8 )
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
	c.y = 0
	c.fill = { type="image", filename="spiral.png" }
	c:setFillColor( ballred, ballgreen, ballblue, 1 )
	physics.addBody( c, "dynamic", { density = 1.0, friction = 0.4, bounce = 0.8, radius = body_radius } )
	plat:insert(c)
		
	c.preCollision = onPreCollision
	c:addEventListener( "preCollision", character )
		
	--local function leftTouchListener( event ) end leftButton:addEventListener( "touch", leftTouchListener )
	--local function rightTouchListener( event ) end rightButton:addEventListener( "touch", rightTouchListener )

	plat.x = 0
	plat.y = 0

	startplat = display.newRect( plat, display.contentWidth/2, display.contentHeight-body_radius*4, grad*2, body_radius/3 )
	startplat:setFillColor(.25,.25,.25,1)
	startplat.collType = "pthru"
	physics.addBody( startplat, "static", { friction=0.4, bounce=2 })
	c.x = startplat.x
	c.y = startplat.y-body_radius*3
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		if donealready then
			scene:create()
		end
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		Runtime:addEventListener("enterFrame",update)
		paused = false
		donealready = true
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
		paused = true
		physics.stop()
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	score = 0
--	scrollSpeed = body_radius/20
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