# certbot-godaddy-cleanup.sh -- A Certbot cleanup callback script
#
# Copyright (C) 2019 Martijn Veldpaus
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.

source $(dirname $(readlink -f $0))/api-settings.sh

DNS_REC_TYPE=TXT
DNS_REC_NAME="_acme-challenge"
DNS_REC_DATA="$CERTBOT_VALIDATION"

echo Replacing ${DNS_REC_TYPE} records for ${DNS_REC_NAME}.${CERTBOT_DOMAIN} with 'park' values
curl    -i \
        -X PUT \
        "${GODADDY_URL}/v1/domains/${CERTBOT_DOMAIN}/records/${DNS_REC_TYPE}/${DNS_REC_NAME}" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -H "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" \
        -d "[{\"data\": \"...\", \"name\": \"${DNS_REC_NAME}\", \"type\": \"${DNS_REC_TYPE}\", \"ttl\": 600}]"
