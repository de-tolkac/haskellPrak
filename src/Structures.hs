module Structures where

import Graphics.Gloss.Interface.Pure.Game

type Left = String
type Right = String 

data Direction = Left | Right deriving Enum


type Platform = Int 
type Wall = Int
type Bottom = Int 
type Brick = Int 
type NotCollide = Int 

data CollideObject = Platform | Wall | Bottom | Brick | NotCollide deriving Enum 

data ColorConfig = ColorConfig
    {   color1 :: Color
    ,   color2 :: Color
    }

data Rect = Rect 
    {
        position :: Point
    ,   hp       :: Int
    }

-- Текущее состояние
data GameState = GameState
    {    colors           :: ColorConfig
    ,    score            :: Int
    ,    ballPosition     :: Point
    ,    platformPosition :: Point
    ,    bricks           :: [Rect]
    ,    pause            :: Bool
    ,    gameOver         :: Bool
    }
