---
created: 2026-06-09
tags:
  - ARIS
source:
aliases:
---

## [[Logging]]
Logging should be print central logging messages. Use `loguru` by default for logging.
**Install**: `uv add loguru`
Loguru should be used as so:
```python
import sys
from loguru import logger


def setup_loguru():
	logger.remove()
	
	logger.add(
	    sys.stderr,
	    level="DEBUG",
	    colorize=True,
	    format=(
	        "<dim>{time:HH:mm:ss}</dim> | "
	        "<level>{level: <8}</level> | "
	        "{message}"
	    ),
	)
	
	logger.add(
	    "logs/{time}.log",
	    level="DEBUG",
	    format="{time} | {level} | {name}:{line} | {message}",
	)

logger.debug("Detailed debugging information")
logger.info("Application started")
logger.success("File uploaded successfully")
logger.warning("Configuration is missing")
logger.error("Could not connect to database")
logger.critical("Application cannot continue")
```


## Package manager
The project should use `uv` for managing packages. Add packages with `uv add`.