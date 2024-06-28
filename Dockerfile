ARG BASE_IMG
FROM ${BASE_IMG}

USER root
WORKDIR /

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY --chmod=755 assets/build/ ./

RUN /setup.sh

WORKDIR /workspace

ARG DEFAULT_WHL
ARG SD_NEXT_COMMIT
RUN /sdnext-setup.sh

COPY --chmod=755 assets/workspace/ ./

COPY --chmod=755 assets/scripts/ /

COPY --chmod=755 assets/jupyter/ /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/

ARG NIGHTLY_WHL
ENV NIGHTLY_COMMAND="--pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/${NIGHTLY_WHL}"
ENV HF_HUB_ENABLE_HF_TRANSFER=1

LABEL org.opencontainers.image.source https://github.com/Yoinky3000/sd-next-docker
LABEL org.opencontainers.image.description "A docker image to automatically setup everything you needed to run SD Next in a container"

CMD /jupyter-start.sh