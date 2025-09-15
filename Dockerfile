ARG MLFLOW_VERSION

FROM ghcr.io/mlflow/mlflow:${MLFLOW_VERSION}
WORKDIR /app
COPY requirements.txt /app
COPY entrypoint.sh /app
RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y \
        libyaml-cpp-dev \
        libyaml-dev \
        dos2unix \
    && pip install -U pip \
    # Required libraries \
    && pip --no-cache-dir install --force-reinstall -I -r requirements.txt \
    # Ensure correct line endings
    && chmod +x ./entrypoint.sh \
    && dos2unix ./entrypoint.sh \
    && apt-get --purge remove -y dos2unix \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ./entrypoint.sh
CMD mlflow server --host 0.0.0.0
