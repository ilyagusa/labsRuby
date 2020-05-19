FROM node:latest as build

RUN mkdir -p /opt/app/
WORKDIR /opt/app/
ADD ./ ./ 
RUN ["npm", "ci"]
RUN ["npm", "run", "build"]

FROM nginx:latest as application
RUN mkdir /app
WORKDIR /app
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /opt/app/dist /usr/share/nginx/html
RUN rm /etc/nginx/nginx.conf
ADD ./nginx.conf /etc/nginx/
EXPOSE 80
