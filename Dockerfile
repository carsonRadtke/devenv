FROM ubuntu:22.04

ARG USERNAME
ARG GID
ARG UID

# configure user
RUN adduser --gid $GID              \
            --home /home/$USERNAME  \
            --uid $UID              \
            $USERNAME
RUN usermod -aG sudo $USERNAME
RUN passwd -d $USERNAME

# install man pages
RUN yes | unminimize
RUN apt-get update && apt-get install -y man

# install buck
RUN apt-get install -y default-jdk ant python2 git
RUN mkdir /home/$USERNAME/bin
RUN git clone https://github.com/facebook/buck.git /home/$USERNAME/bin/buck-src
RUN cd /home/$USERNAME/bin/buck-src && ant
RUN ln -s /home/$USERNAME/bin/buck-src/bin/buck /home/$USERNAME/bin/buck

# install devtools
RUN apt-get install -y bat cmake curl emacs gdb htop jq man \
    nodejs npm psmisc screen strace sudo vim wget clang-15  \
    clangd file 

# install config files
COPY ./mycfg/bashrc_append.sh /home/$USERNAME/bashrc_append.sh
RUN printf "\n" >> /home/$USERNAME/.bashrc
RUN cat /home/$USERNAME/bashrc_append.sh >> /home/$USERNAME/.bashrc
RUN printf "\n" >> /home/$USERNAME/.bashrc
RUN rm /home/$USERNAME/bashrc_append.sh

COPY ./mycfg/.vimrc /home/$USERNAME/.vimrc
COPY ./mycfg/.emacs /home/$USERNAME/.emacs

USER $USERNAME
