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
  tree-sitter-cli \
  && dnf clean all

RUN PLATFORM=$( \
  if [ "$TARGETPLATFORM" = "linux/amd64" ]; then echo "linux-x86_64"; \
  elif [ "$TARGETPLATFORM" = "darwin/arm64" ]; then echo "macos-arm64"; \
  fi \
  ) && \
  echo "PLATFORM=$PLATFORM" >> /etc/environment

RUN source /etc/environment && \
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-${PLATFORM}.tar.gz && \
  tar --strip-components=1 -C /usr/local -xzf nvim-${PLATFORM}.tar.gz && \
  rm nvim-linux-x86_64.tar.gz

RUN useradd --uid ${UID} -m ${IMG_USR}
USER ${IMG_USR}:${IMG_USR}
WORKDIR /home/${IMG_USR}/code

CMD ["sh"]
