---
created: 2026-06-09
tags:
  - ARIS
source:
aliases:
---



```python
import sys
from loguru import logger

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

logger.debug("Detailed debugging information")
logger.info("Application started")
logger.success("File uploaded successfully")
logger.warning("Configuration is missing")
logger.error("Could not connect to database")
logger.critical("Application cannot continue")
```