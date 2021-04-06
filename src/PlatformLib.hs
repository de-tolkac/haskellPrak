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

flipDirectionVerticalyP :: Float -> GameState -> Point
flipDirectionVerticalyP  angle state@GameState{..} = newDirection
        -- Direction = Direction - 2.f * (Direction.x * n.x + Direction.y * n.y) * n 
        -- n = (0.f, 1.f)
        where 
            --newX = fst ballDirection
            --newY = (-1.0) * snd ballDirection
            --newDir = (newX*cos angle + newY * sin angle, newY * cos angle + newX * sin angle)
            --len = sqrt(fst newDir * fst newDir + snd newDir * snd newDir)
            --newDirection = (fst newDir / len, snd newDir / len)
            --n = (y * sin angle, y * cos angle)
            -- (dirX, dirY) - 2*(dirX*nX + dirY*nY)*(nX, nY)
            --nX = y * sin angle
            --nY = y * cos angle
            dirX = 0.0
            dirY = 1.0
            --k = 2*dirX*nX + 2*dirY*nY
            --newDirection = (dirX - k * nX, dirY - k*nY)
            a = angle * 0.01745 -- (pi / 180)
            newDirection = (dirX * cos a + dirY * sin a, dirY * cos a + dirX * sin a)
            --len = sqrt (fst newD * fst newD + snd newD * snd newD)
            --newDirection = (fst newD / len, snd newD / len)

collidePlatform :: GameState -> Point
collidePlatform state@GameState{..}   | dist <= r * r/4 = flipDirectionVerticalyP angle state
                                      | otherwise = ballDirection
                    where
                        r = ballRadius 
                        newX = fst ballPosition + ballSpeed * fst ballDirection
                        newY = snd ballPosition + ballSpeed * snd ballDirection
                        platformX = fst platformPosition - (platformWidth / 2)
                        platformY = snd platformPosition + (platformHeight / 2)
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
                        distCX = newX - fst platformPosition
                        distCY = newY - platformY
                        distFromCenter = sqrt((distCX * distCX) + (distCY * distCY)) - r/2
                        angleABS = (platformWidth / 2) / 180.0 * distFromCenter
                        angle = angleABS * if newX > fst platformPosition then 1 else -1
                        --angle = if newX > fst platformPosition - 2*r && newX < fst platformPosition + 2*r then 0 else angleT
                        dist = (distX*distX) + (distY*distY)


applyPositionP :: GameState -> GameState 
applyPositionP state@GameState{..} = state{ballPosition = newPosition}
    where 
        newX = fst ballPosition  + ballSpeed * fst ballDirection
        newY = snd ballPosition  + ballSpeed * snd ballDirection
        newPosition = (newX, newY)

resolvePlatformCollision :: GameState  -> GameState 
resolvePlatformCollision state@GameState{..} = newState
    where
        newState = state{ballDirection = collidePlatform state}
