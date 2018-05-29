#!/bin/bash -e

CLIENT_STACK_OPTION="--stack-yaml=client/stack.yaml"
SERVER_STACK_OPTION="--stack-yaml=server/stack.yaml"

CLIENT_INSTALL_ROOT=$(stack path --local-install-root ${CLIENT_STACK_OPTION})
SERVER_INSTALL_ROOT=$(stack path --local-install-root ${SERVER_STACK_OPTION})

SERVER_STATIC_DIR=server/static

stack setup ${CLIENT_STACK_OPTION}
stack build ${CLIENT_STACK_OPTION}

mkdir -p ${SERVER_STATIC_DIR}
cp ${CLIENT_INSTALL_ROOT}/bin/miso-tutorial-app-client.jsexe/all.js \
   ${SERVER_STATIC_DIR}/all.js

stack setup ${SERVER_STACK_OPTION}
stack build ${SERVER_STACK_OPTION}
cd server && ${SERVER_INSTALL_ROOT}/bin/miso-tutorial-app-server
