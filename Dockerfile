# ARGS for defining tags
ARG  BASE_DOCKER_ALLEGREX_IMAGE
ARG  BASE_DOCKER_EXTRA_IMAGE

# Allegrex stage of Dockerfile
FROM $BASE_DOCKER_ALLEGREX_IMAGE

# Extra stage of Dockerfile
FROM $BASE_DOCKER_EXTRA_IMAGE

# Second stage of Dockerfile
FROM alpine:latest  

ENV PSPDEV /usr/local/pspdev
ENV PATH $PATH:${PSPDEV}/bin

COPY --from=0 ${PSPDEV} ${PSPDEV}
COPY --from=1 ${PSPDEV} ${PSPDEV}