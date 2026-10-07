# TaskBoard frontend image (React + Vite, served by Nginx).
# Build context: application/frontend
#   docker build -f docker/frontend.Dockerfile -t taskboard-frontend:1.0.0 application/frontend

# Stage 1: build the static files with Node.js.
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY index.html vite.config.js ./
COPY src ./src
RUN npm run build

# Stage 2: serve the static files with Nginx. Node.js and the source code are not in this image.
FROM nginx:1.31-alpine AS runtime
ARG APP_VERSION=1.0.0
ARG GIT_SHA=local
LABEL org.opencontainers.image.title="taskboard-frontend" \
      org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.revision="${GIT_SHA}"
# Install the latest Alpine security fixes (the security gate blocks fixed HIGH/CRITICAL CVEs).
# Let the non-root "nginx" user (UID 101) run Nginx:
# PID file and temp files go to /tmp, and the user can write the config file that the entrypoint makes from the template.
RUN apk upgrade --no-cache \
    && sed -i -e '/^user /d' -e 's#^pid .*#pid /tmp/nginx.pid;#' /etc/nginx/nginx.conf \
    && sed -i '/^http {/a \    client_body_temp_path /tmp/client_temp;\n    proxy_temp_path /tmp/proxy_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;' /etc/nginx/nginx.conf \
    && rm -f /etc/nginx/conf.d/default.conf \
    && chown -R 101:101 /etc/nginx/conf.d /var/cache/nginx
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build /app/dist /usr/share/nginx/html
ENV BACKEND_URL=http://backend:8000
USER 101
EXPOSE 8080
