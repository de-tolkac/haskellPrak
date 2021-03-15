module Run where

import Graphics.Gloss.Interface.Pure.Game
import System.Random

import Structures

import Move

import Constants

import GamePlay

-- Отрисовка
drawApp :: GameState -> Picture
drawApp (GameState (ColorConfig c1 c2) n (0, 0) (0, 0) [] False False) = Pictures [score]
    where
        scoreNum = Text (show n)
        scoreShift = 500
        score = Translate (scoreShift) 0 $ Color c2 scoreNum

-- Обрабатываем нажатия кнопок и другие события
handleEvent :: Event -> GameState -> GameState
handleEvent _ x = x

-- Апдейт кадра
updateFrame :: Float -> GameState -> GameState
updateFrame _ x = x

-- Распарсиваем конфиг из файла
parseConfig :: String -> Maybe ColorConfig
parseConfig str = case map findColor (lines str) of
    [Just c1, Just c2] -> Just (ColorConfig c1 c2)
    _ -> Nothing
    where
        findColor :: String -> Maybe Color
        findColor s = lookup s colorMap
        colorMap = zip names colors
        colors = [red, green, blue, white]
        names = ["red", "green", "blue", "white"]

-- Main Loop
run :: IO ()
run = do
    str <- readFile configPath
    case parseConfig str of
        Nothing -> do
            putStrLn "Parse error"
            let initState = GameState (ColorConfig red green) 5 (0, 0) (0, 0) [] False False
            play FullScreen black 60 initState drawApp handleEvent updateFrame 
        Just cfg -> do
            let initState = GameState cfg 5 (0, 0) (0, 0) [] False False
            play FullScreen black 60 initState drawApp handleEvent updateFrame 
    where
        configPath = "config.txt"