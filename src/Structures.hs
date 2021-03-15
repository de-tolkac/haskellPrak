module Structures where

import Graphics.Gloss.Interface.Pure.Game

type Left = String
type Right = String 

data Direction = Left | Right deriving Enum


type Platform = Int 
type Wall = Int
type Bottom = Int 
type BrickHit = Int 
type NotCollide = Int 

data CollideObject = Platform | Wall | Bottom | BrickHit | NotCollide deriving Enum 

data ColorConfig = ColorConfig
    {   color1 :: Color
    ,   color2 :: Color
    }

data Brick = Brick 
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
    ,    bricks           :: [Brick]
    ,    pause            :: Bool
    ,    gameOver         :: Bool
    }
