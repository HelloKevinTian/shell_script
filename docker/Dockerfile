FROM node:12.21.0

LABEL maintainer="tianwen@fotoable.com"

WORKDIR /home/code/app

COPY .npmrc ./

COPY package*.json ./

RUN npm install --only=prod

COPY . .

EXPOSE 3500

CMD [ "node", "server.js" ]
