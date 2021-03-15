module Constants where


import Graphics.Gloss.Interface.Pure.Game

-- Colors
getBrickColor :: Color
getBrickColor = yellow

getBallColor :: Color 
getBallColor = red 

getPlatformColor :: Color 
getPlatformColor = green
-- End


-- Platform
platformWidth :: Int 
platformWidth = 300

platformHeight :: Int 
platformHeight = 50
-- End


-- Ball
ballRadius :: Int 
ballRadius = 10

ballSpeed :: Float 
ballSpeed = 2.0
-- End


--Brick
brickWidth :: Int 
brickWidth = 100

brickHeight :: Int 
brickHeight = 30

brickInitialHP :: Int 
brickInitialHP = 3
-- End

