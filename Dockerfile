ARG     APPDIR=/opt/HelloJava
ARG     SOURCE_REGISTRY

FROM ${SOURCE_REGISTRY}openjdk:11 AS build-env

ARG     APPDIR
ARG     MAINCLASS=HelloJava

WORKDIR ${APPDIR}
COPY    ${MAINCLASS}.java ./
RUN     javac *.java
RUN     jar cfe main.jar ${MAINCLASS} *.class

FROM    ${SOURCE_REGISTRY}java:11

ARG     APPDIR

WORKDIR ${APPDIR}
COPY    --from=build-env ${APPDIR}/main.jar ./

ENTRYPOINT ["java"]
CMD     ["-jar", "main.jar"]
