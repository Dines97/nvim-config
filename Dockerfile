ARG USER=user

FROM alpine:latest AS prepare
ARG USER

RUN apk update
RUN apk add neovim luarocks git nodejs npm python3 py-pip go cargo build-base
RUN addgroup ${USER} && adduser ${USER} --disabled-password -G ${USER} -h /home/${USER}

# RUN apt-get update
# RUN apt-get install -y neovim luarocks git nodejs npm python3
# RUN useradd -ms /bin/bash ${USER}

FROM prepare
ARG USER

USER ${USER}
WORKDIR /home/${USER}/.config/nvim
COPY --chown=${USER}:${USER} . .

RUN nvim --headless '+Lazy! sync' +qa

ENTRYPOINT nvim

