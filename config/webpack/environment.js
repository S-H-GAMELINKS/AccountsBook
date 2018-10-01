const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const webpack = require('webpack')

environment.loaders.append('vue', vue)

environment.plugins.set(
    `Provide`,
    new webpack.ProvidePlugin({
        Jquery: `jquery/dist/jquery`,
        Popper: `popper.js/dist/popper`
    })
)

module.exports = environment
