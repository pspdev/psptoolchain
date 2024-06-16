# ARGS for defining tags
ARG  BASE_DOCKER_ALLEGREX_IMAGE
ARG  BASE_DOCKER_EXTRA_IMAGE

# Allegrex stage of Dockerfile
FROM $BASE_DOCKER_ALLEGREX_IMAGE

RUN mv ${PSPDEV}/build.txt ${PSPDEV}/build0.txt

# Extra stage of Dockerfile
FROM $BASE_DOCKER_EXTRA_IMAGE

RUN mv ${PSPDEV}/build.txt ${PSPDEV}/build1.txt

# Second stage of Dockerfile
FROM alpine:latest  

ENV PSPDEV /usr/local/pspdev
ENV PATH $PATH:${PSPDEV}/bin

COPY --from=0 ${PSPDEV} ${PSPDEV}
COPY --from=1 ${PSPDEV} ${PSPDEV}

RUN cat ${PSPDEV}/build0.txt ${PSPDEV}/build1.txt > ${PSPDEV}/build.txt && \
    rm ${PSPDEV}/build0.txt ${PSPDEV}/build1.txt && \
    apk add --no-cache git && \
    git log -1 --format="psptoolchain %H %cs" >> ${PSPDEV}/build.txt
