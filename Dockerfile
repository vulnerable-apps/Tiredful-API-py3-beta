FROM alpine:latest
MAINTAINER jsvazic@gmail.com
FROM python:3.7

COPY . /app/
WORKDIR /app

RUN pip install --upgrade pip && \
    pip3 install -r /app/requirements.txt

RUN python3 /app/Tiredful_API/manage.py collectstatic --noinput

WORKDIR /app/Tiredful_API/

ENV GUNICORN_WORKER_COUNT=4
ENV GUNICORN_WORKER_TIMEOUT_SEC=60

EXPOSE 8000

CMD gunicorn --bind 0.0.0.0:8000 Tiredful_API.wsgi --workers=$GUNICORN_WORKER_COUNT --timeout=$GUNICORN_WORKER_TIMEOUT_SEC --log-level=debug
