# Build stage
FROM node:14 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Deployment stage
FROM nginx
COPY --from=build /app/build /usr/share/nginx/html

