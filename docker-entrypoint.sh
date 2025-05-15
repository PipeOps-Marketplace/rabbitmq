# docker-entrypoint.sh
#!/bin/sh
set -e

/usr/local/bin/rabbitmq-ssl-init.sh

exec docker-entrypoint.sh "$@"
