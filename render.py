import jinja2
import markdown

def renderFile(t, fname, w):
    """
    render a markdown file
    :param t: a jinja2 template
    :param fname: the filename of the markdown file
    :param w: a file object to write output to
    """
    with open(fname) as f:
        html = markdown.markdown(f.read(), output_format='html5')
        fullhtml = t.render(body=html)
        w.write(fullhtml)

def main():
    env = jinja2.Environment(loader=jinja2.FileSystemLoader("templates"))
    t = env.get_template('resume.jinja2')
    with open('cv.html', 'w') as w:
        parts = dict()
        for f in ('header', 'body', 'about'):
            with open('{}.md'.format(f)) as r:
                parts[f] = markdown.markdown(r.read(), output_format='html5')
        w.write(t.render(**parts))
                
if __name__ == "__main__":
    main()
