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
RUN curl -fsSL https://fnm.vercel.app/install | bash
RUN ./link_files.sh
WORKDIR /home/${IMG_USR}
RUN fish -c "fish_add_path -U -a /home/bob/.local/share/fnm \
  && fisher install decors/fish-colored-man \
  edc/bass \
  jomik/fish-gruvbox \
  jorgebucaran/autopair.fish \
  jorgebucaran/nvm.fish \
  jorgebucaran/replay.fish \
  2m/fish-history-merge \
  PatrickF1/fzf.fish"
RUN nvim --headless -c 'quitall' \
&& wget -O /home/${IMG_USR}/.local/share/nvim/site/spell/de.utf-8.spl http://ftp.vim.org/vim/runtime/spell/de.utf-8.spl \
&& wget -O /home/${IMG_USR}/.local/share/nvim/site/spell/de.utf-8.sug http://ftp.vim.org/vim/runtime/spell/de.utf-8.sug \
&& nvim --headless -c 'quitall'
ENTRYPOINT ["fish"]
