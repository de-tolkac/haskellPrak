module Structures where

import Graphics.Gloss.Interface.Pure.Game


data Direction = Left | Right deriving Enum

data CollideObject = Platform | Wall | Top | Bottom | BrickHit  deriving Enum 

data Brick = Brick 
    {
        position :: Point
    ,   hp       :: Int
    }

-- Текущее состояние
data GameState = GameState
    {    
         score            :: Int
    ,    ballPosition     :: Point
    ,    ballDirection    :: Point
    ,    platformPosition :: Point
    ,    bricks           :: [Brick]
    ,    pause            :: Bool
    ,    gameOver         :: Bool
    ,    gameStarted      :: Bool
    ,    gameFinished     :: Bool
    ,    leftKeyPressed   :: Bool
    ,    rightKeyPressed  :: Bool
    }

data HitBrick = HitBrick
    {
        hit :: Bool
    ,   direction :: Point
    ,   brick :: Maybe Brick
    }

data CollideBricksReturn = CollideBricksReturn
    {
        newBricks :: [Brick]
    ,   state :: GameState
    }
