{-# LANGUAGE OverloadedStrings #-}
module Effect where

import qualified Codec.Binary.UTF8.String      as U
import           Data.Aeson
import qualified Data.ByteString.Lazy          as B
import qualified Data.JSString                 as J
import           JavaScript.Web.XMLHttpRequest

import           Model

fetchPlayers :: IO (Either String [Player])
fetchPlayers = do
    Just json <- contents <$> xhrByteString req
    pure $ eitherDecodeStrict json
    where
        req = Request
            { reqMethod = GET
            , reqURI = "http://localhost:4000/api/players"
            , reqLogin = Nothing
            , reqHeaders = []
            , reqWithCredentials = False
            , reqData = NoData
            }

savePlayer :: Player-> IO (Either String Player)
savePlayer p = do
    -- Todo: handle server-side errors here
    _ <- xhrByteString req
    return $ Right p
    where
        req = Request
            { reqMethod = PUT
            , reqURI = J.pack $ "http://localhost:4000/api/players/" ++ ident p
            , reqLogin = Nothing
            , reqHeaders = [("Content-type", "application/json")]
            , reqWithCredentials = False
            -- Todo: better handling of JSON data
            , reqData = StringData . J.pack . U.decode . B.unpack . encode $ p
            }
