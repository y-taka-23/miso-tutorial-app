{-# LANGUAGE OverloadedStrings #-}
module View where

import           Action
import           Model
import           Player.Edit
import           Player.List
import           Routing

import           Data.List
import           Data.Proxy
import           Miso
import           Miso.String (ms)
import           Servant.API

viewModel :: Model -> View Action
viewModel m = div_ [] [ page m ]

page :: Model -> View Action
page m = view
    where
        view = either (const notFoundPage) id result
        result = runRoute (Proxy :: Proxy Route) handlers m
        handlers = topPage :<|> listPage :<|> editPage

topPage :: Model -> View Action
topPage = listPage

listPage :: Model -> View Action
listPage m = viewPlayers $ players m

editPage :: PlayerId -> Model -> View Action
editPage query m = case players m of
    Right ps -> case find (\p -> ident p == query) ps of
        Just p -> viewPlayer p
        Nothing -> notFoundPage
    Left err ->  errorPage err

notFoundPage :: View action
notFoundPage = errorPage "Not found"

errorPage :: String -> View action
errorPage err = div_ []
    [ div_ [ class_ "clearfix mb2 white bg-black p1" ] []
    , div_ [ class_ "p2" ] [ text . ms $ err ]
    ]
