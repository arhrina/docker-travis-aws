FROM node:alpine as builder
# as builder를 통해 이 from부터 다음 from 전까진 모두 builder stage라는걸 명시
WORKDIR /usr/src/app
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build
# build stage

FROM nginx
# port Mapping
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# build 경로에 있는 파일들을 share nginx로 복사. 공식문서 nginx가 제공할 수 있는 폴더
# run stage
