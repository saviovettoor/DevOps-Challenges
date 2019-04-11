FROM node:alpine
LABEL <maintainer> savio
EXPOSE 80
RUN mkdir -p /app
WORKDIR /app
ADD server.js ./
COPY package.json ./
CMD ["npm","start"]
