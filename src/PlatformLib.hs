{-# LANGUAGE RecordWildCards #-}
module PlatformLib where

import Graphics.Gloss.Interface.Pure.Game

import Constants

import Structures


drawPlatform :: Point -> Picture
drawPlatform (x, y) = Pictures [Color blue $ uncurry Translate (x, y) (uncurry rectangleSolid (platformWidth, platformHeight))]

changePlatformPosition :: Point -> Float -> Point 
changePlatformPosition (x, y) k = (if newX < 400 && newX > -400 then newX else x, y)
    where 
        newX = x + k*platformSpeed 

flipDirectionVerticalyP :: GameState -> Point
flipDirectionVerticalyP  state@GameState{..} = newDirection
        -- Direction = Direction - 2.f * (Direction.x * n.x + Direction.y * n.y) * n 
        -- n = (0.f, 1.f)
        where 
            newDirection = (fst ballDirection, (-1.0) * snd ballDirection)

collidePlatform :: GameState -> Point
collidePlatform state@GameState{..}   | (distX*distX) + (distY*distY) <= r*r - 2 * r = flipDirectionVerticalyP state
                                      | otherwise = ballDirection
                    where
                        r = ballRadius 
                        newX = fst ballPosition + ballSpeed * fst ballDirection
                        newY = snd ballPosition + ballSpeed * snd ballDirection
                        platformX = fst platformPosition - platformWidth / 2
                        platformY = snd platformPosition + platformHeight / 2
                        testX
                            | newX < platformX = platformX
                            | newX > platformX + platformWidth = platformX + platformWidth
                            | otherwise = newX  
                        testY
                            | newY > platformY = platformY
                            | newY < platformY - platformHeight  = platformY - platformHeight 
                            | otherwise = newY
                        
                        distX = newX - testX
                        distY = newY - testY

applyPositionP :: GameState -> GameState 
applyPositionP state@GameState{..} = state{ballPosition = newPosition}
    where 
        newX = fst ballPosition  + ballSpeed * fst ballDirection
        newY = snd ballPosition  + ballSpeed * snd ballDirection
        newPosition = (newX, newY)

resolvePlatformCollision :: GameState  -> GameState 
resolvePlatformCollision state@GameState{..} = applyPositionP newState
    where
        newState = state{ballDirection = collidePlatform state}
