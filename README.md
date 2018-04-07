An Example SPA in Miso
=======================

![screenshot](screenshot.png)

An example GHCJS + Miso single page application.

This project is ported from [Elm implementation](https://github.com/sporto/elm-tutorial-app). Miso framework aims to provide "The Elm Architecture" for GHCJS, thus its architecture looks very close to the original Elm application. Neverthelss, the Miso implementation has several differences, e.g.

* [Path-based routing by Servant API](./src/Routing.hs)
* [Accessing outside world in IO monads](./src/Effect.hs)

Running the Application
-----------------------

To integrate with webpack, this project depends
`ghcjs-requires` and `ghcjs-loader` modules in `ghcjs-commonjs` repository,
which is not published in npm.
So you have to prefetch them to your local machine.

```console
git clone https://github.com/beijaflor-io/ghcjs-commonjs.git
git clone https://github.com/y-taka-23/miso-tutorial-app.git
cd miso-tutorial-app
npm install
stack build
npm run start
```

After a while, access [http://localhost:3000](http://localhost:3000),
and you can see a list of players.

References
----------

* [GHCJS](https://github.com/ghcjs/ghcjs)
* [Miso Framework](https://haskell-miso.org/)
* [Elm Tutorial](https://www.gitbook.com/book/sporto/elm-tutorial/details)
