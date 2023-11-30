import jinja2
import markdown
import sys
import glob
import os
import json

# this script has 2 passes
#
# pass 1:
# we generate markdown fragments from external structured data containing resume data.
# e.g. work history, experiencem thier attributes and their relations.
#
# pass 2:
# the generated markdown fragments are compiled into a single html document
# such that our html template handles the formatting style and placement.

outfname = sys.argv[1]

# set up jinja2 templates
env = jinja2.Environment(loader=jinja2.FileSystemLoader("templates"))

settings = {}

with open('info.json') as f:
    settings = json.load(f)

if settings['show_phone']:
    p = settings['phone'] 
    settings['phone_str'] = p[2:]
    for ch in '()-':
        p = p.replace(ch, '')
    settings['phone'] = p
else:
    settings['phone_str'] = ''
    settings['phone'] = ''
        
parts = dict()
for part_file in glob.glob("templates/*.jinja2"):
    with open(part_file) as f:
        part_file = part_file.split("/")[-1]
        part_name = part_file.split(".")[0]
        if part_file.endswith('.html.jinja2'):
            continue
        tmpl = env.get_template(f"{part_name}.md.jinja2")
        data = tmpl.render(**settings)
        parts[part_name] = markdown.markdown(data, output_format="html5")
        

html_template = env.get_template("out.html.jinja2")
# render template with final html document containing rendered markdown
with open(outfname, "w") as w:
    w.write(html_template.render(**parts))
