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
platformWidth :: Float 
platformWidth = 200

platformHeight :: Float 
platformHeight = 20

platformSpeed :: Float 
platformSpeed = 10
-- End


-- Ball
ballRadius :: Float 
ballRadius = 10

ballSpeed :: Float 
ballSpeed = 5.0
-- End


--Brick
brickWidth :: Float 
brickWidth = 100

brickHeight :: Float 
brickHeight = 30

brickInitialHP :: Int 
brickInitialHP = 3
-- End

