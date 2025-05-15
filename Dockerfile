FROM rabbitmq:3.12.14-management-alpine

ARG RABBITMQ_DEFAULT_USER RABBITMQ_DEFAULT_PASS RABBITMQ_DEFAULT_VHOST

RUN rabbitmq-plugins enable --offline rabbitmq_mqtt rabbitmq_federation_management rabbitmq_stomp

COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf

# Copy cert gen script and entrypoint
COPY rabbitmq-ssl-init.sh /usr/local/bin/rabbitmq-ssl-init.sh
RUN chmod +x /usr/local/bin/rabbitmq-ssl-init.sh && /usr/local/bin/rabbitmq-ssl-init.sh
RUN /usr/local/bin/rabbitmq-ssl-init.sh
