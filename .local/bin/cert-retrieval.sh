#! /bin/bash
# Original credit: https://unix.stackexchange.com/a/487546

SITE="$1"

openssl s_client -showcerts -verify 5 -connect $SITE:443 < /dev/null |
   awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/{ if(/BEGIN CERTIFICATE/){a++}; out="cert"a".pem"; print >out}'

# Rename with common name from subject line (w/ formatting)
for CERT in *.pem; do 
	NEWNAME=$(openssl x509 -noout -subject -in $CERT | sed -nE 's/.*CN ?= ?(.*)/\1/; s/[ ,.*]/_/g; s/__/_/g; s/_-_/-/; s/^_//g;p' | tr '[:upper:]' '[:lower:]').crt
	echo "Writing: ${NEWNAME}"
	mv "${CERT}" "${NEWNAME}" 
done
