#!/bin/bash

# Exit on error
set -euo pipefail

# Set up directory
SSL_DIR="/etc/rabbitmq/ssl"

SERVER_KEY="$SSL_DIR/server.key"
SERVER_CRT="$SSL_DIR/server.crt"
SERVER_CSR="$SSL_DIR/server.csr"

CA_KEY="$SSL_DIR/ca.key"
CA_CRT="$SSL_DIR/ca.crt"
V3_EXT="$SSL_DIR/v3.ext"

# Create directory and secure it
mkdir -p "$SSL_DIR"
chmod 700 "$SSL_DIR"

# Generate CA
openssl req -new -x509 -days "${SSL_CERT_DAYS:-820}" -nodes -text \
  -out "$CA_CRT" -keyout "$CA_KEY" -subj "/CN=RabbitMQ-Root-CA"

chmod 600 "$CA_KEY"

# Generate server key and CSR
openssl req -new -nodes -text -out "$SERVER_CSR" -keyout "$SERVER_KEY" \
  -subj "/CN=localhost"

chmod 600 "$SERVER_KEY"

# Create v3 extension config
cat > "$V3_EXT" <<EOF
[v3_req]
authorityKeyIdentifier = keyid, issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
EOF

# Sign server cert with CA
openssl x509 -req -in "$SERVER_CSR" -CA "$CA_CRT" -CAkey "$CA_KEY" \
  -CAcreateserial -out "$SERVER_CRT" -days "${SSL_CERT_DAYS:-820}" \
  -extfile "$V3_EXT" -extensions v3_req

chmod 644 "$SERVER_CRT"
