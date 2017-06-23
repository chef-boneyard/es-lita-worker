FROM ubuntu:16.04

# Install common build dependencies
RUN apt-get update && \
    apt-get install -y git-core autoconf binutils-doc bison build-essential flex \
                       gettext ncurses-dev libssl-dev libreadline-dev zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install the latest Habitat
RUN curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash

# Install the Docker CLI (via hab)
RUN hab pkg install core/docker && \
    hab pkg binlink core/docker

# Install Ruby (via hab)
RUN hab pkg install core/ruby/2.4.1 && \
    hab pkg binlink core/ruby/2.4.1 && \
    hab pkg install core/bundler && \
    hab pkg binlink core/bundler && \
    hab pkg install core/cacerts && \
    echo 'gem: --no-rdoc --no-ri' >> /.gemrc

# Install Delivery CLI (via hab)
# The core/delivery-cli is not up to date, hence why we're using tduffield (which is more recent)
RUN hab pkg install tduffield/delivery-cli && \
    hab pkg binlink tduffield/delivery-cli
