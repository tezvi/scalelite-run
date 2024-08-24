#!/bin/bash

CERT_FILE=/opt/scalelite-run/data/certbot/conf/live/meet.bbb.lms.mef.hr/cert.pema
THRESHOLD_SECONDS=172800

cd "$(dirname "$0")"

if [ ! -f "$CERT_FILE" ]; then
   echo "Could not read certificate file '$CERT_FILE'"
   exit 1
fi

if ! openssl x509 -checkend $THRESHOLD_SECONDS -noout -in $CERT_FILE; then
  echo "Certificate will expire in two days, renewing..."
  /opt/scalelite-run/init-letsencrypt.sh -n -r
fi
