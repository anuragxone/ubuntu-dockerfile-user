FROM ubuntu:latest
ARG USERNAME=ubuntu
ARG DEBIAN_FRONTEND=noninteractive
EXPOSE 3000
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID

# Create the user
# RUN groupadd --gid $USER_GID $USERNAME \
    # && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y apt-utils \
    && apt-get install -y curl zsh man-db vim \
    && apt-get install -y build-essential git locales dialog \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN chsh -s /bin/zsh
# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
ENTRYPOINT [ "/bin/zsh" ]
USER $USERNAME
