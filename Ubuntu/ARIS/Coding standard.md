---
created: 2026-06-09
tags:
  - ARIS
source:
aliases:
---

## [[Logging]]
Logging should be print central logging messages. Use the `aris-logger`  by default for logging (it uses logguru as the backbone).
**Install**: `uv add loguru `
Loguru should be used as so:
```python
import sys
from loguru import logger

logger.debug("Detailed debugging information")
logger.info("Application started")
logger.success("File uploaded successfully")
logger.warning("Configuration is missing")
logger.error("Could not connect to database")
logger.critical("Application cannot continue")
```

## Debugging
At every possible point of failure makes sure to prepare logging around that section, which should only be triggered when the `DEBUGGING` env variable is `1`. 
## Package manager
The project should use `uv` for managing packages. Add packages with `uv add`.