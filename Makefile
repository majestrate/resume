all: render

setup:
	pyvenv v
	v/bin/pip install -r requirements.txt

render: setup
	v/bin/python render.py

clean:
	rm -f *.html
