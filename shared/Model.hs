{-# LANGUAGE OverloadedStrings #-}
module Model where

import           Data.Aeson
import           Miso
import           Network.URI

data Model = Model
    { players    :: Either String [Player]
    , currentURI :: URI
    } deriving (Eq, Show)

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

instance FromJSON Player where
    parseJSON = withObject "Player" $ \v -> Player
        <$> v .: "id"
        <*> v .: "name"
        <*> v .: "level"

instance ToJSON Player where
    toJSON (Player ident name level) = object
        [ "id"    .= ident
        , "name"  .= name
        , "level" .= level
        ]
