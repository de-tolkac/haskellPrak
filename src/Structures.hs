module Structures where

import Graphics.Gloss.Interface.Pure.Game


data Direction = Left | Right deriving Enum

data CollideObject = Platform | Wall | Top | Bottom | BrickHit  deriving Enum 

data ColorConfig = ColorConfig
    {   brickColor :: Color
    ,   ballColor :: Color
    ,   platformColor :: Color
    }

data Brick = Brick 
    {
        position :: Point
    ,   hp       :: Int
    }

data KeyType = LeftArrow | RightArrow | None deriving Eq 

-- Текущее состояние
data GameState = GameState
    {    colors           :: ColorConfig
    ,    score            :: Int
    ,    ballPosition     :: Point
    ,    ballDirection    :: Point
    ,    platformPosition :: Point
    ,    bricks           :: [Brick]
    ,    pause            :: Bool
    ,    gameOver         :: Bool
    ,    gameStarted      :: Bool
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