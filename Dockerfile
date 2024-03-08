FROM quay.io/archlinux/archlinux
ARG IMG_USR=bob

WORKDIR /home/${IMG_USR}/.dotfiles
COPY packages/pkglist.pacman packages/pkglist.pacman
RUN pacman -Sy \
  && pacman -S --noconfirm --needed - < packages/pkglist.pacman
RUN useradd -m ${IMG_USR} && \
  chown -R ${IMG_USR}:${IMG_USR} /home/${IMG_USR}
RUN npm install -g neovim
RUN curl -sLo /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
  tar --strip=1 -C /usr/local -xzf /tmp/nvim.tar.gz
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
COPY . .
RUN chown -R ${IMG_USR} /home/${IMG_USR}
USER ${IMG_USR}
RUN stow -v bat fish git lazygit nvim python starship
WORKDIR /home/${IMG_USR}
RUN luarocks --local --lua-version 5.1 install magick
RUN nvim --headless "+Lazy! sync" "+Lazy load all" "+MasonInstallAll" "+Neorg sync-parsers" "+sleep 15" +qa
USER root
RUN rm -rf /var/cache/* /home/${IMG_USR}/.cache/* /tmp/*
RUN sed -i -e 's/LANG=C.UTF-8/LANG=en_US.UTF-8/' /etc/locale.conf && \
  sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  locale-gen
USER ${IMG_USR}
WORKDIR /home/${IMG_USR}/code
ENTRYPOINT ["fish"]
