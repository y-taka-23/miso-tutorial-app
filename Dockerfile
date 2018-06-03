FROM fpco/stack-build:lts-7.19 AS builder

WORKDIR /usr/lib/gcc/x86_64-linux-gnu/5.4.0
RUN cp crtbeginT.o crtbeginT.o.orig
RUN cp crtbeginS.o crtbeginT.o

COPY ./ /work
WORKDIR /work

RUN stack build \
    --system-ghc \
    --local-bin-path \
    --ghc-options '-optl-static -fPIC -optc-Os' \
    /sbin build


FROM alpine:3.7

RUN mkdir /work
COPY --from=builder /sbin/miso-tutorial-app-server /work/

CMD ["/work/miso-tutorial-app-server"]
