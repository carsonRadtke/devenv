FROM ubuntu

# docker build -t devenv-ubuntu     \
#   --build-arg USERNAME=$(whoami)  \
#   --build-arg UID=$(id -u)        \
#   --build-arg GID=$(id -g)        \
#   .

# docker run --rm -it -v ~/code:/code devenv-ubuntu devenv-ubuntu

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
RUN apt-get install -y clangd cmake curl gcc gdb git make psmisc strace tmux wget vim
RUN touch /home/$USERNAME/.hushlogin

COPY .bashrc /home/$USERNAME/.bashrc
COPY .vimrc /home/$USERNAME/.vimrc
COPY .tmux.conf /home/$USERNAME/.tmux.conf
COPY .gitconfig /home/$USERNAME/.gitconfig
COPY .gitcommitmsg /home/$USERNAME/.gitcommitmsg

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

USER $USERNAME
