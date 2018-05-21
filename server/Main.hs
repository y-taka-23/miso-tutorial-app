{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Main where

import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant

import           Model

type JsonApi =
         "players" :> Get '[JSON] [Player]
    :<|> "palyers" :> Capture "id" PlayerId
            :> ReqBody '[JSON] Player :> Put '[JSON] NoContent

jsonApi :: Proxy JsonApi
jsonApi = Proxy

handlers :: Server JsonApi
handlers = getPlayers :<|> putPlayerById

samplePlayers :: [Player]
samplePlayers = [
      Player "1" "Sally"  2
    , Player "2" "Lance"  1
    , Player "3" "Aki"    3
    , Player "4" "Maria"  4
    , Player "5" "Julian" 1
    , Player "6" "Jaime"  1
    ]

getPlayers :: Handler [Player]
getPlayers = return samplePlayers

putPlayerById :: PlayerId -> Player -> Handler NoContent
putPlayerById _ _ = return NoContent

app :: Application
app = serve jsonApi handlers

main :: IO ()
main = run 4000 app
