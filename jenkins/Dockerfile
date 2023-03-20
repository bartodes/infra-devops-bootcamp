FROM node:18.15-alpine as builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

FROM node:18.15-alpine
WORKDIR /app
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/test /app/test
COPY --from=builder /app/src /app/src
COPY package*.json .
COPY tsconfig*.json .
CMD ["npm", "run", "start"]