FROM ubuntu
MAINTAINER enxajt

RUN apt-get update && apt-get install -y \
  language-pack-ja-base \
  language-pack-ja \
  ibus-mozc \
  fonts-ipafont-gothic \
  fonts-ipafont-mincho \
  curl \
  git \
  pandoc \
# TODO: remove sudo
  sudo \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN alias curl='curl --noproxy localhost,127.0.0.1'
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja
ENV LC_ALL C.UTF-8

# nodejs npm gulp
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  npm \
 && npm cache clean \
 && npm install n -g \
 && n stable \
 && ln -sf /usr/local/bin/node /usr/bin/node
RUN apt-get -y purge nodejs npm \
 && npm update

ENV USER enxajt
#RUN useradd -m -g sudo $USER && echo "$USER:$USER" | chpasswd
RUN useradd -m -g sudo $USER
USER $USER
WORKDIR /home/$USER
RUN git clone https://github.com/enxajt/npm-impress.git
WORKDIR /home/$USER/npm-impress
RUN npm install 

RUN cd /home/$USER/ \
  && curl -L https://github.com/astefanutti/decktape/archive/v1.0.0.tar.gz | tar -xz --exclude phantomjs \
  && cd /home/$USER/decktape-1.0.0 \
  && curl -L https://github.com/astefanutti/decktape/releases/download/v1.0.0/phantomjs-linux-x86-64 -o phantomjs \
  && chmod +x phantomjs

COPY .ssh /.ssh
COPY git.sh /git.sh
RUN /git.sh

#RUN cd /home/$USER/ \
#  && git clone https://github.com/enxajt/docker-sphinx.git
#ADD plantuml.jar /home/$USER/docker-sphinx/
#RUN cd /home/$USER/docker-sphinx \
#  && docker build . -t sphinx

# nodejs npm
RUN set -x apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  npm \
 && npm cache clean \
 && npm install n -g \
 && n stable \
 && ln -sf /usr/local/bin/node /usr/bin/node
RUN apt-get -y purge nodejs npm \
 && npm update \
 && npm install --global gulp gulp-cli

RUN git clone https://github.com/enxajt/gulp-plantuml.git /plantuml
WORKDIR /plantuml
RUN npm init -y \
 && npm install --save-dev gulp path gulp-plantuml gulp-webserver gulp-print gulp-cached gulp-exec gulp-ejs gulp-rename gulp-plumber gulp-json-transform gulp-tap

EXPOSE 8000
CMD ["/bin/bash"]
