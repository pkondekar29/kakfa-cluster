FROM openjdk:8u212-jre-alpine

USER root

ENV KAFKA_VERSION=2.5.0 \
    SCALA_VERSION=2.12 \
    KAFKA_HOME=/opt/kafka \
    GLIBC_VERSION=2.31-r0

ENV PATH=${PATH}:${KAFKA_HOME}/bin

RUN apk add --no-cache bash curl jq && \
    wget http://apachemirror.wuchna.com/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar -xvf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
    rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} && \
    chmod a+x /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/bin/*.sh && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && \
    apk add --no-cache --allow-untrusted glibc-${GLIBC_VERSION}.apk && \
    rm glibc-${GLIBC_VERSION}.apk && \
    mkdir -p ${KAFKA_HOME}/scripts

COPY ./scripts/* ${KAFKA_HOME}/scripts/

WORKDIR ${KAFKA_HOME}

RUN rm -rf config/

# These configs are the predefined configs present which comes with kafka
COPY ./config/* config/

RUN chmod a+x ${KAFKA_HOME}/scripts/*.sh

WORKDIR ${KAFKA_HOME}/scripts

CMD ["echo 'Starting kafka' &&"]