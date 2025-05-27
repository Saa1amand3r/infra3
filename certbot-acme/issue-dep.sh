#!/bin/sh

export DuckDNS_Token="24267485-4144-497c-b784-c3c7bb074cef"
export LE_WORKING_DIR=/acme.sh

acme.sh --set-default-ca --server letsencrypt
acme.sh --issue --dns dns_duckdns -d eg-quotes-dep.duckdns.org --dnssleep 30
acme.sh --install-cert -d eg-quotes-dep.duckdns.org \
  --key-file /acme.sh/live/eg-quotes-dep.duckdns.org/privkey.pem \
  --fullchain-file /acme.sh/live/eg-quotes-dep.duckdns.org/fullchain.pem
