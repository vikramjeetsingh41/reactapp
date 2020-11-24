FROM node:10 as uiBuilder

RUN mkdir -p /app

WORKDIR /app

COPY package*.json ./

COPY . .

RUN npm install && npm run build

# Handle Nginx
FROM nginx

COPY --from=uiBuilder /app/build /usr/share/nginx/html

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]