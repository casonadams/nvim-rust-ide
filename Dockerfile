FROM fedora:32

RUN dnf install -y \
 neovim \
 gcc \
 pip \
 nodejs \
 git \
 && dnf clean all \
 ;

RUN python3 -m pip --no-cache-dir install \
    pynvim \
    autopep8 \
    jedi \
    ;

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    CARGO_TARGET_DIR=/usr/local/target \
    PATH=/usr/local/cargo/bin:$PATH \
    USER=root

RUN curl -f -L https://static.rust-lang.org/rustup.sh -O \
 && sh rustup.sh -y \
    --no-modify-path \
    --profile minimal \
 && rustup toolchain install stable \
 && rustup toolchain install nightly \
 && rustup default stable \
 && rustup component add rls rust-analysis rust-src \
 && rm rustup.sh \
 && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
 ;

COPY init.vim /root/.config/nvim/

RUN mkdir -p /root/.config/coc/extensions \
 && cd /root/.config/coc/extensions \
 && echo '{"dependencies":{}}'> package.json \
 && npm install \
    coc-rls \
    coc-prettier \
    coc-template \
    coc-spell-checker \
    coc-markdownlint \
    coc-yaml \
    coc-python \
    coc-diagnostic \
    --no-package-lock \
    --only=prod \
 ;

RUN nvim --headless +PlugInstall +qall

RUN printf '{\n\
  "coc.preferences.formatOnSaveFiletypes": ["*"],\n\
  "diagnostic.messageTarget": "echo",\n\
  "diagnostic-languageserver.filetypes": {\n\
    "sh": "shellcheck"\n\
  }\n\
}' > /root/.config/nvim/coc-settings.json \
 ;

RUN echo "alias vi='nvim'" >> /root/.bashrc

CMD ["nvim"]
