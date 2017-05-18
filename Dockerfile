FROM openjdk:8-alpine

# Configuration variables.
ENV FISHEYE_VERSION=4.4.1 \
    FISHEYE_HOME=/var/atlassian/application-data/fisheye \
    FISHEYE_INSTALL=/opt/atlassian/fisheye \
    MYSQL_VERSION=5.1.38

RUN set -x
RUN apk add --no-cache libressl
RUN apk add --no-cache wget
RUN apk add --no-cache tar
RUN apk add --no-cache bash
RUN apk add --no-cache unzip

RUN mkdir -p "${FISHEYE_HOME}"
RUN mkdir -p "${FISHEYE_INSTALL}"

RUN wget -O "atlassian-fisheye-${FISHEYE_VERSION}.zip" --no-verbose "https://www.atlassian.com/software/fisheye/downloads/binary/fisheye-${FISHEYE_VERSION}.zip"
RUN wget -O "mysql-connector-java-${MYSQL_VERSION}.tar.gz" --no-verbose "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_VERSION}.tar.gz"

RUN unzip -o atlassian-fisheye-${FISHEYE_VERSION}.zip -d /tmp
RUN yes | cp -rf /tmp/fecru-${FISHEYE_VERSION}/* ${FISHEYE_INSTALL}/.
RUN tar -xzvf "mysql-connector-java-${MYSQL_VERSION}.tar.gz" -C "${FISHEYE_INSTALL}/lib" --strip-components=1

RUN rm -rf /tmp/fecru-${FISHEYE_VERSION}/*.*
RUN rm -rf "mysql-connector-java-${MYSQL_VERSION}.tar.gz"
RUN rm -rf "atlassian-fisheye-${FISHEYE_VERSION}.zip"

# Add user and setup permissions
RUN adduser -D -u 1000 fisheye
RUN chown -R fisheye "${FISHEYE_HOME}"
RUN chown -R fisheye "${FISHEYE_INSTALL}"
RUN chmod -R 700 "${FISHEYE_HOME}"
RUN chmod -R 700 "${FISHEYE_INSTALL}"

# Expose default HTTP connector port.
EXPOSE 8060

VOLUME [ "${FISHEYE_HOME}" ]

WORKDIR ${FISHEYE_INSTALL}

USER fisheye

ENTRYPOINT ["bin/fisheyectl.sh", "run"]
