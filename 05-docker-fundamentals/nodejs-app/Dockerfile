FROM node:20-alpine

WORKDIR /app

# manifest first, so this layer stays cached when only the code changes
COPY package.json ./
COPY app.js ./

EXPOSE 3000

CMD ["node", "app.js"]
