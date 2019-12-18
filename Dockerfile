FROM amazoncorretto:8

ENV LANG="C.UTF-8"
ENV app_name = "remind-c"
ENV app_version = "1.0.0-SNAPSHOT"

USER root

ENV REMIND_USER="remind"
ENV REMIND_GROUP=${REMIND_USER}-group
RUN groupadd ${STREAMS_GROUP} && useradd -r -g ${STREAMS_GROUP} ${STREAMS_USER}

USER $STREAMS_USER

ENV work_dir="/home/$REMIND_USER/$app_name"

EXPOSE 8081

COPY  ./build/libs/${app_name}-${app_version}.jar  $work_dir

WORKDIR $work_dir

ENTRYPOINT ["sh","-c","java  -jar  ${work_dir}/${app_name}-${app_version}.jar"]



