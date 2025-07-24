FROM n8nio/n8n

ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=mypassword
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http

WORKDIR /home/node/

# Create backup.sh directly and make it executable
RUN echo '#!/bin/bash\n\
cd /home/node/.n8n || exit 1\n\
git config user.name "n8n-bot"\n\
git config user.email "bot@n8n.local"\n\
git remote remove origin 2>/dev/null\n\
git remote add origin https://github.com/Ntwali-Wilson/n8n-data-store.git\n\
git add .\n\
git commit -m "n8n backup $(date +%Y-%m-%d_%H-%M-%S)" || echo "No changes to commit"\n\
git push -f origin master' > /home/node/backup.sh && chmod +x /home/node/backup.sh

EXPOSE 5678

# Run n8n explicitly
ENTRYPOINT ["/tini", "--"]
CMD ["n8n"]
