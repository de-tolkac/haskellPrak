{-# LANGUAGE RecordWildCards #-}
module BricksLib where

import Graphics.Gloss.Interface.Pure.Game

import Structures

import Constants

import Data.Maybe
import Data.Monoid


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


flipDirectionVerticalyB :: Point -> Point
flipDirectionVerticalyB  direction = newDirection
        -- Direction = Direction - 2.f * (Direction.x * n.x + Direction.y * n.y) * n 
        -- n = (0.f, 1.f)
        where 
            newDirection = (fst direction, (-1.0) * snd direction)

flipDirectionHorizontalyB :: Point -> Point
flipDirectionHorizontalyB  direction = newDirection
        -- Direction = Direction - 2.f * (Direction.x * n.x + Direction.y * n.y) * n 
        -- n = (0.f, 1.f)
        where 
            newDirection = ((-1.0) * fst direction, snd direction)


collideBrick :: Brick -> Point -> Point -> HitBrick 
collideBrick brick@Brick{..} ballPosition ballDirection  | cond && (testX /= newX) = HitBrick True (flipDirectionHorizontalyB ballDirection) (Just brick{hp = hp - 1})
                                                         | cond && (testY /= newY) = HitBrick True (flipDirectionVerticalyB ballDirection) (Just brick{hp = hp - 1})
                                                         | otherwise = HitBrick False ballDirection (Just brick)
                    where
                        r = ballRadius 
                        newX = fst ballPosition + ballSpeed * fst ballDirection
                        newY = snd ballPosition + ballSpeed * snd ballDirection
                        brickX = fst position - brickWidth  / 2
                        brickY = snd position + brickHeight  / 2
                        testX
                            | newX < brickX = brickX
                            | newX > brickX + brickWidth = brickX + brickWidth
                            | otherwise = newX  
                        testY
                            | newY > brickY = brickY
                            | newY < brickY - brickHeight  = brickY - brickHeight 
                            | otherwise = newY
                        
                        distX = newX - testX
                        distY = newY - testY
                        cond = (distX*distX) + (distY*distY) <= r*r


applyPositionB :: Bool -> GameState -> GameState 
applyPositionB hit state@GameState{..} = state{ballPosition = newPosition}
    where 
        newX = fst ballPosition  + ballSpeed * fst ballDirection
        newY = snd ballPosition  + ballSpeed * snd ballDirection
        newPosition 
                |   hit =  (newX, newY)
                |   otherwise = ballPosition

insertBrick :: [Brick] -> Maybe Brick -> [Brick]
insertBrick (b:bs) br = new
    where 
        new = case br of 
              Just c -> b:fromJust br:bs
              Nothing -> b:bs

insertBrick _ br = new
    where
        new = case br of
                Just c -> [fromJust br]
                Nothing -> []

checkBricks :: [Brick] -> [Brick] -> Bool ->  GameState -> CollideBricksReturn 
checkBricks _ b True state = CollideBricksReturn b state
checkBricks (Brick (x, y) hp:xs) b _ state@GameState{..} = checkBricks xs oldBricks hit newState{ballDirection = newDirection}
    where
        HitBrick hit newDirection brick = if hp > 0 then collideBrick (Brick (x, y) hp) ballPosition ballDirection else HitBrick False ballDirection Nothing
        newScore = if hit && hp == 1 then score + 1 else score
        newState = state{score = newScore}
        oldBricks = insertBrick b brick ++ if hit then xs else [] 
checkBricks _ b _ state = CollideBricksReturn b state


resolveBricksCollision :: GameState -> GameState 
resolveBricksCollision state@GameState{..} = newState{bricks = br} 
    where 
      CollideBricksReturn br newState = checkBricks bricks [] False state 

