# dotfiles

## Install

### Local install

```sh
./install_pkg

curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
curl -sSL https://install.python-poetry.org | python3 -
curl --proto '=https' -y --tlsv1.2 -sSf https://sh.rustup.rs | sh

./link_files.sh
```

### Docker / Podman

```sh
podman run -ti --rm --name dotfiles ghcr.io/bob3000/dotfiles-arch:latest
```
