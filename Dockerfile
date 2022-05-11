# Image base from 哪裡
FROM node:lts-alpine AS react-nx-base
WORKDIR /app
# 專案所有檔案複製到路徑 /app
COPY . .
# 類似 npm install
RUN npm ci
RUN npm run build
RUN npm prune --production

# Multistage，每個 image 有 layer
# 參考: https://docs.docker.com/develop/develop-images/multistage-build/
FROM nginx:alpine AS react-nx-ui
WORKDIR /usr/share/nginx/html
# 也就是從 react-nx-base 複製檔案
COPY --from=react-nx-base /app/dist/apps/gke-demo .


