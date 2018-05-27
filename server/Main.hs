module Main where

import           Control.Concurrent.STM
import           Network.Wai.Handler.Warp
import           Network.Wai.Logger

import           Server

main :: IO ()
main = do
    initialDB <- newTVarIO initialPlayers
    putStrLn "Listening on port 4000..."
    withStdoutLogger $ \logger -> do
        let settings = setPort 4000 $ setLogger logger defaultSettings
        runSettings settings (app initialDB)
