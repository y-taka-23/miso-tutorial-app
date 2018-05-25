{-# LANGUAGE OverloadedStrings #-}
module Player.List where

import           Miso
import           Miso.String (ms)

import           Action
import           Model
import           Routing

viewPlayers :: Either String [Player] -> View Action
viewPlayers ePs = div_ []
    [ nav
    , list ePs
    ]

nav :: View action
nav = div_
    [ class_ "clearfix mb2 white bg-black"]
    [ div_ [ class_ "left p2" ] [ text "Players" ] ]

list :: Either String [Player] -> View Action
list (Left msg) = div_ [ class_ "p2" ] [ text $ ms msg ]
list (Right ps) = div_
    [ class_ "p2" ]
    [ table_ []
        [ thead_ []
            [ tr_ []
                [ th_ [] [ text "Id" ]
                , th_ [] [ text "Name" ]
                , th_ [] [ text "Level" ]
                , th_ [] [ text "Actions" ]
                ]
            ]
        , tbody_ [] $ map playerRow ps
        ]
    ]

playerRow :: Player -> View Action
playerRow p = tr_ []
    [ th_ [] [ text . ms $ ident p]
    , th_ [] [ text . ms $ name p]
    , th_ [] [ text . ms . show $ level p]
    , th_ [] [ editBtn p ]
    ]

editBtn :: Player -> View Action
editBtn p = a_
    [ class_ "btn regular"
    , onClick $ ChangeURI $ editLink (ident p)
    ]
    [ i_ [ class_ "fa fa-pencil mr1" ] []
    , text "Edit"
    ]
