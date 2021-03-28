module Run where

import Graphics.Gloss.Interface.Pure.Game
import System.Random

import Structures
import Move
import Constants
import GamePlay

import BricksLib

import PlatformLib

-- Начальная инициализация 
initState :: GameState 
initState = GameState (ColorConfig getBrickColor getPlatformColor getBallColor) 0 (0, 0) (0, -300) initBricks False False

-- Отрисовка
drawApp :: GameState -> Picture
drawApp (GameState (ColorConfig c1 c2 c3) n ballPosition platformPosition bricks isPause isGameover) = Pictures [score, drawBricks bricks, drawPlatform platformPosition, ball]
    where
        scoreNum = Text (show n)
        scoreShift = 600
        score = Translate scoreShift 0 $ Color c2 scoreNum
        ball = Translate 0 (-300 + ballRadius * 2)  $ Color red (circleSolid ballRadius)

-- Обрабатываем нажатия кнопок и другие события
handleEvent :: Event -> GameState -> GameState
handleEvent _ x = x

-- Апдейт кадра
updateFrame :: Float -> GameState -> GameState
updateFrame _ x = x

-- Main Loop
run :: IO ()
run = do
    play FullScreen black 60 initState drawApp handleEvent updateFrame