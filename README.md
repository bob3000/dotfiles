# dotfiles

## Install

### Local install

```sh
stow -v -n bat cspell fish git k9s kitty lazygit lazyvim python starship tmux wezterm zsh
```

### Docker / Podman

```sh
docker run -ti --rm --name dotfiles ghcr.io/bob3000/dotfiles-arch:latest
```
