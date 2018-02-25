#!/usr/bin/env node
const pdf = require("phantom-html2pdf");
const fs = require("fs");

const outfile = process.argv[2];
const infile = process.argv[3];

const options = {
  html: infile
};

pdf.convert(options, function(err, result) {
  if (err) throw err;
  result.toFile(outfile, function() {});
});
