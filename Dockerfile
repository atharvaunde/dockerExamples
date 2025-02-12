FROM node:20-alpine AS build-env
WORKDIR /app
COPY package.json yarn.lock ./
ENV NODE_ENV=production
RUN yarn install --frozen-lockfile --production
COPY index.js ./

FROM gcr.io/distroless/nodejs20-debian12
WORKDIR /app
LABEL org.opencontainers.image.authors="authoremail@example.com"
LABEL "com.example.vendor"="Example LLC"
LABEL version="1.0.0"
LABEL description="This image is used to run hello world backend written in Express Framework"
COPY --from=build-env /app /app
CMD ["index.js"]
