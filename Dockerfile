FROM rabbitmq:3.12.14-management-alpine

ARG RABBITMQ_DEFAULT_USER RABBITMQ_DEFAULT_PASS RABBITMQ_DEFAULT_VHOST

RUN rabbitmq-plugins enable --offline rabbitmq_mqtt rabbitmq_federation_management rabbitmq_stomp

COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf

COPY rabbitmq-ssl-init.sh /usr/local/bin/rabbitmq-ssl-init.sh
RUN chmod +x /usr/local/bin/rabbitmq-ssl-init.sh

# Override entrypoint to generate certs before starting RabbitMQ
ENTRYPOINT ["/bin/sh", "-c", "/usr/local/bin/rabbitmq-ssl-init.sh && rabbitmq-server"]
