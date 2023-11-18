FROM ubuntu

ARG USERNAME
ARG GID
ARG UID

RUN adduser --gid $GID              \
            --home /home/$USERNAME  \
            --uid $UID              \
            $USERNAME
RUN usermod -aG sudo $USERNAME
RUN passwd -d $USERNAME

RUN apt update && apt upgrade -y  
RUN yes | unminimize
RUN apt-get install -y cmake gdb git make psmisc strace tmux wget vim

COPY .vimrc /home/$USERNAME/.vimrc

USER $USERNAME
