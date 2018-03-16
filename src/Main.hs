{-# LANGUAGE RecordWildCards #-}
module Main where

import           Miso

import           Action
import           Model
import           Update

main :: IO ()
main = startApp App {..}
    where
        initialAction = initAction
        model = initialModel
        update = updateModel
        view = undefined
        subs = []
        events = defaultEvents
        mountPoint = Nothing
