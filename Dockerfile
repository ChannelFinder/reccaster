# Download Epics
FROM --platform=$BUILDPLATFORM debian:bookworm-slim AS epics-download-extract
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install --no-install-recommends -yq ca-certificates wget git
WORKDIR /var/cache
ARG EPICSVERSION=7.0.9
RUN wget -q --show-progress "https://epics-controls.org/download/base/base-$EPICSVERSION.tar.gz" \
&& mkdir /epics/ \
&& tar -xf "base-$EPICSVERSION.tar.gz" -C /epics \
&& rm "base-$EPICSVERSION.tar.gz"

FROM --platform=$BUILDPLATFORM debian:bookworm-slim AS base

FROM base AS base-amd64
ENV EPICS_HOST_ARCH=linux-x86_64

FROM base AS base-386
ENV EPICS_HOST_ARCH=linux-x86

FROM base AS base-arm64
ENV EPICS_HOST_ARCH=linux-arm

FROM base AS base-arm
ENV EPICS_HOST_ARCH=linux-arm

# Now finally choose the right base image:
FROM base-$TARGETARCH AS build-epics
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install --no-install-recommends -yq \
  build-essential \
  ca-certificates \
  curl \
  libreadline-dev \
  telnet \
 && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt

WORKDIR /epics
COPY --from=epics-download-extract /epics /epics
ARG EPICSVERSION=7.0.9
RUN mv "base-$EPICSVERSION" base && make -C base -j"$(nproc)"

FROM build-epics AS reccaster-base

WORKDIR /reccaster
COPY . /reccaster/
ENV EPICS_ROOT=/epics
ENV EPICS_BASE=${EPICS_ROOT}/base
RUN echo "EPICS_BASE=${EPICS_BASE}" > configure/RELEASE.local
RUN make

FROM reccaster-base AS ioc-runner

WORKDIR /reccaster/bin/${EPICS_HOST_ARCH}

CMD ./demo /reccaster/iocBoot/iocdemo/st.cmd
