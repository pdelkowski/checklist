FROM phusion/passenger-ruby22:0.9.15

ENV HOME /root

CMD ["/sbin/my_init"]

ADD ./docker /img_build
RUN /img_build/build.sh

WORKDIR /tmp
ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
RUN bundle install --jobs 8

RUN mkdir /home/app/application
ADD . /home/app/application
RUN chown -R app:app /home/app/application

WORKDIR /home/app/application

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
