FROM nikolaik/python-nodejs:python3.10-nodejs16 as builder

WORKDIR /app

COPY package.json yarn.lock /app/

RUN yarn install --frozen-lockfile

COPY . /app

RUN yarn build-vite

FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

ADD default.conf /etc/nginx/conf.d/

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/dist .

EXPOSE 80
