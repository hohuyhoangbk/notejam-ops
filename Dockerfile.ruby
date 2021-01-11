FROM ruby:2.1.5
RUN apt-get update && apt-get install -y nodejs
ENV APP_HOME /notejam
RUN mkdir -p $APP_HOME
RUN cd $APP_HOME
RUN git clone https://github.com/hohuyhoangbk/notejam.git
WORKDIR $APP_HOME/rubyonrails/notejam
RUN /bin/bash -c bundle install
RUN rake db:migrate
EXPOSE 3000
CMD [ "rails", "server", "-b", "0.0.0.0" ]
