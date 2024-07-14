# образ на основе которого создаём контейнер
FROM python:3.12.4-alpine

# рабочая директория внутри проекта
WORKDIR /usr/src/app

# переменные окружения
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Устанавливаем зависимости для Postgre
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

RUN addgroup -S app && adduser -S app -G app

ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/static
RUN mkdir $APP_HOME/media:
WORKDIR $APP_HOME


# устанавливаем зависимости
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

RUN apk update && apk add libpq
# копируем содержимое текущей папки в контейнер
COPY . .
ENTRYPOINT ["/home/app/web/entrypoint.sh"]