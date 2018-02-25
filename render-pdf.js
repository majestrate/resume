#!/usr/bin/env phantomjs
const system = require('system');
const outfile = system.args[2];
const url = system.args[3];

const options = {
  html: url
};

var webPage = require('webpage');
var page = webPage.create();

page.viewportSize = { width: 1920, height: 1080 };
page.open(url, function start(status) {
  page.render(outfile, {format: 'pdf'});
  phantom.exit();
});
