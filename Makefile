all: setup render

setup:
	pyvenv v
	v/bin/pip install -r requirements.txt

render:
	v/bin/python render.py

clean:
	rm -fr v *.html
