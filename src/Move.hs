module Move where

import Structures

-- Обработка движения шара в рамках одного кадра
updateBallPosition :: GameState -> GameState
updateBallPosition x = x

-- Первое возвращаемое значение - есть ли столкновение
-- Второе возвращаемое значение - столкновение с каким объектом
isCollide :: GameState -> (Bool, CollideObject) 
isCollide _ = (False, NotCollide)

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