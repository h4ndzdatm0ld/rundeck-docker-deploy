ARG RUNDECK_IMAGE

FROM ${RUNDECK_IMAGE} as base

# ENVIRONMENT PARAMS
ENV RDECK_BASE=/home/rundeck

# ADD ALL LOCAL PLUGINS TO THE BUILD
COPY plugins/* ${RDECK_BASE}/libext/
COPY resources/resources.xml ${RDECK_BASE}/projects/

FROM base as final

# UPDATE ENV
USER root

RUN sudo apt-get update -y \
    && apt-get install python3 -y \
    && apt-get install iputils-ping -y \
    && apt-get install net-tools -y
