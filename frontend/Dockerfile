FROM node:14

WORKDIR /app

COPY package*.json ./

RUN npm install
RUN npm install -g @vue/cli

COPY . .

CMD ["npm", "run", "serve"]
