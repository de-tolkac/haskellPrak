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

platformWidthDiv2 :: Float 
platformWidthDiv2 = 100

platformHeight :: Float 
platformHeight = 20

platformHeightDiv2 :: Float 
platformHeightDiv2 = 10

platformSpeed :: Float 
platformSpeed = 14
-- End


-- Ball
ballRadius :: Float 
ballRadius = 10

ballSpeed :: Float 
ballSpeed = 7.0
-- End


--Brick
brickWidth :: Float 
brickWidth = 100

brickWidthDiv2 :: Float 
brickWidthDiv2 = 50

brickHeight :: Float 
brickHeight = 30

brickHeightDiv2 :: Float 
brickHeightDiv2 = 15

brickInitialHP :: Int 
brickInitialHP = 3
-- End

