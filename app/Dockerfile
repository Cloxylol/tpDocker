FROM alpine:3.19

RUN apk add --no-cache python3 py3-pip curl

WORKDIR /app

COPY requirements.txt .

RUN python3 -m venv /app/venv \
 && . /app/venv/bin/activate \
 && pip install --upgrade pip \
 && pip install -r requirements.txt

COPY src/ /app

EXPOSE 4743

ENV PATH="/app/venv/bin:$PATH"

CMD ["python3", "app.py"]