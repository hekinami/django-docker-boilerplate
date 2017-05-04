FROM python:3
ARG HOST_UID=1000
ARG HOST_GID=1000
ENV DJANGO_USER_UID=$HOST_UID
ENV DJANGO_USER_GID=$HOST_GID
RUN /bin/bash -c "groupadd -g ${DJANGO_USER_GID} django" && \
    /bin/bash -c "useradd -m -u ${DJANGO_USER_UID} -g ${DJANGO_USER_GID} django"

ENV PYTHONUNBUFFERED 1
USER django
RUN mkdir /home/django/application
WORKDIR /home/django/application
ADD requirements.txt /home/django/application
USER root
RUN pip install -r requirements.txt
USER django
ADD . /home/django/application/
