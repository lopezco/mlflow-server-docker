#!/bin/bash
set -e

if [ "${ENABLE_AUTO_DB_MIGRATIONS}" = "1" ]; then
    echo "Automatic DB migrations: enabled"
    mlflow db upgrade ${MLFLOW_BACKEND_STORE_URI}
else
    echo "Automatic DB migrations: disabled"
fi

echo "Running command..."
exec "$@"
