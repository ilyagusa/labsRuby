FROM ruby:2.6.5-buster
LABEL maintainer="super.ilyagusew@yandex.ru"
ENV REFRESHED_AT 2020-04-20

RUN mkdir -p /opt/webapp
ADD ./ /opt/webapp
RUN bundle install --gemfile=/opt/webapp/Gemfile

EXPOSE 4567

ENTRYPOINT ["ruby", "/opt/webapp/app.rb"]
