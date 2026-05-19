FROM timbru31/ruby-node:3.3 as builder

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY package.json /usr/src/app/package.json

RUN npm install -g bower
RUN npm install -g grunt-cli
COPY . /usr/src/app
RUN bower --allow-root install
#RUN npm pkg delete devDependencies.grunt-contrib-compass
RUN npm install --force

#RUN gem update --system --no-document
RUN bundle install --force
#RUN npm install grunt-sass --save-dev
#RUN sed -i 's/File.exists?/File.exist?/g' \
 # /usr/local/bundle/gems/compass-1.0.3/**/*.rb
RUN grunt prod

#CMD ["sh", "-c", "grunt prod && tail -f /dev/null"]

#FROM nginx:1.19.3
#COPY --from=builder /usr/src/app/dist/community-app /usr/share/nginx/html
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]
