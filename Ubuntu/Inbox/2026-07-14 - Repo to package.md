---
created: 2026-06-09
tags:
source:
aliases:
---
You are an expert Python packaging engineer.

Convert this existing Python repo into a clean internal Python package using modern `pyproject.toml` packaging and `uv`.

Goals:

1. Use a `src/` layout.
    
2. Keep behavior unchanged.
    
3. Preserve existing CLI/app entry behavior.
    
4. Move reusable code into `src/<package_name>/`.
    
5. Add a minimal `pyproject.toml`.
    
6. Add correct runtime dependencies to `[project.dependencies]`.
    
7. Add dev dependencies such as `pytest` and `ruff` under dependency groups if appropriate.
    
8. Add `__init__.py` with a small public API only where it makes sense.
    
9. Fix imports so the package can be imported from another project.
    
10. Add or update tests for at least the highest-risk import/module behavior.
    
11. Show how another project can install this package using `uv add --editable ../<repo>`.
    
12. Output the result as a unified Git diff only.
    

Use this target structure:

```text
<repo>/
├── pyproject.toml
├── README.md
├── src/
│   └── <package_name>/
│       ├── __init__.py
│       └── ...
└── tests/
    └── ...
```

Use this build backend unless there is a clear reason not to:

```toml
[build-system]
requires = ["hatchling >= 1.26"]
build-backend = "hatchling.build"
```

For command-line entry points, use:

```toml
[project.scripts]
<command-name> = "<package_name>.<module>:main"
```

Important constraints:

- Do not rewrite unrelated logic.
    
- Do not introduce a private package index.
    
- Do not publish to PyPI.
    
- Do not add unnecessary abstractions.
    
- Prefer simple, readable imports.
    
- Keep the first packaging pass minimal and robust.
    

After the diff, include these exact verification commands:

```bash
uv sync
uv run python -c "import <package_name>; print(<package_name>)"
uv run pytest
```

Also include this consuming-project example:

```bash
cd ../some_other_project
uv add --editable ../<repo>
uv run python -c "import <package_name>; print('import ok')"
```