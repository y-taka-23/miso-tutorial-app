require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

require('./index.html');

const Main = require('../src/Main.hs');

Main(({wrapped}) => {
    wrapped.main();
});
