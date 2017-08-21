FROM ruby:2.2

RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/  
RUN bundle install

ENV RAILS_ENV production
ENV RACK_ENV production

EXPOSE 4567
ADD . $APP_HOME

CMD ["ruby", "products_service.rb"]
