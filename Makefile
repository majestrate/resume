BUILD = $(PWD)/build
HTML = $(BUILD)/cv.html
PDF = $(BUILD)/cv.pdf
V = $(BUILD)/v
PY = $(V)/bin/python
PIP = $(V)/bin/pip
NODE = npm exec node

all: compile

compile: $(HTML) $(PDF)

$(BUILD):
	mkdir -p $(BUILD)

$(V) $(PIP) node_modules:
	asdf install
	python3 -m venv $(V)
	$(PIP) install --upgrade pip
	$(PIP) install -r $(PWD)/requirements.txt
	npm install

pdf: $(PDF)


$(PDF): node_modules $(HTML)
	$(NODE) $(PWD)/render-pdf.js $(HTML) $(PDF)

$(HTML): $(V)
	$(PY) $(PWD)/render.py $(HTML)

clean:
	rm -rf $(HTML) $(PDF)

distclean: clean
	rm -rf $(BUILD) $(PWD)/node_modules


upload: compile
	rsync --progress $(BUILD)/cv.* root@blog:/var/www/html/
