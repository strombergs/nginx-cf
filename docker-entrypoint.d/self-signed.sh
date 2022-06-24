#!/bin/sh

set -e

KEY_FILE=/etc/ssl/private/selfsigned.key
CRT_FILE=/etc/ssl/private/selfsigned.crt

if [ ! -f "${KEY_FILE}" ] || [ ! -f "${CRT_FILE}" ]; then
  openssl req -x509 -nodes -days 3652 -subj "/C=/ST=/O=/CN=selfsigned" \
        -addext "subjectAltName=DNS:selfsigned" -newkey rsa:2048 \
        -keyout "${KEY_FILE}" \
        -out "${CRT_FILE}";
else
  echo "Certificate already exists."
fi
