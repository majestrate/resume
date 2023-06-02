
const puppeteer = require('puppeteer');

// args start at offset 2 because we run this with: npm exec node
const in_path = process.argv[2];
const out_path = process.argv[3];

(async () => {
    const browser = await puppeteer.launch({headless: "new"});
    const page = await browser.newPage();
    await page.goto(`file://${in_path}`, {
    });
    await page.pdf({
        path: out_path,
        format: 'letter',
    });
    await browser.close();
})();
