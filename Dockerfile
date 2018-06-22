FROM ytaka23/stack-ghcjs:lts-7.19 AS builder

WORKDIR /usr/lib/gcc/x86_64-linux-gnu/5.4.0
RUN cp crtbeginT.o crtbeginT.o.orig
RUN cp crtbeginS.o crtbeginT.o

COPY ./ /work
WORKDIR /work

RUN stack setup --stack-yaml client/stack.yaml
RUN stack build --stack-yaml client/stack.yaml
RUN cp $(stack path --stack-yaml client/stack.yaml --local-install-root)/bin/miso-tutorial-app-client.jsexe/all.js \
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
