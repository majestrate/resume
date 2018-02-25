#!/usr/bin/env phantomjs
const system = require('system');
const outfile = system.args[1];
const url = system.args[2];

var webPage = require('webpage');
var page = webPage.create();

page.viewportSize = { width: 1920, height: 1080 };
page.open(url, function (status) {
  page.render(outfile);
  phantom.exit();
});
