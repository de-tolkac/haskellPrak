module Run where

import Graphics.Gloss.Interface.Pure.Game
import System.Random

import Structures
import Move
import Constants
import GamePlay

-- Начальная инициализация 
initState :: GameState 
initState = GameState (ColorConfig yellow green red) 5 (0, 0) (0, 0) [] False False

-- Отрисовка
drawApp :: GameState -> Picture
drawApp (GameState (ColorConfig c1 c2 c3) n ballPosition platformPosition bricks isPause isGameover) = Pictures [score]
    where
        scoreNum = Text (show n)
        scoreShift = 500
        score = Translate scoreShift 0 $ Color c2 scoreNum

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
