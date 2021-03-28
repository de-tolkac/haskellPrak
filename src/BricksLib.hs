module BricksLib where

import Graphics.Gloss.Interface.Pure.Game

import Structures

import Constants

-- Инициалзиция кирпичей 
initBricks :: [Brick]
initBricks = [
                Brick (-382, 300) 3, Brick (-278, 300) 3, Brick (-174, 300) 3, Brick (-70, 300) 3,
                Brick (70, 300) 3,   Brick (174, 300) 3,  Brick (278, 300)  3, Brick (382, 300) 3,
                Brick (-382, 260) 3, Brick (-278, 260) 3, Brick (-174, 260) 3, Brick (-70, 260) 3,
                Brick (70, 260) 3,   Brick (174, 260) 3,  Brick (278, 260)  3, Brick (382, 260) 3,
                Brick (-382, 220) 3, Brick (-278, 220) 3, Brick (-174, 220) 3, Brick (-70, 220) 3,
                Brick (70, 220) 3,   Brick (174, 220) 3,  Brick (278, 220)  3, Brick (382, 220) 3
            ]

drawBricks :: [Brick] -> Picture
drawBricks (Brick (x, y) hp:xs) = Pictures [Color (getColorOfBrick hp) $ uncurry Translate (x, y) (uncurry rectangleSolid (brickWidth, brickHeight)), drawBricks xs]
drawBricks _ = Pictures []

getColorOfBrick :: Int -> Color
getColorOfBrick 3 = green
getColorOfBrick 2 = yellow 
getColorOfBrick _ = red 

