FROM openjdk:8u262

USER root

WORKDIR /usr/tools

RUN apt-get install wget tar && \
    wget http://apachemirror.wuchna.com/kafka/2.5.0/kafka_2.12-2.5.0.tgz && \
    tar -xvf kafka_2.12-2.5.0.tgz && \
    rm kafka_2.12-2.5.0.tgz 

ENV KAFKA_HOME /usr/tools/kakfa_2.12-2.5.0 
ENV PATH=${PATH}:${KAFKA_HOME}/bin

CMD ["sleep", "1d"]
