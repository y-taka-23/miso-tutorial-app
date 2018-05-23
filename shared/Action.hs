module Action where

import           Miso
import           Network.URI

import           Model

data Action
    = FetchPlayers
    | SetPlayers (Either String [Player])
    | HandleURI URI
    | ChangeURI URI
    | SavePlayer Player
    | SetPlayer (Either String Player)
    | NoOp

initAction :: Action
initAction = FetchPlayers
