{-# LANGUAGE RecordWildCards #-}
module Main where

import           Miso

import           Model

main :: IO ()
main = startApp App {..}
    where
        initialAction = undefined
        model = initialModel
        update = undefined
        view = undefined
        subs = []
        events = defaultEvents
        mountPoint = Nothing
