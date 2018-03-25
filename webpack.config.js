const path = require('path');

module.exports = {
  entry: './static/index.js',
  output: {
    filename: 'app.js',
    path: path.resolve(__dirname, 'dist')
  },
  module: {
    rules: [
        {
            test: /\.(css|scss)$/,
            use: [
                'style-loader',
                'css-loader'
            ]
        },
        {
            test: /\.hs$/,
            loader: 'ghcjs-loader'
        },
        {
            test: /\.html$/,
            loader: 'file-loader?name=[name].[ext]'
        },
        {
            test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
            loader: 'url-loader?limit=10000&mimetype=application/font-woff',
        },
        {
            test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
            loader: 'file-loader',
        }
    ]
  },
  devServer: {
    contentBase: path.resolve(__dirname, 'dist'),
    inline: true,
    port: 3000,
    proxy: {
      '/': {
       target: 'http://localhost:3000',
       pathRewrite: {'^/.*': ''}
      }
    },
    stats: { colors: true }
  }
};
