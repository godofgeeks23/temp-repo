FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
RUN apt-get update && \
    apt-get install -y gnupg wget curl poppler-utils && \
    wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    apt-get install google-chrome-stable -y --no-install-recommends && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /app
COPY package*.json ./
RUN npm install --verbose
COPY . .
EXPOSE 3000
CMD node index
