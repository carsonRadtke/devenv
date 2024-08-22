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

RUN apt update && apt upgrade -y  
RUN yes | unminimize
RUN apt install -y adduser clang clangd cmake curl fzf gcc gdb git htop make psmisc   \
                   strace tmux wget vim

RUN adduser --gid $GID              \
            --home /home/$USERNAME  \
            --uid $UID              \
            $USERNAME
RUN usermod -aG sudo $USERNAME
RUN passwd -d $USERNAME

RUN touch /home/$USERNAME/.hushlogin

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

USER $USERNAME

RUN git clone https://github.com/carsonRadtke/devenv ~/devenv
RUN ~/devenv/copy_config.sh
RUN rm -rf ~/devenv
