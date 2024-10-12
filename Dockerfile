FROM ubuntu:latest

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
RUN yes | unminimize

RUN apt install -y adduser
RUN adduser --gid $GID              \
            --home /home/$USERNAME  \
            --uid $UID              \
            $USERNAME
RUN usermod -aG sudo $USERNAME
RUN passwd -d $USERNAME

RUN apt install -y sudo
USER $USERNAME

RUN touch ~/.hushlogin

RUN sudo apt install -y curl
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN export PATH=$PATH:~/.rvm/bin    \
    && rvm requirements             \
    && rvm install ruby 3.3.5

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY . ~/.devenv
RUN ~/.devenv/copy_config.sh

RUN sudo apt install -y dos2unix git
RUN git config --global core.autocrlf input
RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
RUN find ~/.linuxbrew/Homebrew/bin -type f | xargs dos2unix
RUN mkdir ~/.linuxbrew/bin
RUN ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin
RUN export PATH=$PATH:~/.rvm/rubies/ruby-3.3.5/bin      \
    && eval $(~/.linuxbrew/bin/brew shellenv)           \
    && ~/.linuxbrew/bin/brew update --force --quiet

RUN echo 'export PATH=$PATH:~/.rvm/rubies/rub-3.3.5/bin' >> ~/.bashrc.extra
RUN echo 'eval $(~/.linuxbrew/bin/brew shellenv)' >> ~/.bashrc.extra

RUN eval $(~/.bashrc) && brew install $(cat ~/.devenv/brew_packages)
