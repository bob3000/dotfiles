FROM archlinux
ARG IMG_USR=bob

WORKDIR /home/${IMG_USR}/code/dotfiles
COPY . .
RUN ./install_pkg.sh
RUN useradd -m ${IMG_USR} -s /usr/bin/zsh \
  && chown -R ${IMG_USR}: /home/${IMG_USR}
USER ${IMG_USR}
RUN curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN curl --proto '=https' -y --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUN LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -- -y
RUN ./link_files.sh
WORKDIR /home/${IMG_USR}
ENTRYPOINT ["zsh"]
