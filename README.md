# dotfiles

## Install

### Local install

```sh
./install_pkg

curl -fsSL https://fnm.vercel.app/install | bash
curl -sSL https://install.python-poetry.org | python3 -
curl --proto '=https' -y --tlsv1.2 -sSf https://sh.rustup.rs | sh

./link_files.sh
```

### Docker / Podman

```sh
podman run -ti --rm --name dotfiles ghcr.io/bob3000/dotfiles-arch:latest
```
