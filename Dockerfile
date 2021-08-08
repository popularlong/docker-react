# Multi-step builder
# Build phase below "as builder" means in bulder phase
# following build container is a temp container, just be used to create files in app/build, whiche are needed from nginx 
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run phase
FROM nginx
EXPOSE 80
# blow means we want to copy something from build phase 
COPY --from=builder /app/build /usr/share/nginx/html
