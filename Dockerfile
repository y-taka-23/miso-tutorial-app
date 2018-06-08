FROM fpco/stack-build:lts-7.19 AS builder

WORKDIR /usr/lib/gcc/x86_64-linux-gnu/5.4.0
RUN cp crtbeginT.o crtbeginT.o.orig
RUN cp crtbeginS.o crtbeginT.o

COPY ./ /work
WORKDIR /work

RUN stack setup --stack-yaml client/stack.yaml
RUN stack build --stack-yaml client/stack.yaml
RUN cp /work/client/.stack-work/install/x86_64-linux/lts-7.19/ghcjs-0.2.1.9007019_ghc-8.0.1/bin/miso-tutorial-app-client.jsexe/all.js \
       /sbin/

RUN stack install \
    --stack-yaml server/stack.yaml \
    --local-bin-path /sbin \
    --system-ghc \
    --ghc-options '-optl-static -fPIC -optc-Os'


FROM alpine:3.7

RUN mkdir /static
COPY --from=builder /sbin/miso-tutorial-app-server /
COPY --from=builder /sbin/all.js /static/

EXPOSE 4000
CMD ["/miso-tutorial-app-server"]