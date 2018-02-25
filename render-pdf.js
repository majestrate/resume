#!/usr/bin/env node
var markdownpdf = require("markdown-pdf");

var options = {
    remarkable: {
        html: true,
        breaks: true,
        plugins: [ require('remarkable-classy') ],
		syntax: [ 'footnote', 'sup', 'sub' ]
    }
};


const outfile = process.argv[2];
const infile = process.argv[3];

markdownpdf(options)
  .from(infile)
  .to(outfile);
