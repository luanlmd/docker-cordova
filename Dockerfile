FROM ubuntu:xenial

MAINTAINER Luan Almeida <luanlmd@gmail.com>

RUN apt update
RUN apt upgrade -y
RUN apt install software-properties-common unzip nodejs npm -y
RUN apt install wget -y
RUN apt clean

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm i cordova -g

RUN wget http://download.java.net/java/jdk8u152/archive/b05/binaries/jdk-8u152-ea-bin-b05-linux-x64-20_jun_2017.tar.gz -O smelly.tar.gz
RUN tar -xvzf smelly.tar.gz -C /usr/local
RUN rm smelly.tar.gz

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O sdk.zip
RUN unzip sdk.zip -d /usr/local/android-sdk
RUN rm sdk.zip

RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip -O sdk.zip
RUN unzip sdk.zip -d /usr/local/android-sdk
RUN rm sdk.zip

ENV JAVA_HOME /usr/local/jdk1.8.0_152
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$JAVA_HOME:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin

RUN echo y | sdkmanager "platforms;android-25"
RUN echo y | sdkmanager "platforms;android-26"
RUN echo y | sdkmanager "build-tools;26.0.1"

RUN cordova telemetry off

RUN cordova create test
RUN cd test && cordova platform add android && cordova build
RUN rm -Rf test

VOLUME /src
WORKDIR /src

CMD ["cordova"]
