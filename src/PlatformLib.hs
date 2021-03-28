module PlatformLib where

import Graphics.Gloss.Interface.Pure.Game

import Constants

drawPlatform :: Point -> Picture
drawPlatform (x, y) = Pictures [Color blue $ uncurry Translate (x, y) (uncurry rectangleSolid (platformWidth, platformHeight))]