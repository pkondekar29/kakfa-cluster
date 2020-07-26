FROM openjdk:8u262

USER root

WORKDIR /usr/tools

COPY start-zookeeper.sh .

RUN chmod +x start-zookeeper.sh && \
    apt-get install wget tar && \
    wget http://apachemirror.wuchna.com/kafka/2.5.0/kafka_2.12-2.5.0.tgz && \
    tar -xvf 777 kafka_2.12-2.5.0.tgz && \
    rm kafka_12-2.5.0.tgz && \
    chmod -R 777 kafka_2.12-2.5.0

ENV KAFKA_HOME /usr/tools/kakfa_2.12-2.5.0 
ENV PATH=${PATH}:${KAFKA_HOME}/bin

CMD ["sh", "start-zookeeper.sh"]
