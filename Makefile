
V = v
TMPL_HTML = resume.html.jinja2
TMPL_MD = resume.md.jinja2
BUILD = build
MD = $(BUILD)/resume.md
HTML = $(BUILD)/cv.html
PDF = $(BUILD)/résumé.pdf
PY = $(V)/bin/python
PIP = $(V)/bin/pip
MDPDF = markdown-pdf


all: $(HTML) $(PDF)

$(BUILD):
	mkdir -p $(BUILD)

$(V):
	python3 -m venv $(V)
	$(PIP) install -r requirements.txt

$(MD): $(BUILD)
	$(PY) render.py $(TMPL_MD) $(MD)

pdf: $(PDF)

$(PDF): $(MD)
	rm -f $(PDF)
	$(MDPDF) --out $(PDF) $(MD)

$(HTML): $(V) $(BUILD)
	$(PY) render.py $(TMPL_HTML) $(HTML)

clean:
	rm -rf $(BUILD)

distclean: clean
	rm -rf $(V)

upload: $(HTML) $(PDF)
	scp $(HTML) $(PDF) root@i2p.rocks:/var/www/html
