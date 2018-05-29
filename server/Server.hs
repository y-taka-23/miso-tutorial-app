{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Server where

import           Control.Concurrent.STM
import           Control.Monad.IO.Class
import qualified Data.Map               as M
import qualified Lucid                  as L
import           Miso
import           Network.HTTP.Types
import           Network.Wai
import           Servant

import           Action
import           Api
import           Html
import           Model
import           Routing
import           View

type PlayerDB = TVar (M.Map PlayerId Player)

initialPlayers :: M.Map PlayerId Player
initialPlayers = M.fromList [
      ("1", Player "1" "Sally"  2)
    , ("2", Player "2" "Lance"  1)
    , ("3", Player "3" "Aki"    3)
    , ("4", Player "4" "Maria"  4)
    , ("5", Player "5" "Julian" 1)
    , ("6", Player "6" "Jaime"  1)
    ]

server :: PlayerDB -> Server Api
server db = handlers db :<|> ssrViews :<|> staticFiles :<|> notFoundHtml

handlers :: PlayerDB -> Server JsonApi
handlers db = getPlayers db :<|> putPlayerById db

ssrViews :: Server IsomorphicApi
ssrViews = topView :<|> listView :<|> editView

topView :: Handler (HtmlPage (View Action))
topView = return $ HtmlPage . viewModel . initialModel $ listLink

listView :: Handler (HtmlPage (View Action))
listView = topView

editView :: PlayerId -> Handler (HtmlPage (View Action))
editView i = return $ HtmlPage . viewModel . initialModel $ editLink i

staticFiles :: Server Raw
staticFiles = serveDirectory "static"

notFoundHtml :: Server Raw
notFoundHtml _ respond =
    respond $ responseLBS
        status404 [("Content-Type", "text/html")] $
        L.renderBS $ L.toHtml (HtmlPage notFoundPage)

getPlayers :: PlayerDB -> Handler [Player]
getPlayers db = do
    ps <- liftIO $ readTVarIO db
    return $ M.elems ps

putPlayerById :: PlayerDB -> PlayerId -> Player -> Handler NoContent
putPlayerById db i p = do
    liftIO $ atomically $ modifyTVar db (M.insert i p)
    return NoContent

app :: PlayerDB -> Application
app db = serve api (server db)
