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

platformWidth :: Int 
platformWidth = 300

platformHeight :: Int 
platformHeight = 50

ballRadius :: Int 
ballRadius = 10

brickWidth :: Int 
brickWidth = 100

brickHeight :: Int 
brickHeight = 30

ballSpeed :: Float 
ballSpeed = 2.0

brickInitialHP :: Int 
brickInitialHP = 3
