FROM quay.io/archlinux/archlinux
ARG IMG_USR=bob

WORKDIR /home/${IMG_USR}/.dotfiles
COPY packages/pkglist.pacman packages/pkglist.pacman
RUN pacman -Sy \
  # && pacman -S --noconfirm --needed - < packages/pkglist.extra.pacman \
  && pacman -S --noconfirm --needed - < packages/pkglist.pacman
RUN useradd -m ${IMG_USR} -G wheel && \
  chown -R ${IMG_USR}:${IMG_USR} /home/${IMG_USR}
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
COPY . .
RUN chown -R ${IMG_USR} /home/${IMG_USR}
USER ${IMG_USR}
RUN stow -v bat fish git lazygit nvim python starship vim
WORKDIR /home/${IMG_USR}
RUN vim -c 'PlugInstall --sync' -c 'qa'
USER root
RUN echo 'permit nopass setenv {PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin} :wheel' > /etc/doas.conf
RUN rm -rf /var/cache/* /home/${IMG_USR}/.cache/* /tmp/*
RUN sed -i -e 's/LANG=C.UTF-8/LANG=en_US.UTF-8/' /etc/locale.conf && \
  sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  locale-gen
USER ${IMG_USR}
WORKDIR /home/${IMG_USR}/code
ENTRYPOINT ["fish"]
