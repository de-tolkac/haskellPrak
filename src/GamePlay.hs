{-# LANGUAGE RecordWildCards #-}
module GamePlay where

import Structures

gameOverFunc  :: GameState -> GameState
gameOverFunc  state@GameState{..} = state{gameOver = True}
