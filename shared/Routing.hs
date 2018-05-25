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

listLink :: URI
listLink = safeLink (Proxy :: Proxy Route) (Proxy :: Proxy ListRoute)

editLink :: PlayerId -> URI
editLink i = safeLink (Proxy :: Proxy Route) (Proxy :: Proxy EditRoute) i
