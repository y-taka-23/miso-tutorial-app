{-# LANGUAGE RecordWildCards #-}
module Main where

import           Miso

import           Action
import           Model
import           Update
import           View

main :: IO ()
main = do
    uri <- getCurrentURI
    startApp App { model = initialModel uri, ..}
    where
        initialAction = initAction
        update = updateModel
        view = viewModel
        subs = [ uriSub HandleURI ]
        events = defaultEvents
        mountPoint = Nothing
