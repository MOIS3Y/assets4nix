import os
import json
from settings import BASE16_DIR, TEMPLATES_DIR, DST_DIR


class Avizo(object):
    def __init__(self):
        self.matcher_color = "#000000"
        self.base16_list = self._gen_filename_list(BASE16_DIR)
        self.template_list = self._gen_filename_list(TEMPLATES_DIR)
        self.avizo_dst = DST_DIR

    def _gen_filename_list(self, dir):
        filename_list = []
        for p in dir.iterdir():
            if p.is_file():
                filename_list.append(p.stem)
        return filename_list

    def _read_file(self, file, is_json=False):
        with open(file, mode="r") as f:
            content = json.loads(f.read()) if is_json else f.read()
            return content

    def _write_file(self, file, content):
        with open(file, mode="w") as f:
            f.write(content)

    def recolor(self, new_color):
        for scheme_name in self.base16_list:
            for template_name in self.template_list:
                scheme = self._read_file(
                    file=(BASE16_DIR / f"{scheme_name}.json"),
                    is_json=True
                )
                template = self._read_file(
                    file=(TEMPLATES_DIR / f"{template_name}.svg"),
                    is_json=False
                )

                hex_color = scheme[new_color]
                template = template.replace(self.matcher_color, hex_color, -1)

                scheme_dir = self.avizo_dst / scheme_name
                scheme_dir.mkdir(parents=True, exist_ok=True)

                new_svg = scheme_dir / f"{template_name}.svg"
                self._write_file(file=new_svg, content=template)
                result = new_svg.with_suffix('')
                os.system(
                    f"inkscape {new_svg} -o {result.with_suffix('.png')}"
                )
                new_svg.unlink()
