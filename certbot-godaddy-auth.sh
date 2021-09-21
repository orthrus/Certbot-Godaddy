# certbot-godaddy-auth.sh -- A Certbot Authentication callback script
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

echo Creating ${DNS_REC_TYPE} record ${DNS_REC_NAME}.${CERTBOT_DOMAIN} for certificate renewal with value ${DNS_REC_DATA}

curl    -i \
        -X PATCH \
        "${GODADDY_URL}/v1/domains/${CERTBOT_DOMAIN}/records" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -H "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" \
        -d "[{\"data\": \"${DNS_REC_DATA}\", \"name\": \"${DNS_REC_NAME}\", \"type\": \"${DNS_REC_TYPE}\", \"port\": 65535, \"priority\": 0, \"ttl\": 600, \"weight\": 0, \"protocol\": \"string\", \"service\": \"string\"}]"       

sleep 30s
