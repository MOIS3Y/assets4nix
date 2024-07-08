import pathlib

# Project dir:
ROOT_DIR = pathlib.Path(__file__).resolve().parent.parent.parent

# Top level:
BASE16_DIR = ROOT_DIR / "devtools" / "base16"

SELF_DIR = ROOT_DIR / "devtools" / "avizo"

TEMPLATES_DIR = SELF_DIR / "templates"

DST_DIR = ROOT_DIR / "share" / "icons" / "avizo"
