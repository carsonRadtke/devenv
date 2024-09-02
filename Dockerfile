FROM ubuntu
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# docker build -t devenv-ubuntu     \
#   --build-arg USERNAME=$(whoami)  \
#   --build-arg UID=$(id -u)        \
#   --build-arg GID=$(id -g)        \
#   .

# docker run --rm -it -v ~/code:/code devenv-ubuntu /bin/bash

ARG USERNAME
ARG GID
ARG UID

RUN apt update && apt upgrade -y
RUN apt install -y adduser curl git
RUN yes | unminimize

RUN adduser --gid $GID              \
            --home /home/$USERNAME  \
            --uid $UID              \
            $USERNAME
RUN usermod -aG sudo $USERNAME
RUN passwd -d $USERNAME
USER $USERNAME

RUN touch ~/.hushlogin

RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew \
      && mkdir ~/.linuxbrew/bin \
      && ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin \ 
      && eval $(~/.linuxbrew/bin/brew shellenv) \
      && brew update --force --quiet

RUN eval $(~/.linuxbrew/bin/brew shellenv) \
    && brew install llvm

RUN git clone https://github.com/carsonRadtke/devenv ~/.devenv
RUN ~/.devenv/copy_config.sh
RUN rm -rf ~/.devenv

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

