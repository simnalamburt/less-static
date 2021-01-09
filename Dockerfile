# less-static repo don't actually use this Dockerfile, but I'm leaving this
# script here for those who might need this

FROM alpine:3.12.3
RUN apk add --no-cache build-base autoconf ncurses-static
RUN wget https://github.com/gwsw/less/archive/v572.tar.gz -O - | tar -zx
WORKDIR /less-572
RUN make -f Makefile.aut
RUN CFLAGS=-Os LDFLAGS=-static ./configure
RUN make -j
RUN strip less lessecho lesskey

FROM alpine:3.12.3
RUN apk add --no-cache ncurses-terminfo-base
COPY --from=0 ["/less-572/less", "/less-572/lessecho", "/less-572/lesskey", "/usr/local/bin/"]
CMD ["/usr/local/bin/less"]
