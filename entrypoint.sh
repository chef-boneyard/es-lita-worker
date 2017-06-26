#!/bin/bash

export SSL_CERT_FILE=$(hab pkg path core/cacerts)/ssl/cert.pem

exec "$@"
