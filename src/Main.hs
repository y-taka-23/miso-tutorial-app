{-# LANGUAGE RecordWildCards #-}
module Main where

import           Miso

import           Action
import           Model

main :: IO ()
main = startApp App {..}
    where
        initialAction = initAction
        model = initialModel
        update = undefined
        view = undefined
        subs = []
        events = defaultEvents
        mountPoint = Nothing
