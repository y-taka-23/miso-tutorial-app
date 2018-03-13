{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}
module Routing where

import           Data.Proxy
import           Miso
import           Servant.API
import           Servant.Utils.Links

import           Action
import           Model

type Route =
         TopRoute
    :<|> ListRoute
    :<|> EditRoute

type TopRoute = View Action

type ListRoute = "players" :> View Action

type EditRoute = "players" :> Capture "ident" PlayerId :> View Action

-- Todo: this action jumps to '/players/players'...
goList :: Action
goList =
    ChangeURI $ safeLink (Proxy :: Proxy Route) (Proxy :: Proxy ListRoute)

goEdit :: PlayerId -> Action
goEdit i =
    ChangeURI $ safeLink (Proxy :: Proxy Route) (Proxy :: Proxy EditRoute) i
