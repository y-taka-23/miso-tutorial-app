{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Api where

import           Miso
import           Servant

import           Action
import           Html
import           Model
import           Routing

type Api = JsonApi :<|> IsomorphicApi :<|> StaticApi :<|> NotFoundApi

type JsonApi =
         "api" :> "players" :> Get '[JSON] [Player]
    :<|> "api" :> "players" :> Capture "id" PlayerId
            :> ReqBody '[JSON] Player :> Put '[JSON] NoContent

type IsomorphicApi = ToServerRoutes Route HtmlPage Action

type StaticApi = "static" :> Raw

type NotFoundApi = Raw

api :: Proxy Api
api = Proxy
