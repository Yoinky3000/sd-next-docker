ARG BASE_IMG
FROM ${BASE_IMG}

USER root
WORKDIR /

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY --chmod=755 build/ ./

RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  /setup.sh

WORKDIR /workspace

ARG DEFAULT_WHL
ARG SD_NEXT_COMMIT
RUN /sdnext-setup.sh

COPY ./workspace/* ./

COPY --chmod=755 scripts/ /

COPY ["SD Next/", "./SD Next/"]

ARG NIGHTLY_WHL
ENV NIGHTLY_COMMAND="--pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/${NIGHTLY_WHL}"

LABEL org.opencontainers.image.source https://github.com/Yoinky3000/sd-next-docker
LABEL org.opencontainers.image.description "A docker image to automatically setup everything you needed to run SD Next in a container"

CMD /jupyter-start.sh