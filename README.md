An Example SPA in Miso
=======================

An example GHCJS + Miso single page application.

Todo: screenshots here

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

After a while, access `http://localhost:3000`,
and you can see a list of players.

References
----------

* [Miso Framework](https://github.com/dmjio/miso)
* [Elm Tutorial](https://www.gitbook.com/book/sporto/elm-tutorial/details)
