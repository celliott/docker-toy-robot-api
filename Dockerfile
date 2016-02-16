# dockerfile for toy-robot-api

FROM python:2.7
MAINTAINER MAINTAINER chris elliott <ctelliott@gmail.com>

RUN apt-get update && apt-get -y install \
		supervisor \
		vim

# stop supervisor service as we'll run it manually
RUN service supervisor stop

# install dependencies
ADD ./app/requirements.txt /requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /requirements.txt

# add app files
ADD ./app /opt/app

# add supervisor config
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD ./start.sh /start.sh

#CMD ["/usr/bin/supervisord"]
#CMD bin/bash -l
CMD /start.sh
