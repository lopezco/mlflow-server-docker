#!/bin/bash
set -e

if [ "${AUTO_DB_MIGRATIONS}" = "1" ]; then
    echo "Automatic DB migrations: enabled"
    mlflow db upgrade ${AUTO_DB_MIGRATIONS}
else
    echo "Automatic DB migrations: disabled"
fi

echo "Running command..."
exec "$@"
