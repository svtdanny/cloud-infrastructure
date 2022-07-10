FROM golang

RUN mkdir /opt/app
RUN mkdir /opt/src
COPY . /opt/src/
RUN cd /opt/src && go build
RUN mv /opt/src/app /opt/app/app
RUN rm -rf /opt/src

CMD '/opt/app/app'