module Update where

import           Miso

import           Action
import           Effect
import           Model

updateModel :: Action -> Model -> Effect Action Model
updateModel FetchPlayers m = m <# do
    SetPlayers <$> fetchPlayers
updateModel (SetPlayers ePs) m = noEff m { players = ePs }
updateModel (ChangeURI uri) m = m <# do
    pushURI uri >> pure NoOp
updateModel (HandleURI uri) m = noEff m { currentURI = uri }
updateModel (SavePlayer p) m = m <# do
    SetPlayer <$> savePlayer p
updateModel (SetPlayer eP) m = noEff $ updatePlayer eP m
updateModel NoOp m = noEff m

updatePlayer :: Either String Player -> Model -> Model
updatePlayer eP m = case (eP, players m) of
    (Right p, Left _)   -> m
    (Right p, Right ps) -> m { players = Right $ map (replace p) ps }
    (Left err, _)       -> m { players = Left err }

-- Todo: Data.Map is better than List?
replace :: Player -> Player -> Player
replace p1 p2 = if ident p1 == ident p2 then p1 else p2
