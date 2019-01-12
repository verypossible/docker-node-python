ARG NODE_IMAGE_TAG

FROM node:$NODE_IMAGE_TAG

ARG PYTHON_VERSION

RUN apk add --no-cache bash git \
  && apk add --no-cache --virtual build-deps \
    build-base \
    libffi-dev \
    openssl-dev \
    bzip2-dev \
    zlib-dev \
    readline-dev \
    sqlite-dev \
    linux-headers \
  && cd /tmp \
  && git clone git://github.com/pyenv/pyenv.git \
  && cd pyenv/plugins/python-build \
  && ./install.sh \
  && cd /tmp \
  && rm -rf pyenv \
  && python-build $PYTHON_VERSION /usr/local

CMD sh
