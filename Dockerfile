FROM node:alpine

RUN mkdir -p /usr/src/app/node_modules/.cache
RUN chmod -R 777 /usr/src/app

WORKDIR /usr/src/app

COPY --from=0 package.json ./

RUN npm install

COPY --from=0 ./ ./

RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html