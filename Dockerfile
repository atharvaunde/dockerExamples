FROM node:20-alpine AS build-env
WORKDIR /app

COPY package.json yarn.lock ./
ENV NODE_ENV=production
RUN yarn install --frozen-lockfile --production
COPY index.js ./

FROM gcr.io/distroless/nodejs20-debian12
WORKDIR /app

COPY --from=build-env /app /app
CMD ["index.js"]
