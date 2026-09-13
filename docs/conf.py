import sys
from pathlib import Path

sys.path.insert(0, str(Path("/app")))

extensions = [
    "sphinx.ext.autodoc",
]

html_theme = "furo"