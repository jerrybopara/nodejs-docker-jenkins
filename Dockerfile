FROM node:16

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 8082
CMD [ "node", "server.js" ]

# Below command is to launch the container from the image you just built.
# docker run -p 49160:8080 -d <your username>/node-web-app

