var webpack = require('webpack');
var path = require('path');
var fs = require('fs');

module.exports = {
  entry: path.resolve(__dirname, 'app/scripts', 'app.js'),
  devtool: "source-map",
  output: {
    filename: 'app.js',
    path: path.resolve('./app/public'),
    publicPath: '/',
    libraryTarget: 'umd'
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        loader: 'babel',
        query: {stage: 0}
      }, {
        test: /\.scss$/,
        loader: "style!css!sass"
      }
    ]
  },

  // postcss: [
  //     nested,
  //     grid
  //   ],

  resolve: {
    modulesDirectories: ['node_modules', 'app/']
  },

  plugins: [
    // new ExtractTextPlugin('style.css', { allChunks: true }),
  ]
};
