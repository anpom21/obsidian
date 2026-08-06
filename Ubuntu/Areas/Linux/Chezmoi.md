
# Managing multiple machine types with chezmoi

## 1. Use a machine profile

Instead of maintaining separate repositories or separate dotfiles, define a profile in each machine's local configuration:

```
~/.config/chezmoi/chezmoi.toml

[data]
profile = "work"
```

or

```
[data]
profile = "personal"
```

This file is **not committed** and only exists on each machine.

---


# How profiles change dotfiles

You generally keep **one template**:

```
dot_gitconfig.tmpl
```

Instead of

```
.gitconfig-work
.gitconfig-personal
```

The template contains small conditionals:

```
{{ if eq .profile "work" }}
email = work@example.com
{{ else }}
email = me@gmail.com
{{ end }}
```

chezmoi renders different output depending on the current machine.

---

# When configurations become very different

Rather than filling a file with many `if`s:

```
dot_gitconfig.tmpl
```

can include

```
.chezmoitemplates/
    git-work.tmpl
    git-personal.tmpl
```

This keeps templates clean.

---

# Team workflow

A good model is:

## Maintainers

Responsible for

- template logic
- profiles
- machine-specific configuration
- repository structure

---

## Team members

Usually never touch templates.

They simply:

```
chezmoi edit ~/.zshrc
```

Add an alias:

```
alias k="kubectl"
```

Then commit:

```
chezmoi git add .
chezmoi git commit
chezmoi git push
```

No template knowledge required.

If later something becomes work-specific, a maintainer can introduce the necessary template logic.

---

# Repository organization

Instead of one massive `.zshrc`, split it into sourced files:

```
.zshrc
└── sources

~/.config/shell/
    aliases.sh
    functions.sh
    exports.sh
```

Most contributors edit these plain shell files.

Only a few small files contain chezmoi template logic.

---

# Git workflow

Instead of changing into the source directory:

```
chezmoi cd
```

or remembering where it lives,

use the built-in Git wrapper:

```
chezmoi git status
chezmoi git add .
chezmoi git commit
chezmoi git push
```

This works from any directory.

---

# Recommended workflow for a team

For everyday contributors:

```
chezmoi edit ~/.zshrc
```

Make changes.

```
chezmoi diff
```

Review them.

```
chezmoi apply
```

Apply locally.

```
chezmoi git add .
chezmoi git commit -m "..."
chezmoi git push
```

---

# Overall philosophy

Think of chezmoi templates as **infrastructure**, not everyday code.

- Most developers should only edit shell configs, aliases, functions, and tool configs.
- A small number of maintainers manage profile logic and templates.
- This provides flexibility for work vs. personal machines while keeping the common workflow simple for everyone.

