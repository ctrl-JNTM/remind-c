FROM openjdk:8-jre-alpine

ENV LANG="C.UTF-8"
ENV app_name="remind-c"
ENV app_version="1.0.0-SNAPSHOT"

USER root

ENV REMIND_USER="remind"

ENV work_dir="/home/$REMIND_USER/$app_name"

RUN mkdir -p $work_dir

EXPOSE 8081


COPY  ./build/libs/${app_name}-${app_version}.jar  $work_dir

WORKDIR $work_dir

ENTRYPOINT ["sh","-c","java  -jar  ${work_dir}/${app_name}-${app_version}.jar"]



