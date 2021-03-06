FROM node:boron

# Create app directory
WORKDIR /usr/src/app

ADD . /usr/src/app
# Install app dependencies
# COPY package.json .
# For npm@5 or later, copy package-lock.json as well

RUN apt-get update

RUN apt-get install nano

# Create a nonroot user, and switch to it
RUN /usr/sbin/useradd --create-home --home-dir /usr/src/app --shell /bin/bash nonroot
RUN /usr/sbin/adduser nonroot sudo
RUN usermod -aG root nonroot
RUN chown -R nonroot /usr/src/app

USER nonroot

RUN npm cache clean

RUN npm install

USER root

RUN npm cache clean

RUN npm install nodemon -g

RUN npm install

RUN chown -R node /usr/src/app/node_modules

EXPOSE 3000

# CMD ["npm", "start"]
