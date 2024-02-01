# dotfiles

## Install

### Local install

```sh
curl -fsSL https://fnm.vercel.app/install | bash
curl -sSL https://install.python-poetry.org | python3 -
curl --proto '=https' -y --tlsv1.2 -sSf https://sh.rustup.rs | sh

stow -v -n bat cspell fish git k9s kitty lazygit lazyvim python starship tmux wezterm zsh
```

### Docker / Podman

```sh
docker run -ti --rm --name dotfiles ghcr.io/bob3000/dotfiles-arch:latest
```
