FROM n8nio/n8n

ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=mypassword
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http

COPY backup.sh /home/node/backup.sh
RUN chmod +x /home/node/backup.sh

EXPOSE 5678

CMD ["n8n"]
