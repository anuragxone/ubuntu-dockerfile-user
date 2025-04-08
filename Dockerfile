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

# Ruby deps
RUN apt-get install -y autoconf patch build-essential rustc libssl-dev libyaml-dev \
libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

# Postgres deps
RUN apt-get install -y pkg-config linux-headers-$(uname -r) build-essential libssl-dev \
libreadline-dev zlib1g-dev libcurl4-openssl-dev uuid-dev icu-devtools libicu-dev bison flex

RUN chsh -s /bin/zsh


# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME


WORKDIR /home/${USERNAME}
SHELL [ "/bin/zsh", "-c" ]

# oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# mise-en-place
RUN <<EOF
# set up mise
curl https://mise.run | sh 
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
# install ruby and postgres
MISE=.local/bin/mise
$MISE use -g ruby
$MISE use -g postgres
EOF

# nvim set up
# RUN <<EOF
# 
# EOF

ENTRYPOINT [ "/bin/zsh" ]
