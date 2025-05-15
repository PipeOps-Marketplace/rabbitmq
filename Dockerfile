FROM rabbitmq:3.12.14-management-alpine

ARG RABBITMQ_DEFAULT_USER RABBITMQ_DEFAULT_PASS RABBITMQ_DEFAULT_VHOST

RUN rabbitmq-plugins enable --offline rabbitmq_mqtt rabbitmq_federation_management rabbitmq_stomp

COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf










# TODO: Enable SSL for this rabbitMQ addon


# FROM rabbitmq:3.12.14-management-alpine

# ARG RABBITMQ_DEFAULT_USER RABBITMQ_DEFAULT_PASS RABBITMQ_DEFAULT_VHOST

# RUN rabbitmq-plugins enable --offline rabbitmq_mqtt rabbitmq_federation_management rabbitmq_stomp

# COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
# COPY rabbitmq-ssl-init.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/rabbitmq-ssl-init.sh

# # Replace entrypoint to generate certs at runtime
# COPY docker-entrypoint.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
