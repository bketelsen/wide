FROM golang:cross
MAINTAINER Liang Ding <dl88250@gmail.com>

ADD . /wide/gogogo/src/github.com/bketelsen/wide
ADD . /wide
ADD gotty /usr/local/bin/gotty

RUN tar zxf /wide/gogogo/src/github.com/bketelsen/wide/deps/golang.org.tar.gz -C /wide/gogogo/src/
RUN tar zxf /wide/gogogo/src/github.com/bketelsen/wide/deps/github.com.tar.gz -C /wide/gogogo/src/

RUN useradd wide && useradd runner

ENV GOROOT /usr/src/go
ENV GOPATH /wide/gogogo

RUN go build github.com/go-fsnotify/fsnotify 
RUN go build github.com/gorilla/sessions 
RUN go build github.com/gorilla/websocket
RUN go install github.com/visualfc/gotools github.com/nsf/gocode github.com/bradfitz/goimports 

WORKDIR /wide/gogogo/src/github.com/bketelsen/wide
RUN go install -v
WORKDIR /wide/gogogo/src/github.com/bketelsen/wide/cmd
RUN go build -v
RUN cp /wide/gogogo/src/github.com/bketelsen/wide/cmd/cmd /usr/local/bin/wuser

WORKDIR /wide
EXPOSE 7070 8080
CMD ["/wide/start.sh"]

