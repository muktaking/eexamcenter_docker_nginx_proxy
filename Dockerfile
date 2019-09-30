FROM node:10
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package*.json ./
# USER node
RUN npm install
COPY --chown=node:node . .
EXPOSE 3000
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.5.0/wait /wait
RUN chmod +x /wait
CMD /wait && npm start