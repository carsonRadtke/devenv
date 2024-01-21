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
RUN apt-get install -y clangd cmake gdb git make psmisc strace tmux wget vim

COPY .bashrc /home/$USERNAME/.bashrc
COPY .vimrc /home/$USERNAME/.vimrc
COPY .tmux.conf /home/$USERNAME/.tmux.conf
COPY .gitconfig /home/$USERNAME/.gitconfig
COPY .gitcommitmsg /home/$USERNAME/.gitcommitmsg

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

USER $USERNAME
