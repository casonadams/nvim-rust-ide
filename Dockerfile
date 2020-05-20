FROM registry.fedoraproject.org/fedora-minimal:32

RUN microdnf install -y \
 gcc \
 git \
 nodejs \
 neovim \
 && microdnf clean all \
 ;

ENV RUSTUP_HOME=/root/rustup \
    CARGO_HOME=/root/cargo \
    PATH=/root/cargo/bin:$PATH \
    RUST_SRC_PATH=/root/rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src \
    USER=root

RUN curl -f -L https://static.rust-lang.org/rustup.sh -O \
 && sh rustup.sh -y \
    --no-modify-path \
    --profile minimal \
 && rustup default stable \
 && rustup component add rls rust-analysis rust-src \
 && rm rustup.sh \
 ;

COPY init.vim /root/.config/nvim/

RUN mkdir -p /root/.config/coc/extensions \
 && cd /root/.config/coc/extensions \
 && echo '{"dependencies":{}}'> package.json \
 && npm install \
    coc-diagnostic \
    coc-markdownlint \
    coc-prettier \
    coc-rls \
    coc-spell-checker \
    --only=prod \
 && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
 && nvim --headless +PlugInstall +qall \
 && printf '{\n\
  "coc.preferences.formatOnSaveFiletypes": ["*"],\n\
  "diagnostic.messageTarget": "echo",\n\
  "diagnostic-languageserver.filetypes": {\n\
    "sh": "shellcheck"\n\
  }\n\
}' > /root/.config/nvim/coc-settings.json \
 && echo "alias vi='nvim'" >> /root/.bashrc \
 ;

CMD ["nvim"]
