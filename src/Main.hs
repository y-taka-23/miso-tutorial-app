{-# LANGUAGE RecordWildCards #-}
module Main where

import           Miso

main :: IO ()
main = startApp App {..}
    where
        initialAction = undefined
        model = undefined
        update = undefined
        view = undefined
        subs = []
        events = defaultEvents
        mountPoint = Nothing
