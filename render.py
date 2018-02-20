import jinja2
import markdown

def main():
    env = jinja2.Environment(loader=jinja2.FileSystemLoader("templates"))
    t = env.get_template('resume.jinja2')
    with open('cv.html', 'w') as w:
        parts = dict()
        for f in ('header', 'body', 'about', 'footer'):
            with open('{}.md'.format(f)) as r:
                parts[f] = markdown.markdown(r.read(), output_format='html5')
        w.write(t.render(**parts))
                
if __name__ == "__main__":
    main()
