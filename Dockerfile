FROM fedora:32

RUN dnf install -y \
 cmake \
 g++ \
 gcc \
 gettext-devel \
 git \
 go \
 libtool \
 make \
 nodejs \
 pip \
 && dnf clean all \
 ;

 RUN cd /usr/src \
  && git clone --depth=1 https://github.com/neovim/neovim.git \
  && cd neovim \
  && make \
     -j8 \
     CMAKE_BUILD_TYPE=RelWithDebInfo \
     CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local" \
  && make install \
  && rm -r /usr/src/neovim

RUN python3 -m pip --no-cache-dir install \
    autopep8 \
    jedi \
    pipenv \
    pylint \
    pynvim \
    neovim \
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
    coc-diagnostic \
    coc-go \
    coc-jedi \
    coc-markdownlint \
    coc-prettier \
    coc-python \
    coc-rls \
    coc-spell-checker \
    coc-template \
    coc-yaml \
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
