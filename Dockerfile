FROM quay.io/archlinux/archlinux
ARG IMG_USR=bob

WORKDIR /home/${IMG_USR}/code/dotfiles
COPY . .
RUN ./install_pkg.sh
RUN pacman -S --noconfirm zsh \
  && useradd -m ${IMG_USR} -s /usr/bin/zsh \
  && chown -R ${IMG_USR}:${IMG_USR} /home/${IMG_USR}
USER ${IMG_USR}
RUN curl --proto '=https' -y --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUN ./link_files.sh
WORKDIR /home/${IMG_USR}
RUN git clone https://github.com/bob3000/neovim-config.git .config/nvim
ENTRYPOINT ["fish"]
# CMD [ "-c", "neofetch" ]
