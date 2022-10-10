# builder stage : 운영 nginx 이전의 build 단계에서 사용될 부분 정의 
FROM node:alpine as builder

RUN mkdir -p /usr/src/app/node_modules/.cache
RUN chmod -R 777 /usr/src/app

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

# Nginx 기동
FROM nginx
# builder stage 에 있는 파일을 nginx 의 static resource 가 반환될 수 있는 폴더에 복사(실제 운영에서는 nginx 가 동작된다!)
COPY --from=builder /usr/src/app/build /usr/share/nginx/html