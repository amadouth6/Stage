FROM python:3.7

#ARG PGDG_REPO=http://apt.postgresql.org/pub/repos/apt
#ARG PGDG_GPG_KEY=https://www.postgresql.org/media/keys/ACCC4CF8.asc
#ARG PGDG_KEYRING=/usr/share/keyrings/pgdg-archive-keyring.gpg

# ARG NODE_REPO=https://deb.nodesource.com/node_12.x
# ARG NODE_GPG_KEY=https://deb.nodesource.com/gpgkey/nodesource.gpg.key
# ARG NODE_KEYRING=/usr/share/keyrings/nodejs-archive-keyring.gpg

# ARG YARN_REPO=https://dl.yarnpkg.com/debian/
# ARG YARN_GPG_KEY=https://dl.yarnpkg.com/debian/pubkey.gpg
# ARG YARN_KEYRING=/usr/share/keyrings/yarnpkg-archive-keyring.gpg

# RUN . /etc/os-release && \
#   echo "deb [signed-by=${PGDG_KEYRING}] ${PGDG_REPO} ${VERSION_CODENAME}-pgdg main" \
#   > /etc/apt/sources.list.d/pgdg.list && \
#   curl -fsSL ${PGDG_GPG_KEY} | gpg --dearmor > ${PGDG_KEYRING} && \
#   echo "deb [signed-by=${NODE_KEYRING}] ${NODE_REPO} ${VERSION_CODENAME} main" \
#   > /etc/apt/sources.list.d/nodejs.list && \
#   curl -fsSL ${NODE_GPG_KEY} | gpg --dearmor > ${NODE_KEYRING} && \
#   echo "deb [signed-by=${YARN_KEYRING}] ${YARN_REPO} stable main" \
#   > /etc/apt/sources.list.d/yarnpkg.list && \
#   curl -fsSL ${YARN_GPG_KEY} | gpg --dearmor > ${YARN_KEYRING}

# warning: the py:3.7 image comes with python3.9 installed from debian; do not
# add debian python packages here, they would not be usable for the py37 based
# environment used in this image.
RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && apt-get upgrade -y && \
  apt-get install wait-for-it -y

  

RUN useradd -md /srv/softwareheritage -s /bin/bash swh
USER swh

RUN python3 -m venv /srv/softwareheritage/venv
ENV PATH="/srv/softwareheritage/venv/bin:${PATH}"

RUN pip install --upgrade pip setuptools wheel
RUN pip install gunicorn httpie
# cython and configjob are required to install the breeze (bzr) package
#RUN pip install cython configobj

 RUN pip install \
   swh-counters
#   swh-deposit[server] \
#   swh-graphql \
#   swh-indexer \
#   swh-journal \
#   swh-lister \
#   swh-loader-core \
#   swh-loader-bzr \
#   swh-loader-cvs \
#   swh-loader-git \
#   swh-loader-mercurial \
#   swh-loader-metadata \
#   swh-loader-svn \
#   swh-storage \
#   swh-objstorage \
#   swh-scheduler \
#   swh-vault \
#   swh-web 

#COPY utils/*.sh /srv/softwareheritage/utils/
#RUN mkdir -p /srv/softwareheritage/objects
#RUN rm -rd /srv/softwareheritage/.cache
