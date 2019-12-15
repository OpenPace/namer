// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import '../css/app.scss';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in 'webpack.config.js'.
//
// Import dependencies
//
import 'phoenix_html';
import 'bootstrap';

// Load fonts async
import WebFont from 'webfontloader';

WebFont.load({
  google: {
    families: ['Open Sans'],
  },
});
