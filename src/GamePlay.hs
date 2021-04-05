{-# LANGUAGE RecordWildCards #-}
module GamePlay where

import Structures


gameOverFunc  :: GameState -> GameState
gameOverFunc  state@GameState{..} = state{gameOver = True}

updateScore :: GameState -> Int -> GameState 
updateScore x y = x

togglePause :: GameState -> GameState 
togglePause x = x