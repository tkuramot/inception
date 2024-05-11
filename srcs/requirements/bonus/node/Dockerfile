FROM node:16-alpine3.15
WORKDIR /app

RUN corepack enable && corepack prepare pnpm@8.15.6 --activate

COPY package.json pnpm-lock.yaml ./
RUN pnpm install

COPY . .
RUN pnpm build
