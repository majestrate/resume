all: render

v:
	python3 -m venv v
	v/bin/pip install -r requirements.txt

render: v
	v/bin/python render.py

clean:
	rm -f *.html

distclean: clean
	rm -rf v

upload: render
	scp cv.html root@i2p.rocks:/var/www/html
