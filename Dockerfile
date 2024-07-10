FROM python:3.12.4-alpine

ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache gcc musl-dev linux-headers
WORKDIR /code
# Копирует все файлы из нашего локального проекта в контейнер
COPY . /code
EXPOSE 8001
RUN pip install -r requirements.txt

CMD python manage.py runserver
