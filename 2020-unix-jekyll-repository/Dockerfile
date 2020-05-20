FROM ruby:2.6.5 as jekyll-base
RUN mkdir /app/
ADD ./Gemfile /app
ADD ./Gemfile.lock /app
WORKDIR /app
RUN gem install bundler && bundle install
ENTRYPOINT ["jekyll", "serve"]

FROM jekyll-base as jekyll-build
RUN mkdir /build
COPY --from=jekyll-base /app /build
WORKDIR /build
RUN jekyll build

FROM nginx:latest as publish
RUN mkdir /app
COPY from=jekyll-build /build/_site /app
