# Dotfiles

## Setup

Install the software described in [the software list](/setup_helpers/INSTALL.md) and run the setup script.

```bash
bash setup.sh
```

The script will clone remaining dependencies and symlink all configuration files into `$HOME` using stow.
If there are conflicts with existing configuration files at `$HOME`, remove or move those files and rerun.
