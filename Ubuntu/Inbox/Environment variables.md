---
created: 2026-06-09
tags:
  - ARIS
  - guide
  - reference
source:
aliases:
---
# Environment Variables – A Practical Guide

## What are environment variables?

Environment variables are **configuration values** that are provided to a program **from outside the code**.

Instead of writing:

```
SAVE_LOCATION = "/home/ap/Repositories/wade-system/images_backup"
```

you write:

```
import os

SAVE_LOCATION = os.getenv(
    "WADE_IMAGE_SAVE_LOCATION",
    "/workspace/images_backup"
)
```

This means:

> "Use the value of `WADE_IMAGE_SAVE_LOCATION` if someone has set it. Otherwise use `/workspace/images_backup`."

The code never changes—only the environment does.

---

# Why use them?

Imagine the same program running in three places.

### Your laptop

```
/home/ap/Repositories/wade-system/images_backup
```

### Docker

```
/workspace/images_backup
```

### Robot

```
/tmp/wade/images_backup
```

Without environment variables you'd have to modify the code for each environment.

With environment variables:

```
Laptop  --> WADE_IMAGE_SAVE_LOCATION=/home/ap/Repositories/...
Docker  --> WADE_IMAGE_SAVE_LOCATION=/workspace/images_backup
Robot   --> WADE_IMAGE_SAVE_LOCATION=/tmp/wade/images_backup
```

The Python code stays exactly the same.

---

# How they work

Every process on Linux has a collection of environment variables.

When you start a program

```
python app.py
```

Python inherits all environment variables from the shell.

Your program reads them with

```
import os

value = os.getenv("VARIABLE_NAME")
```

or with a default value

```
value = os.getenv(
    "VARIABLE_NAME",
    "default_value"
)
```

If the variable doesn't exist, the default is used.

---

# Where are environment variables set?

There are several common places.

## 1. For a single command

Only affects one command.

```
WADE_IMAGE_SAVE_LOCATION=/workspace/images_backup \
python app.py
```

---

## 2. For the current terminal

```
export WADE_IMAGE_SAVE_LOCATION=/workspace/images_backup
```

Every program started from that terminal inherits it.

Check it:

```
echo $WADE_IMAGE_SAVE_LOCATION
```

---

## 3. Docker (very common)

```
docker run \
    -e WADE_IMAGE_SAVE_LOCATION=/workspace/images_backup \
    my-image
```

or

```
environment:
  WADE_IMAGE_SAVE_LOCATION: /workspace/images_backup
```

---

## 4. Dockerfile

Provide a default inside the image.

```
ENV WADE_IMAGE_SAVE_LOCATION=/workspace/images_backup
```

This can still be overridden by `docker run -e`.

---

## 5. .env files (recommended for development)

Create

```
.env
```

Example:

```
WADE_IMAGE_SAVE_LOCATION=/home/ap/Repositories/wade-system/images_backup
OPENAI_API_KEY=...
```

Load it in Python:

```
from dotenv import load_dotenv

load_dotenv()
```

Now

```
os.getenv("WADE_IMAGE_SAVE_LOCATION")
```

works automatically.

Advantages:

- Different developers can have different settings.
- Configuration lives with the project.
- `.env` is usually ignored by Git.
- `.env.example` is committed so everyone knows which variables are needed.

Typical structure:

```
project/
│
├── .env.example
├── .env
├── src/
└── ...
```

---

## 6. ~/.bashrc

You _can_ put variables here:

```
export MY_VARIABLE=value
```

but this is usually **not recommended for project-specific settings**.

`.bashrc` is better suited for personal shell configuration like:

```
export PATH=...
export EDITOR=nvim
```

rather than

```
export WADE_IMAGE_SAVE_LOCATION=...
```

---

# Common uses

Environment variables are commonly used for

### File locations

```
DATA_DIRECTORY
CONFIG_DIRECTORY
IMAGE_SAVE_LOCATION
```

### API keys

```
OPENAI_API_KEY
AWS_SECRET_ACCESS_KEY
```

### URLs

```
DATABASE_URL
```

### Ports

```
PORT=5000
```

### Modes

```
DEBUG=true
ENVIRONMENT=production
```

---

# Best practice

Instead of writing

```
SAVE_LOCATION = "/home/ap/Repositories/wade-system/images_backup"
```

write

```
SAVE_LOCATION = os.getenv(
    "WADE_IMAGE_SAVE_LOCATION",
    "/workspace/images_backup"
)
```

or

```
from pathlib import Path
import os

SAVE_LOCATION = Path(
    os.getenv(
        "WADE_IMAGE_SAVE_LOCATION",
        "/workspace/images_backup"
    )
)
```

This makes the code portable.

---

# Typical project workflow

### Developer A

```
.env

WADE_IMAGE_SAVE_LOCATION=/home/ap/Repositories/wade-system/images_backup
```

### Developer B

```
.env

WADE_IMAGE_SAVE_LOCATION=/Users/bob/Projects/wade/images_backup
```

### Docker

```
ENV WADE_IMAGE_SAVE_LOCATION=/workspace/images_backup
```

### Production

```
WADE_IMAGE_SAVE_LOCATION=/var/lib/wade/images
```

The application code is identical in every environment.

---

# Recommended approach for WADE

For machine-specific paths, use environment variables such as:

```
WADE_DATA_DIRECTORY
WADE_IMAGE_SAVE_LOCATION
WADE_GECKODRIVER_PATH
WADE_FIREBASE_SECRET
```

Provide sensible defaults in the code:

```
SAVE_LOCATION = Path(
    os.getenv(
        "WADE_IMAGE_SAVE_LOCATION",
        "/workspace/images_backup"
    )
)
```

Keep project defaults in `.env.example`, each developer's local settings in `.env`, and container/production overrides in Docker or deployment configuration.

---

# Key takeaways

- Environment variables configure a program **without changing the code**.
- The same code can run on different machines with different settings.
- Use `os.getenv()` to read them, preferably with a default value.
- For development, `.env` files are the most common solution.
- For Docker, use `ENV` in the Dockerfile for defaults and `docker run -e` or Compose to override them.
- Avoid hardcoding machine-specific paths in source code. Use environment variables instead.
