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
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN alias curl='curl --noproxy localhost,127.0.0.1'
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja
ENV LC_ALL C.UTF-8

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

RUN cd / \
  && curl -L https://github.com/astefanutti/decktape/archive/v1.0.0.tar.gz | tar -xz --exclude phantomjs \
  && cd /decktape-1.0.0 \
  && curl -L https://github.com/astefanutti/decktape/releases/download/v1.0.0/phantomjs-linux-x86-64 -o phantomjs \
  && chmod +x phantomjs

COPY .ssh /.ssh
COPY git.sh /git.sh
RUN /git.sh

RUN git clone https://github.com/enxajt/npm-impress.git
WORKDIR /npm-impress
RUN npm init -y \
 && npm install --save-dev ejs watch chokidar-cli ejs exec glob marked 
RUN npm install --save-dev markdown-it

EXPOSE 8000
CMD ["/bin/bash"]
