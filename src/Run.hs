{-# LANGUAGE RecordWildCards #-}
module Run where

import Graphics.Gloss.Interface.IO.Game
 
import System.Random
import System.Exit
import Structures
import Constants
import GamePlay

import System.IO

import BricksLib

import PlatformLib

import BallLib 

import Text.Printf

-- Начальная инициализация 
initState :: GameState 
initState = GameState (ColorConfig getBrickColor getPlatformColor getBallColor) 0 (0, -280) (0.0, 1.0) (0, -300) initBricks False False False False False False

printN :: Float -> Float -> IO Float
printN x y = do
                hSetBuffering stdout NoBuffering
                putStr $ show x
                putStr ", "
                putStr $ show y
                putStrLn " "
                return 1
-- Отрисовка

eA :: GameState -> IO Picture
eA state@GameState{..} = do
                            -- printN (fst ballPosition) (snd ballPosition)
                            drawApp state
drawApp :: GameState -> IO Picture
drawApp (GameState (ColorConfig c1 c2 c3) n (x, y) (vx, vy) platformPosition bricks isPause isGameover isStarted isFinished leftKeyPressed rightKeyPressed) = return (Pictures [score, drawBricks bricks, drawPlatform platformPosition, ball, frame, gameOverMsg, gameSuccessMsg, pauseMsg, escMsg])
    where
        scoreNum = Text (show n)
        scoreShift = 600
        gameOverText = Text (if isGameover then "Game Over!" else "")
        gameOverMsg = Translate (-360) 0 $ Color red gameOverText
        gameSuccessText = Text (if n >= 24 then "Good Job!" else "")
        gameSuccessMsg = Translate (-360) 0 $ Color green gameSuccessText
        pauseText = Text "<p> - for pause"
        pauseMsg = Scale 0.25 0.25 $ Translate (-3600) 200 $ Color yellow pauseText
        escText = Text "<ESC> - for exit"
        escMsg = Scale 0.25 0.25 $ Translate (-3600) 0 $ Color yellow escText
        score = Translate scoreShift 0 $ Color c2 scoreNum
        frame = Translate 0 0 $ Color yellow (rectangleWire 1000 1000)
        ball = Translate x y  $ Color red (circleSolid ballRadius)

-- Обрабатываем нажатия кнопок и другие события
handleEvent :: Event -> GameState -> IO GameState
handleEvent (EventKey (SpecialKey KeySpace) _ _ _) state = return state {gameStarted = True}
handleEvent (EventKey (SpecialKey KeyLeft) Down _ _) state = return state {leftKeyPressed = True}
handleEvent (EventKey (SpecialKey KeyRight) Down _ _) state = return state {rightKeyPressed = True}
handleEvent (EventKey (SpecialKey KeyLeft) Up _ _) state = return state {leftKeyPressed = False}
handleEvent (EventKey (SpecialKey KeyRight) Up _ _) state = return state {rightKeyPressed = False}
handleEvent (EventKey  (Char 'p') Down _ _) state@GameState{..} = return state {pause = not pause}
handleEvent (EventKey (SpecialKey KeyEsc ) _ _ _) state = do
                                                        exitSuccess
                                                        return state
handleEvent _ x = return x

-- Апдейт кадра
updateFrame :: Float -> GameState -> IO GameState
updateFrame t state@GameState{..}   | gameOver = return state
                                    | pause || gameFinished = return state
                                    | gameStarted = do
                                        let newState = changeBallPosition state
                                        if score >= 24 then
                                            return newState{gameFinished = True}
                                        else if leftKeyPressed
                                            then do
                                            return newState {platformPosition = changePlatformPosition platformPosition (-1)}
                                        else if rightKeyPressed  
                                            then do
                                                return newState {platformPosition = changePlatformPosition platformPosition 1}
                                        else return newState
                                    | otherwise = return state


-- Main Loop
run :: IO ()
run = do
    playIO FullScreen black 60 initState eA handleEvent updateFrame