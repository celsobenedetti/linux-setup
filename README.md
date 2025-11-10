# Linux Setup

1. `./keyd.sh`
2. `for script in $(fd sh apps); do eval $script 2>/dev/null; done`
3. log into google accounts
4. `export GITHUB_TOKEN`
5. ssh
  1. `ssh.sh`
  2. `add_ssh_key_to_github.sh`
6. gpg
  1. `gpg.sh`
  2. `add_gpg_key_to_github.sh`
  11. `./neovim.sh`
  12. `./dotfiles.sh`



## additional packages

```bash
# Tmux Package Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## post setup

1. [add gpg key to github](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)
