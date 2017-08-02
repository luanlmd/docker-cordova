FROM ubuntu:xenial

MAINTAINER Luan Almeida <luanlmd@gmail.com>

RUN apt update
RUN apt upgrade -y
RUN apt install software-properties-common unzip nodejs npm -y
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install cordova -g

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt update

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt install oracle-java8-installer -y
RUN apt install gradle -y

RUN apt clean

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O sdk.zip
RUN unzip sdk.zip -d /usr/local/android-sdk
RUN rm sdk.zip

RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip -O sdk.zip
RUN unzip sdk.zip -d /usr/local/android-sdk
RUN rm sdk.zip

ENV GRADLE_USER_HOME /src/gradle
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin

RUN echo y | sdkmanager "platforms;android-25"
RUN echo y | sdkmanager "platforms;android-26"
RUN echo y | sdkmanager "build-tools;26.0.1"

RUN cordova telemetry off

VOLUME /src
WORKDIR /src

CMD ["bash"]
