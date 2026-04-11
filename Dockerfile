FROM quay.io/fedora/fedora:43
ARG TARGETPLATFORM
ARG IMG_USR=bob
ARG UID=1000

RUN dnf install -y \
  curl \
  fd-find \
  file \
  git \
  netcat \
  ripgrep \
  stow \
  tree-sitter-cli \
  && dnf clean all

RUN PLATFORM=$( \
  if [ "$TARGETPLATFORM" = "linux/amd64" ]; then echo "linux-x86_64"; \
  elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then echo "linux-arm64"; \
  fi \
  ) && \
  echo "PLATFORM=$PLATFORM" >> /etc/environment

RUN source /etc/environment && \
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-${PLATFORM}.tar.gz && \
  tar --strip-components=1 -C /usr/local -xzf nvim-${PLATFORM}.tar.gz && \
  rm nvim-${PLATFORM}.tar.gz

RUN useradd --uid ${UID} -m ${IMG_USR}
USER ${IMG_USR}:${IMG_USR}
WORKDIR /home/${IMG_USR}/.dotfiles
COPY . .

WORKDIR /home/${IMG_USR}/code

CMD ["bash"]
