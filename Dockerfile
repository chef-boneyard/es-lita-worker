FROM ubuntu:16.04

# Install common build dependencies
RUN apt-get update && \
    apt-get install -y git-core autoconf binutils-doc bison build-essential flex \
                       gettext ncurses-dev libssl-dev libreadline-dev zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Next, install rbenv so it can pick up the ruby the people want
# Based on https://github.com/tcnksm/dockerfile-rbenv/blob/master/Dockerfile
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
    /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh && \
    echo 'eval "$(rbenv init -)"' >> .bashrc

# Pre-install Ruby 2.4.1 and Bundler
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install 2.4.1
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc && \
    rbenv global 2.4.1 && \
    gem install bundler
