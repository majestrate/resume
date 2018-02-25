var markdownpdf = require("markdown-pdf");

var options = {
    remarkable: {
        html: true,
        breaks: true,
        plugins: [ require('remarkable-classy') ],
		syntax: [ 'footnote', 'sup', 'sub' ]
    }
};

const infile = process.argv[1];
const outfile = process.argv[2];

markdownpdf(options)
  .from(infile)
  .to(outfile);
