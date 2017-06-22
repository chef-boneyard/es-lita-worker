FROM ubuntu:16.04

# Install common build dependencies
RUN apt-get update && \
    apt-get install -y git-core autoconf binutils-doc bison build-essential flex \
                       gettext ncurses-dev libssl-dev libreadline-dev zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install the latest Habitat
RUN curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash

# Install the latest stable ChefDK
RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
