{-# LANGUAGE OverloadedStrings #-}
module Html where

import qualified Lucid      as L
import qualified Lucid.Base as L

newtype HtmlPage a = HtmlPage a
    deriving (Eq, Show)

instance (L.ToHtml a) => L.ToHtml (HtmlPage a) where
    toHtmlRaw = L.toHtml
    toHtml (HtmlPage body) =
        L.doctypehtml_ $ do
            L.head_ $ do
                L.title_ "Miso SPA Example"
                L.meta_ [L.charset_ "utf-8"]
                L.link_
                    [ L.makeAttribute "href"
                        "https://unpkg.com/ace-css/css/ace.min.css"
                    , L.makeAttribute "rel" "stylesheet"
                    ]
                L.link_
                    [ L.makeAttribute "href"
                        "https://use.fontawesome.com/releases/v5.0.13/css/all.css"
                    , L.makeAttribute "rel" "stylesheet"
                    ]
                L.link_ []
                L.with (L.script_ mempty)
                    [ L.makeAttribute "src" "/static/all.js"
                    , L.makeAttribute "async" mempty
                    , L.makeAttribute "defer" mempty
                    ]
            L.body_ (L.toHtml body)
