# Dotfiles

## Setup

Ensure you have GNU Stow installed and run the setup script.

```bash
bash setup.sh
```

The script will symlink all configuration files into `$HOME` using stow.
If there are conflicts with existing configuration files at `$HOME`, remove or move those files and rerun.
The script will also install some of the configured software automatically,
but you will have to install most of it yourself.
