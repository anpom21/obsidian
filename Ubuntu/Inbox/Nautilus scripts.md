---
created: 2026-06-18
tags:
source:
aliases:
---
Nautilus scripts are executable files placed in:

```
~/.local/share/nautilus/scripts/
```

Create the directory if needed:

```
mkdir -p ~/.local/share/nautilus/scripts
```

Any executable script in that folder appears in Nautilus under:

```
Right click → Scripts
```

Example Python script:

```
nano ~/.local/share/nautilus/scripts/MyPythonActionchmod +x ~/.local/share/nautilus/scripts/MyPythonActionnautilus -q
```

Script contents:

```
#!/usr/bin/env python3import sysfrom pathlib import Pathselected_paths = [Path(arg) for arg in sys.argv[1:]]for path in selected_paths:    print(path)
```

To handle selected files/folders more robustly, use both argv and Nautilus environment variables:

```
#!/usr/bin/env python3import osimport sysfrom pathlib import Pathdef get_selected_paths():    if len(sys.argv) > 1:        return [Path(arg) for arg in sys.argv[1:]]    raw = os.environ.get("NAUTILUS_SCRIPT_SELECTED_FILE_PATHS", "")    return [Path(line) for line in raw.splitlines() if line.strip()]paths = get_selected_paths()for path in paths:    print(f"Selected: {path}")
```

Useful Nautilus environment variables:

```
NAUTILUS_SCRIPT_SELECTED_FILE_PATHS   # newline-separated selected local pathsNAUTILUS_SCRIPT_SELECTED_URIS         # newline-separated selected URIsNAUTILUS_SCRIPT_CURRENT_URI           # current folder URI, when availableNAUTILUS_SCRIPT_WINDOW_GEOMETRY       # Nautilus window geometry
```

Multiple arguments are passed by selecting multiple files/folders before running the script. In Python, they appear as:

```
sys.argv[1:]
```

In Bash:

```
for path in "$@"; do    echo "$path"done
```

Scripts can be organized into submenus by using folders:

```
~/.local/share/nautilus/scripts/├── Images/│   ├── Resize│   └── Convert to JPG├── PDFs/│   ├── Compress│   └── Merge└── Open Terminal Here
```

For user prompts, call GUI dialog tools from the script. The most common is `zenity`.

Install:

```
sudo apt install zenity
```