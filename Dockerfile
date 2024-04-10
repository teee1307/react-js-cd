FROM node:18

WORKDIR /usr/src/app

COPY package.json .
COPY package-lock.json .

RUN npm install

RUN npm install -g vite

COPY . .

EXPOSE 5173

CMD ["npm","run", "dev"]


