FROM n8nio/n8n

# Basic auth and server config
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=mypassword
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http

# Copy and create backup.sh inside the container
RUN echo '#!/bin/bash\n\
cd /home/node/.n8n\n\
git init\n\
git config user.name "n8n-bot"\n\
git config user.email "bot@n8n.local"\n\
git remote remove origin 2>/dev/null\n\
git remote add origin https://github.com/Ntwali-Wilson/n8n-data-store.git\n\
git add .\n\
git commit -m "n8n backup $(date +%Y-%m-%d_%H-%M-%S)" || echo "No changes to commit"\n\
git push -f origin master' > /home/node/backup.sh && \
chmod +x /home/node/backup.sh

# Optional: run backup once on container start (can be removed if not needed)
CMD bash /home/node/backup.sh && n8n

EXPOSE 5678
