#!/usr/bin/env node
const pdf = require("html-pdf");
const fs = require("fs");

const outfile = process.argv[2];
const infile = process.argv[3];

const html = fs.readFileSync(infile, 'utf-8');

pdf.create(html).toStream(function(err, stream){
  if(err) throw err;
  stream.pipe(fs.createWriteStream(outfile));
});
