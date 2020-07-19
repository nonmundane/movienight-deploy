#!/bin/bash

if [ $# -lt 1 ]; then
	echo 1>&2 "$0: not enough arguments"
	exit 2
fi

domain=$1

aws route53 list-hosted-zones | jq -r --arg dn $domain '.HostedZones[] |select(.Name | contains($dn)) | .Id'