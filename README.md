An Example SPA in Miso
=======================

![screenshot](screenshot.png)

An example GHCJS + Miso single page application.

This project is ported from [Elm implementation](https://github.com/sporto/elm-tutorial-app). Miso framework aims to provide "The Elm Architecture" for GHCJS, thus its architecture looks very close to the original Elm application. Nevertheless, the Miso implementation has several differences, e.g.

* [Path-based routing by Servant API](./src/Routing.hs)
* [Accessing outside world in IO monads](./src/Effect.hs)

References
----------

* [GHCJS](https://github.com/ghcjs/ghcjs)
* [Miso Framework](https://haskell-miso.org/)
* [Elm Tutorial](https://www.gitbook.com/book/sporto/elm-tutorial/details)
