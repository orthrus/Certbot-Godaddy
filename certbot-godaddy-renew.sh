#!/bin/bash

# certbot-godaddy-renew.sh -- A script to renew new Let's Encrypt wildcard certificates
#
# Copyright (C) 2019 Martijn Veldpaus
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.

SCRIPTDIR=$(dirname $(readlink -f $0))
source $SCRIPTDIR/api-settings.sh

certbot renew \
        --non-interactive \
        --agree-tos \
        --manual-public-ip-logging-ok \
        -m $EMAIL \
        --preferred-challenges dns \
        --manual \
        --manual-auth-hook $SCRIPTDIR/certbot-godaddy-auth.sh \
        --manual-cleanup-hook $SCRIPTDIR/certbot-godaddy-cleanup.sh \
        --post-hook $SCRIPTDIR/certbot-renew-post-hook.sh \
        --cert-name ${DOMAIN}
