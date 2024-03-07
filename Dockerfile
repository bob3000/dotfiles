FROM quay.io/archlinux/archlinux
ARG IMG_USR=bob

WORKDIR /home/${IMG_USR}/.dotfiles
COPY . .
RUN pacman -Sy \
  && pacman -S --noconfirm --needed - < packages/pkglist.pacman
RUN useradd -m ${IMG_USR} && \
  chown -R ${IMG_USR}:${IMG_USR} /home/${IMG_USR}
RUN npm install -g neovim
RUN curl -sLo /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
  tar --strip=1 -C /usr/local -xzf /tmp/nvim.tar.gz
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
RUN locale-gen
USER ${IMG_USR}
WORKDIR /home/${IMG_USR}/.dotfiles
RUN stow -v bat fish git lazygit nvim python starship
WORKDIR /home/${IMG_USR}
RUN nvim --headless "+Lazy! sync" +qa
# RUN nvim --headless "+Lazy load all" "+TSUpdateSync" +qa
USER root
RUN rm -rf /var/cache/* /home/${IMG_USR}/.cache/* /tmp/*
USER ${IMG_USR}
WORKDIR /home/${IMG_USR}/code
RUN locale-gen
ENTRYPOINT ["fish"]
