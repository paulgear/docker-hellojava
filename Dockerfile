ARG     APPDIR=/opt/HelloJava
ARG     SOURCE_REGISTRY

FROM ${SOURCE_REGISTRY}openjdk:11 AS build-env

# FROM    debian:stable-slim as build-env

# ARG     PKGS=openjdk-11-jdk
# ENV     AUTOREMOVE="-o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false"

# RUN     apt update && \
#         apt install -y --no-install-recommends ${PKGS} && \
#         apt upgrade -y && \
#         apt autoremove --purge -y ${AUTOREMOVE} && \
#         rm -rf /var/lib/apt/lists/*

ARG     APPDIR
ARG     MAINCLASS=HelloJava

WORKDIR ${APPDIR}
COPY    ${MAINCLASS}.java ./
RUN     javac *.java
RUN     jar cfe main.jar ${MAINCLASS} *.class
# RUN     ls -la ${APPDIR}/

FROM    ${SOURCE_REGISTRY}openjdk-jre:11

ARG     APPDIR

WORKDIR ${APPDIR}
COPY    --from=build-env ${APPDIR}/main.jar ./
# RUN     ls -la ${APPDIR}/

ENTRYPOINT ["java"]
CMD     ["-jar", "main.jar"]
