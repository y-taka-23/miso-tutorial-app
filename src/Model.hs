module Model where

import           Miso

data Model = Model
    { players    :: Either String [Player]
    , currentURI :: URI
    } deriving (Eq, Show)

instance HasURI Model where
    lensURI = makeLens getter setter
        where
            getter m     = currentURI m
            setter m uri = m { currentURI = uri }

initialModel :: URI -> Model
initialModel uri = Model
    { players = Left "Loading..."
    , currentURI = uri
    }

type PlayerId = String

data Player = Player
    { ident :: PlayerId
    , name  :: String
    , level :: Int
    } deriving (Eq, Show)
