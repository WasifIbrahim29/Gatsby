FROM ubuntu:16.04
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
    build-essential libssl-dev vim git curl lsof python2.7 && \
    ln -s /usr/bin/python2.7 /usr/bin/python
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get -y install nodejs && \
    npm i -g n

# Also exposing VSCode debug ports
EXPOSE 8000 9929 9230

RUN npm install -g gatsby-cli yarn

WORKDIR /app
COPY ./package.json .
RUN yarn install && yarn cache clean
COPY . .
CMD ["yarn", "develop", "-H", "0.0.0.0" ]