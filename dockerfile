# Dockerfile
FROM ghcr.io/open-webui/open-webui:main

USER root

# 1) Install PowerShell on Debian/Ubuntu base
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
       curl \
       apt-transport-https \
       gnupg2 \
  && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft.gpg \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" \
       > /etc/apt/sources.list.d/microsoft.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends powershell \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# 2) Copy in your custom scripts folder
COPY ./scripts /app/scripts

# 3) Switch back to default user
USER $UID:$GID