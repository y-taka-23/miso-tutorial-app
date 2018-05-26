module Main where

import           Miso

import           Action
import           Model
import           Update
import           View

main :: IO ()
main = do
    miso $ \uri -> App {
          initialAction = initAction
        , model = initialModel uri
        , update = updateModel
        , view = viewModel
        , subs = [ uriSub HandleURI ]
        , events = defaultEvents
        , mountPoint = Nothing
        }
