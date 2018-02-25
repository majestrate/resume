
V = v
TMPL_HTML = resume.html.jinja2
TMPL_MD = resume.md.jinja2
BUILD = dist
MD = $(BUILD)/resume.md
HTML = $(BUILD)/cv.html
PDF = $(BUILD)/résumé.pdf
PY = $(V)/bin/python
PIP = $(V)/bin/pip
MDPDF = markdown-pdf
NPM = node_modules

all: assemble

assemble: $(HTML) $(PDF)

$(BUILD):
	mkdir -p $(BUILD)

$(V):
	python3 -m venv $(V)
	$(PIP) install -r requirements.txt

$(MD): $(V) $(BUILD)
	$(PY) render.py $(TMPL_MD) $(MD)

pdf: $(PDF)

$(NPM):
	npm install

$(PDF): $(MD) $(NPM)
	node render-pdf.js $(PDF) $(MD)

$(HTML): $(V) $(BUILD)
	$(PY) render.py $(TMPL_HTML) $(HTML)

clean:
	rm -rf $(BUILD)

distclean: clean
	rm -rf $(V) $(NPM)

upload: $(HTML) $(PDF)
	scp $(HTML) $(PDF) root@i2p.rocks:/var/www/html
