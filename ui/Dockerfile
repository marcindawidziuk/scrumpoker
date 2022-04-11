FROM node:lts as builder

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

RUN rm -rf node_modules

FROM node:lts

WORKDIR /app

COPY --from=builder /app  .

ENV HOST 0.0.0.0
EXPOSE 80

CMD [ "npm", "start" ]
