FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /betteropinions-app/betteropinions

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY . /betteropinions-app

RUN ls -la /betteropinions-app && ls -la /betteropinions-app/betteropinions

EXPOSE 8000

CMD ["gunicorn", "betteropinions.wsgi:application", "--bind", "0.0.0.0:8000"]
