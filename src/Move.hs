module Move where

import Structures

-- Обработка движения шара в рамках одного кадра
updateBallPosition :: GameState -> GameState
updateBallPosition x = x

-- 
isCollide :: GameState -> Maybe CollideObject  
isCollide _ = Just BrickHit

-- Столкновение с платформой
hitPlatform :: GameState -> GameState 
hitPlatform x = x

-- Обработка удара по цели. Вычитаем ХП (или уничтожаем)
hitBrick :: GameState -> GameState 
hitBrick x = x

-- Обработка столкновения со стеной
hitWall :: GameState  -> GameState 
hitWall x = x

-- Движение платформы
movePlatform :: GameState  -> Direction -> GameState 
movePlatform x y = x