{-# LANGUAGE RecordWildCards #-}
module Main where

import           Miso

import           Action
import           Model
import           Update

main :: IO ()
main = do
    uri <- getCurrentURI
    startApp App { model = initialModel uri, ..}
    where
        initialAction = initAction
        update = updateModel
        view = undefined
        subs = []
        events = defaultEvents
        mountPoint = Nothing
