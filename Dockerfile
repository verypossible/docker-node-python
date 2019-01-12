ARG NODE_IMAGE_TAG

FROM node:$NODE_IMAGE_TAG

ARG PYTHON_VERSION

ENV PYENV_ROOT="/usr/local/share/pyenv"

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
  && git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT \
  && echo 'export PATH=$PYENV_ROOT/bin:$PATH' >> /etc/profile.d/pyenv.sh \
  && echo 'eval "$(pyenv init -)"' >> /etc/profile.d/pyenv.sh \
  && chmod a+x /etc/profile.d/pyenv.sh \
  && source /etc/profile.d/pyenv.sh \
  && pyenv install $PYTHON_VERSION \
  && pyenv global $PYTHON_VERSION \
  && apk del build-deps

CMD sh -l
