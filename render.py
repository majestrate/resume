import jinja2
import markdown
import sys

def main(infname, outfname):
    env = jinja2.Environment(loader=jinja2.FileSystemLoader('.'))
    t = env.get_template(infname)
    if outfname.endswith('.html'):
        with open(outfname, 'w') as w:
            parts = dict()
            for f in ('header', 'body', 'about', 'footer'):
                with open('{}.md'.format(f)) as r:
                    parts[f] = markdown.markdown(r.read(), output_format='html5')
            w.write(t.render(**parts))
    elif outfname.endswith('.md'):
        with open(outfname, 'w') as w:
            w.write(t.render())
                
if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
