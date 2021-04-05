{-# LANGUAGE RecordWildCards #-}
module BallLib where

import Graphics.Gloss.Interface.Pure.Game

import Structures

import Constants 

import GamePlay

import PlatformLib

flipDirectionVerticaly :: GameState -> GameState
flipDirectionVerticaly  state@GameState{..} = state{ballDirection  = newDirection}
        -- Direction = Direction - 2.f * (Direction.x * n.x + Direction.y * n.y) * n 
        -- n = (0.f, 1.f)
        where 
            newDirection = (fst ballDirection, (-1.0) * snd ballDirection)

flipDirectionHorizontaly :: GameState -> GameState
flipDirectionHorizontaly  state@GameState{..} = state{ballDirection  = newDirection}
        where 
            newDirection = ((-1.0) * fst ballDirection, snd ballDirection)

-- Collision detection
isCollideWalls :: GameState -> Maybe CollideObject  
isCollideWalls state@GameState{..} | ballX - ballRadius <= -500 || ballX + ballRadius >= 500 = Just Wall 
                              | ballY + 2 * ballRadius >= 500 = Just Top
                              | ballY - ballRadius <= -500 = Just Bottom
                              | otherwise = Nothing 
        where
            ballX = fst ballPosition + ballSpeed * fst ballDirection 
            ballY = snd ballPosition + ballSpeed * snd ballDirection

resolveCollide :: GameState -> GameState
resolveCollide state@GameState{..} | wallCollisionType == 1 = flipDirectionVerticaly state
                                   | wallCollisionType == 2 = flipDirectionHorizontaly state
                                   | wallCollisionType == 3 = gameOverFunc state
                                   | otherwise  = resolvePlatformCollision state
        where
            wallCollisionType = 
                case isCollideWalls state of
                    Nothing -> 0
                    Just Top -> 1
                    Just Wall -> 2
                    Just Bottom -> 3

applyPosition :: GameState -> GameState 
applyPosition state@GameState{..} = state{ballPosition = newPosition}
    where 
        newX = fst ballPosition  + ballSpeed * fst ballDirection
        newY = snd ballPosition  + ballSpeed * snd ballDirection
        newPosition = (newX, newY)

changeBallPosition :: GameState -> GameState 
changeBallPosition state@GameState{..} = applyPosition newState
    --  Position = Position + Speed * Direction;
    where
        newState = resolveCollide state