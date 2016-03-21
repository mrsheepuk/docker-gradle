FROM java:8-jdk
MAINTAINER Nicholas Iaquinto <nickiaq@gmail.com>

# Gradle
ENV GRADLE_VERSION 2.7
ENV GRADLE_SHA cde43b90945b5304c43ee36e58aab4cc6fb3a3d5f9bd9449bb1709a68371cb06
ENV HTTP_PROXY http://10.80.142.21:8082/
ENV HTTPS_PROXY http://10.80.142.21:8082/

RUN cd /usr/lib \
 && curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
 && echo "$GRADLE_SHA gradle-bin.zip" | sha256sum -c - \
 && unzip "gradle-bin.zip" \
 && ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-bin.zip" \
 && mkdir -p /usr/src/app

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/lib/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Caches
VOLUME /root/.gradle/caches
VOLUME /usr/src/app

# Default command is "/usr/src/gradle -version" on /usr/src/app dir
# (ie. Mount project at /usr/src/app "docker --rm -v /path/to/app:/usr/src/app gradle <command>")
WORKDIR /usr/src/app
ENTRYPOINT gradle
CMD -version
