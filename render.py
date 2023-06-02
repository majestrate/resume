import jinja2
import markdown
import sys
import glob


outfname = sys.argv[1]

# set up jinja2 templates
env = jinja2.Environment(loader=jinja2.FileSystemLoader("."))
html_template = env.get_template("resume.html.jinja2")

# render markdown fragments to html
parts = dict()
for part_file in glob.glob("*.md"):
    with open(part_file) as f:
        part_name = part_file.split(".")[0]
        parts[part_name] = markdown.markdown(f.read(), output_format="html5")

# render template with final html document containing rendered markdown
with open(outfname, "w") as w:
    w.write(html_template.render(**parts))
