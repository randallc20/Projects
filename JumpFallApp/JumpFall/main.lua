-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"
local audio = require "audio"
audio.reserveChannels(2)

score = 0 -- initializes score variable
jumpscore = 0
fallscore = 0
ballred=100
ballblue=100
ballgreen=100

-- load menu screen
composer.gotoScene( "menu" )



--consider this: EMOJI BALLS