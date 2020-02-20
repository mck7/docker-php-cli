FROM php:7.4.2-cli
MAINTAINER corycollier@corycollier.com

RUN apt update -y \
  && apt upgrade -y \
  && apt install -y \
    vim \
    zsh \
    curl \
    git
    
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
ADD dotfiles/* /root/
