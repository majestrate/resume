
V = v
TMPL_HTML = resume.html.jinja2
BUILD = dist
HTML = $(BUILD)/cv.html
PDF = $(BUILD)/résumé.pdf
PY = $(V)/bin/python
PIP = $(V)/bin/pip
MDPDF = markdown-pdf
NPM = node_modules
NODE = $(NPM)/phantomjs/bin/phantomjs

all: assemble

assemble: $(HTML) $(PDF)

$(BUILD):
	mkdir -p $(BUILD)

$(V):
	python3 -m venv $(V)
	$(PIP) install -r requirements.txt

pdf: $(PDF)

$(NPM):
	npm install

$(PDF): upload-html $(NPM)
	$(NODE) render-pdf.js $(PDF) https://i2p.rocks/cv.html

$(HTML): $(V) $(BUILD)
	$(PY) render.py $(TMPL_HTML) $(HTML)

clean:
	rm -rf $(BUILD)

distclean: clean
	rm -rf $(V) $(NPM)

upload: upload-pdf upload-html

upload-html: $(HTML)
	scp $(HTML) root@i2p.rocks:/var/www/html

upload-pdf: $(PDF)
	scp $(PDF) root@i2p.rocks:/var/www/html
