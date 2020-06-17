# First stage
FROM alpine:latest

ENV PSPDEV /usr/local/pspdev
ENV PATH $PATH:${PSPDEV}/bin
COPY . /src

RUN apk add autoconf automake bison build-base flex git bash bzip2 git gzip \
            libtool ncurses-dev patch readline-dev texinfo wget xz zlib-dev
RUN cd /src && ./toolchain.sh

# Second stage
FROM alpine:latest

ENV PSPDEV /usr/local/pspdev
ENV PATH $PATH:${PSPDEV}/bin

COPY --from=0 ${PSPDEV} ${PSPDEV}
