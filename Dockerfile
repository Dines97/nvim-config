ARG USER=user

FROM alpine:latest AS prepare
ARG USER

RUN apk update
RUN apk add neovim luarocks git nodejs npm python3 py-pip go cargo 
RUN addgroup ${USER} && adduser ${USER} --disabled-password -G ${USER} -h /home/${USER}

# RUN apt-get update
# RUN apt-get install -y neovim luarocks git nodejs npm python3
# RUN useradd -ms /bin/bash ${USER}

FROM prepare
ARG USER

USER ${USER}
WORKDIR /home/${USER}
COPY --chown=${USER}:${USER} init.lua .config/nvim/
COPY --chown=${USER}:${USER} lua/plugins.lua lua/keymaps.lua .config/nvim/lua/

RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'


ENTRYPOINT sh
CMD nvim
