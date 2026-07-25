#Estagio 1
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

#Estagio 2
FROM node:20-alpine
WORKDIR /app

COPY --chown=node:node --from=builder /app/node_modules ./node_modules
COPY --chown=node:node --from=builder /app/package.json ./
COPY --chown=node:node --from=builder /app/src ./src

RUN mkdir -p /etc/todos && chown -R node:node /etc/todos
#RUN mkdir -p /app/uploads && chown -R node:node /app


EXPOSE 3000
USER node
CMD ["node", "src/index.js"]