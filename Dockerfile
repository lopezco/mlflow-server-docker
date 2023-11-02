FROM python:3.10-slim-buster
WORKDIR /app

ENV GUNICORN_TIMEOUT=600

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install libyaml-cpp-dev libyaml-dev dos2unix -y \
    # Reinstall PyYAML
    && pip install -U pip \
    && pip --no-cache-dir install --force-reinstall -I pyyaml

# Required libraries
COPY requirements.txt /app
RUN pip install -r requirements.txt

# Ensure correct line endings
COPY entrypoint.sh /app
RUN chmod +x ./entrypoint.sh
    && dos2unix ./entrypoint.sh \
    && apt-get --purge remove -y dos2unix \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ./entrypoint.sh
CMD mlflow server --host 0.0.0.0
