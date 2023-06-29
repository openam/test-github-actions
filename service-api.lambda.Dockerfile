#
#
# base container layer with generic tools and packages
# to build all services APIs
FROM node:16-alpine as base

RUN apk add --no-cache python3 make g++ cairo-dev pango-dev jpeg-dev giflib-dev librsvg-dev

# ARG PACKAGES_ACCESS_TOKEN
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

WORKDIR /var/task

# setup of basic npm packages is worth caching so put them on a new layer
# custom packages are changed most often but it's still beneficial to cache them
# cause all service containers will be based of this layer
COPY package.json .npmrc package-lock.json ./
# COPY /packages ./packages
RUN npm ci

# build typescript
# COPY lerna.json tsconfig.json tsconfig.base.json ./
# RUN npm run build

# #
# #
# # use a new stage for the services APIs so we can build the `base` stage first
# # and then all services containers in parallel by using the cached layers
# FROM base as service

# # api service packages are not changed very often, we can copy
# # package.json and app files and put them on the same layer
# # older version of docker (seed.run) needs PACKAGES_ACCESS_TOKEN duplicated here
# ARG PACKAGES_ACCESS_TOKEN
# ARG SERVICE_NAME
# ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
# COPY /services/${SERVICE_NAME} ./services/${SERVICE_NAME}
# COPY package.json .npmrc package-lock.json ./
# RUN npm ci -w services/${SERVICE_NAME} --omit=dev --omit=optional

# # after install of just service modules should replace symlinks with actual files
# # and remove unneeded test/mock data from our packages
# COPY exclude.lst ./
# COPY .scripts/cleanup.sh ./
# RUN chmod +x cleanup.sh && ./cleanup.sh

# # move to common location for cmd
# RUN mv ./services/${SERVICE_NAME} ./services/api

#
#
# Start production image build
#FROM gcr.io/distroless/nodejs:16
FROM public.ecr.aws/lambda/nodejs:16 as production

ARG WORKDIR=/var/task
WORKDIR ${WORKDIR}

# Copy from builder
COPY --from=base ${WORKDIR}/node_modules ./node_modules
COPY --from=base ${WORKDIR}/services ./services

# Run the container under "node" user by default
USER 1000

# the ENTRYPOINT is defined as 'node' for this image
# no shell involved, so there is no ENV var expansion
CMD ["services/api/index.handler"]
