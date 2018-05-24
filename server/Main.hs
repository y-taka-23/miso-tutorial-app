{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Main where

import qualified Lucid                    as L
import qualified Lucid.Base               as L
import           Miso
import           Network.HTTP.Types
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant

import           Action
import           Model
import           Routing
import           View

newtype HtmlPage a = HtmlPage a
    deriving (Eq, Show)

instance (L.ToHtml a) => L.ToHtml (HtmlPage a) where
    toHtmlRaw = L.toHtml
    toHtml (HtmlPage body) =
        L.doctypehtml_ $ do
            L.head_ $ do
                L.title_ "Miso SPA Example"
                L.meta_ [L.charset_ "utf-8"]
                L.with (L.script_ mempty)
                    [ L.makeAttribute "src" "/static/all.js"
                    , L.makeAttribute "async" mempty
                    , L.makeAttribute "defer" mempty
                    ]
            L.body_ (L.toHtml body)

type Api = JsonApi :<|> StaticApi :<|> NotFoundApi

type JsonApi =
         "players" :> Get '[JSON] [Player]
    :<|> "palyers" :> Capture "id" PlayerId
            :> ReqBody '[JSON] Player :> Put '[JSON] NoContent

type IsomorphicApi = ToServerRoutes Route HtmlPage Action

type StaticApi = "static" :> Raw

type NotFoundApi = Raw

api :: Proxy Api
api = Proxy

server :: Server Api
server = handlers :<|> staticFiles :<|> notFoundHtml

handlers :: Server JsonApi
handlers = getPlayers :<|> putPlayerById

staticFiles :: Server Raw
staticFiles = serveDirectory "static"

notFoundHtml :: Server Raw
notFoundHtml _ respond =
    respond $ responseLBS
        status404 [("Content-Type", "text/html")] $
        L.renderBS (L.toHtml notFoundPage)

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
app = serve api server

main :: IO ()
main = run 4000 app
